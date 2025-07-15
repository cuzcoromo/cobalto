import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/presentation/users/users_providers.dart';
import 'package:prueva/screens/app/agua/components/list__medidor_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'precio_ac_provider.g.dart';

// registro de precio agua consumo
@Riverpod(keepAlive: true)
Future<void> setPrecio(Ref ref, Map<String, dynamic> data, String doc) async {
  final fireStore = ref.read(fireStoreProvider);
  final year = DateTime.now().year;
  final month = DateTime.now().month.toString().padLeft(2, '0');
  final docc = '${doc}_${year}_$month';
  

  final fecha = DateTime.now();

  final newData = {
    ...data,
    'fecha': fecha,
    'isPublished': true,
  };
    // await fireStore.collection('price').doc(doc).set(newData);
    await fireStore.collection('price').doc(docc).set(newData);
}


// registro de medidor
@riverpod
class OnRegister extends _$OnRegister {
  @override
  Future<void> build() async {}

  Future<bool> setOnRegister(Map<String, dynamic> data) async {
    final fireStore = ref.read(fireStoreProvider);
    final userId = data['ci'] as String;
    // crear la referencia al documento de users/<String>
    // final user = await fireStore.collection('users').doc(userId).get();
    final ciRef = fireStore.doc('users/$userId');
    final user = await ciRef.get();
    if (!user.exists) {
      return false;
    }

    final medidorData = <String, dynamic>{...data, 'ci': ciRef};

    await fireStore.collection('medidor').doc(userId).set(medidorData);
    return true;
  }
}


// precio de agua de consumo
// @Riverpod(keepAlive: true)
@riverpod
Stream<Map<String, dynamic>> getPrecio(Ref ref) async* {
  final fireStore = ref.read(fireStoreProvider);
    final query = fireStore
    .collection('price')
    .where('isPublished', isEqualTo: true)
    .where('category', isEqualTo: 'C')
    .orderBy('fecha', descending: true)  // Ordenar por fecha más reciente primero
    .limit(1);   

  await for (final querySnapshot in query.snapshots()) {
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      final data = doc.data();

      yield {
        'id': doc.id,
        ...data,
      };
    }
  }
}



// obtener lista de medidores
@Riverpod(keepAlive: true)
Stream<List<Medidor>> medidorList(Ref ref) async* {
  final fireStore = ref.read(fireStoreProvider);

  await for (final snapshot
      in fireStore
          .collection('medidor')
          .where('isPublished', isEqualTo: true)
          .snapshots()) {
    // Para cada documento de medidor, hacemos un get() de la referencia `ci`
    final List<Medidor> list = await Future.wait(
      snapshot.docs.map((doc) async {
        final data = doc.data();
        final ciRef = data['ci'] as DocumentReference<Map<String, dynamic>>;

        //todo traemos el usuario
        final usersnap = await ciRef.get();
        final userData = usersnap.data();
        // todo devolver la data combinando ambos data
        return Medidor(
          id: doc.id,
          ci: userData?['ci'] ?? '',
          fechaIns: data['fechaIns'] ?? '',
          numMed: data['numMed'],
          nombre: userData?['name'] ?? '',
          apellido: userData?['apellido'] ?? '',
      );
      }),
    );
    yield list;
  }
}

//! Actualizar el medidor
@Riverpod(keepAlive: true)
Future<void> updateMedidor(Ref ref, Map<String, dynamic> data) async{
  final fireStore = ref.read(fireStoreProvider);
  final medidorId = ref.read(selectedMedidorIdProvider);
  final userci  = data['ci'];
  final ciRef = fireStore.doc('users/$userci');
  try {
    if(medidorId != null){
      final user = await ciRef.get();
      if(!user.exists) return;     
      final medidor  = await fireStore.collection('medidor').doc(medidorId).get();

      if(medidor.exists && user.exists){
      final dataUpdate =<String, dynamic>{
        ...data,
        'ci':ciRef,
      };
        await fireStore.collection('medidor').doc(medidorId).update(dataUpdate);
      }

    }    
  } catch (e) {
    throw Exception('Error al actualizar');
  }
}