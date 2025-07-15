
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/rubros/cobro_providers.dart';
import 'package:prueva/presentation/users/users_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_user.g.dart';

final rawHistoryListProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);
final anioSeleccionadoProvider = StateProvider<num?>((ref) => null);


@riverpod
Stream<List<Map<String, dynamic>>> historyUser(Ref ref, {required String ci, num? anio}) {
  final firestore = ref.read(fireStoreProvider);
  final selectedYear = ref.watch(anioSeleccionadoProvider) ?? DateTime.now().year;
  // final selectedYear = anio ?? DateTime.now().year;
  if (ci.isEmpty) return const Stream.empty();
  final usuarioId = FirebaseFirestore.instance.doc('/users/$ci');

  final collection = switch (ref.watch(filterOpcionPagoProvider)) {
    FilterPago.medidor => 'cobro_realizado_medidor',
    FilterPago.riego => 'cobro_realizado_riego',
  };

  final docRef = firestore.collection(collection)
    .where('anio', isEqualTo: selectedYear)
    .where('usuario_id', isEqualTo: usuarioId);

  return docRef.snapshots().map((snapshot) {
    final List<Map<String, dynamic>> history = [];
    for (final element in snapshot.docs) {
      final raw = element.data();
      history.add({
        'id': element.id,
        ...raw,
      });
    }
    ref.read(rawHistoryListProvider.notifier).state = history;
    return history;
  });
}



@riverpod
Future<bool> updateHistoryUser(Ref ref, String id) async {
  final firestore = ref.read(fireStoreProvider);
  final data = {
    'updated_at': FieldValue.serverTimestamp(),
    'completedAt': FieldValue.serverTimestamp(),
  };
 
  final collection = switch (ref.watch(filterOpcionPagoProvider)) {
    FilterPago.medidor => 'cobro_realizado_medidor',
    FilterPago.riego => 'cobro_realizado_riego',
  };
  final docRef = firestore.collection(collection).doc(id);
  
  try {
    await docRef.update(data);
    return true;
  } on FirebaseException {
    // throw 'Error al actualizar';
    return false;
  }
}

// filtrado por mes 
@riverpod
Stream<List<Map<String, dynamic>>> filterListUser(Ref ref, {num? mes}) {
  final dataList = ref.read(rawHistoryListProvider);

  if( dataList.isEmpty) return const Stream.empty();

  final filtered = mes == null || mes == 'all'
  ? dataList
  : dataList.where( (data) => data['mes'] == mes).toList();

  // print(filtered);
  
  return Stream.value(filtered);
}