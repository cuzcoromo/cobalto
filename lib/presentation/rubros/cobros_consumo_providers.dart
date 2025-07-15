import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/domain/entities/cobro.dart';
import 'package:prueva/presentation/rubros/cobro_providers.dart';
import 'package:prueva/presentation/users/users_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cobros_consumo_providers.g.dart';

final isBloque = StateProvider<bool>((ref) {
  ref.keepAlive();
  return true;
});

@riverpod
Stream<List<Cobro>> listaCobro(Ref ref) async* {
  final firestore = ref.read(fireStoreProvider);
  final filter = ref.watch(filterOpcionPagoProvider);
  final nombreColeccion = filter.label;

  final mes = DateTime.now().month;
  final anio = DateTime.now().year;
  final fechaRegistro = DateTime.now();

  await for (final snapshot
      in firestore
          .collection(nombreColeccion)
          .where('isPublished', isEqualTo: true)
          .snapshots()) {
    final list = await Future.wait(
      snapshot.docs.map((doc) async {
        final data = doc.data();
        // print(data);
        final userRef = data['ci'] as DocumentReference<Map<String, dynamic>>;
        // usuario
        final userData = await userRef.get();
        final user = userData.data();
        final cobro = Cobro(
          id: doc.id,
          nombre: user?['name'],
          apellido: user?['apellido'],
          usuario_id: userRef,
          anio: anio,
          mes: mes,
          fechaRegistro: fechaRegistro,
          precio_id: null,
          completedAt: null,
        );
        return cobro;
      }),
    );
    yield list;
  }
}

// ! listener que lea es strean y sincroniza la data con el estado correspondiente
@Riverpod(keepAlive: true)
class CobroSyncController extends _$CobroSyncController {
  @override
  void build() {
    ref.listen<AsyncValue<List<Cobro>>>(listaCobroProvider, (prev, next) {
      next.whenData((data) {
        final notifier = ref.read(listActiveProvider.notifier);
        notifier.clear(); // limpa antes de rellenar nuevos datos

        for (final cobro in data) {
          notifier.addItem(cobro);
        }
      });
    });
  }
}

void addItemCompart(
  List<Cobro> state,
  Cobro item,
  void Function(List<Cobro>) setState,
) {
  if (state.any((e) => e.id == item.id)) return;
  setState([...state, item]);
}

//todo listdo de usrio de medidores
@Riverpod(keepAlive: true)
class ListActive extends _$ListActive {
  @override
  List<Cobro> build() => [];

  void addItem(Cobro item) {
    addItemCompart(state, item, (newState) => state = newState);
  }

  // modificar solo el estado de pagado
  void updateItem(String? userid, String precioid) {
    final ref = FirebaseFirestore.instance.doc('price/$precioid');

    state =
        state.map((todo) {
          if (todo.id == userid) {
            return todo.copyWith(
              precio_id: ref,
              completedAt: todo.done ? null : DateTime.now(),
            );
          }
          return todo;
        }).toList();
  }

  void clear() {
    state = [];
  }
}

//todo filtrado
@Riverpod(keepAlive: true)
List<Cobro> todosFilteredList(Ref ref) {
  final list = ref.watch(listActiveProvider);
  final filter = ref.watch(todoCurrentFilterProvider);

  switch (filter) {
    case FilterType.all:
      return list;
    case FilterType.completed:
      return list.where((element) => element.done).toList();
    case FilterType.pending:
      return list.where((element) => !element.done).toList();
  }
}

// todo registro de cobros
@riverpod
FutureOr<String?> registerCobroList(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final cobros = ref.watch(listActiveProvider);

  if (cobros.isEmpty) return 'No hay cobros para registrar.';

  final tipoFiltro = ref.read(filterOpcionPagoProvider);
  final batch = firestore.batch();

  final String collectionName = switch (tipoFiltro) {
    FilterPago.medidor => 'cobro_realizado_medidor',
    FilterPago.riego => 'cobro_realizado_riego',
  };

  bool algunoRegistrado = false;

  try {
    for (final cobro in cobros) {
      final docId = '${cobro.usuario_id.id}_${cobro.anio}_${cobro.mes}';
      final docRef = firestore.collection(collectionName).doc(docId);

      final existing = await docRef.get();

      if (!existing.exists) {
        batch.set(docRef, cobro.toJson());
        algunoRegistrado = true;
      }
    }

    if (algunoRegistrado) {
      await batch.commit();
      return null; // Todo OK
    } else {
      return 'Lista ya registrada para este mes.';
    }
  } catch (e, _) {
    return 'Error al registrar cobro';
  }
}

// todo bloqueo pantalla
@riverpod
// Future<bool> isBloqued(Ref ref) async{
Future<void> isBloqued(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final tipofilter = ref.watch(filterOpcionPagoProvider);
  final cobros = ref.read(listActiveProvider);
  final now = DateTime.now();
  final year = now.year;
  final month = now.month;
  // if (cobros.isEmpty) return false;
  if (cobros.isEmpty) return;

  final collection = switch (tipofilter) {
    FilterPago.medidor => 'cobro_realizado_medidor',
    FilterPago.riego => 'cobro_realizado_riego',
  };

  bool bloqueado = false;

  // final cobro = cobros.first;
  for (final cobro in cobros) {
    // final docId = '${cobro.usuario_id.id}_${cobro.anio}_${cobro.mes}';
    final docId = '${cobro.usuario_id.id}_${year}_$month';

    final docRef = firestore.collection(collection).doc(docId);
    final existing = await docRef.get();
    // if (existing.exists) return true;
    if (existing.exists) {
      bloqueado = true;
      break;
    }
  }
  // return false;
  ref.read(isBloque.notifier).state = bloqueado;
}

//todo obtener precio de cobro
@riverpod
Future<Map<String, dynamic>> getPrecioCobro(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final tipofilter = ref.watch(filterOpcionPagoProvider);
  final now = DateTime.now();
  final year = now.year;
  final month = now.month.toString().padLeft(2, '0');

  final document = switch (tipofilter) {
    FilterPago.medidor => 'aguaC_${year}_$month',
    FilterPago.riego => 'aguaR_${year}_$month',
  };

  final docRef = firestore.collection('price').doc(document);
  final existing = await docRef.get();
  final id = existing.id;
  final precio = existing.data()?['precio'];
  final data = {'id': id, 'precio': precio};
  // if (precio is num) return precio;
  if (data.isNotEmpty) return data;
  return {};
}
