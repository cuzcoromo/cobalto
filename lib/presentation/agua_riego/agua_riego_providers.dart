import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/users/users_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agua_riego_providers.g.dart';

//todo precio de riogo
@Riverpod(keepAlive: true)
Stream<Map<String, dynamic>> getPriceMto(Ref ref) async* {
  final firestore = ref.read(fireStoreProvider);
  final now = DateTime.now();
  final year = now.year;
  final month = now.month.toString().padLeft(2, '0');
  final doc = 'aguaR_${year}_$month';

  final query = firestore
      .collection('price')
      .where('isPublished', isEqualTo: true)
      .where('category', isEqualTo: 'R')
      .orderBy(
        'fecha',
        descending: true,
      ) // Ordenar por fecha más reciente primero
      .limit(1);

  await for (final querySnapshot in query.snapshots()) {
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      final data = doc.data();

      yield {'id': doc.id, ...data};
    }
  }
}

@riverpod
class RiegoFormControl extends _$RiegoFormControl {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  //todo registro usuario riego
  Future<void> onRegisterAgRie({
    required Map<String, dynamic> data,
    String? id,
  }) async {
    state = const AsyncValue.loading();
    final firestore = ref.read(fireStoreProvider);
    final userCi = data['ci'] as String;
    final userRef = firestore.doc('/users/$userCi');
    final priceRef = firestore.doc('price/aguaR');

    try {
      final user = await userRef.get();
      final price = await priceRef.get();
      if (!user.exists) throw 'Usuario no existe!';
      if (!price.exists) throw 'Precios no definidos';

      // todo actualizacion de datos
      if (id != null) {
        final docRef = firestore.collection('riego').doc(userCi);
        final snapshot = await docRef.get();
        if (!snapshot.exists) throw 'Usuario de riego no registrado';

        final newData = {...data, 'ci': userRef};
        // actualizar el campo de publicacion
        await docRef.update(newData);
        state = const AsyncValue.data(null);
        return;
      }

      //todo registro de usuario
      final userExis =
          await firestore
              .collection('riego')
              // .where('isPublished', isEqualTo: true)
              .where('ci', isEqualTo: userRef)
              .limit(1)
              .get();

      if (userExis.docs.isNotEmpty) {
        throw ('Usuaio ya registrado');
      }
      // si no hay registro
      final newData = {
        ...data,
        'ci': userRef,
        'categoria': priceRef,
        'isPublished': true,
      };
      await firestore.collection('riego').doc(userCi).set(newData);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      final mensaje = e is String ? e : 'Ocurrió un error inesperado';
      state = AsyncValue.error(mensaje, st);
    }
  }
}

// todo listado de usuarios riego
@riverpod
Stream<List<Map<String, dynamic>>> getListUserAgRi(Ref ref) async* {
  final firestore = ref.read(fireStoreProvider);
  await for (final snapshot
      in firestore
          .collection('riego')
          .where('isPublished', isEqualTo: true)
          .snapshots()) {
    final List<Map<String, dynamic>> list = await Future.wait(
      snapshot.docs.map((doc) async {
        final data = doc.data();
        final userRef = data['ci'] as DocumentReference<Map<String, dynamic>>;
        // todo raemos usuario
        final usersnap = await userRef.get();
        final userData = usersnap.data();
        //todo combinamos la data
        return {
          'id': doc.id,
          ...data,
          'ci': userData?['ci'],
          'nombre': userData?['name'],
          'apellido': userData?['apellido'],
        };
      }),
    );
    yield list;
  }
}

//todo eliminar usrio riego
@riverpod
Future<void> deleteAgRie(Ref ref, String? id) async {
  final firestore = ref.read(fireStoreProvider);

  final docRef = firestore.collection('riego').doc(id);
  final snapshot = await docRef.get();
  final data = snapshot.data();
  if (data == null) {
    throw 'Usuario no registrado';
  }
  // actualizar el campo de publicacion
  await docRef.update({'isPublished': false});
}

//Obtener data a editar apra rellegar formulario
@riverpod
Map<String, dynamic> getAgRie(Ref ref, String? id) {
  final dataEdit = ref.watch(getListUserAgRiProvider);

  return dataEdit.when(
    data: (data) => data.firstWhere((element) => element['id'] == id),
    error: (e, stack) => throw 'Error al obtener datos!',
    loading: () => {},
  );
}
