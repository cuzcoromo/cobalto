
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resumen.g.dart';

final anioProvider = StateProvider<num>((ref) => DateTime.now().year);
final mesProvider = StateProvider<num>((ref) => DateTime.now().month);
final lastDocProvider = StateProvider<DocumentSnapshot?>((ref) => null);
final historyProvider = StateProvider<List<DocumentSnapshot>>((ref) => []);


@riverpod
Future<List<Map<String, dynamic>>> dataResumen(Ref ref) async {
  final anioActual = ref.watch(anioProvider);
  final mesActual = ref.watch(mesProvider);
  final lastDoc = ref.watch(lastDocProvider);
  final firestore = ref.read(fireStoreProvider);
  final filteroptions = ref.watch(filterOpcionPagoProvider);

  final collection = switch (filteroptions) {
    FilterPago.medidor => 'cobro_realizado_medidor',
    FilterPago.riego => 'cobro_realizado_riego',
  };

Query query = firestore
    .collection(collection)
    .where('anio', isEqualTo: anioActual)
    .where('mes', isEqualTo: mesActual)
    .orderBy('anio')
    .orderBy('mes')
    .orderBy('fechaRegistro') // incluir solo si lo usas para paginación
    .limit(20);

  // Paginación: si hay un documento anterior, empezar después de él
  if (lastDoc != null) {
    query = query.startAfterDocument(lastDoc);
  }

  final snapshot = await query.get();
   // Traemos los datos con el usuario referenciado
  final List<Map<String, dynamic>> data = [];

  for (final doc in snapshot.docs) {
    final raw = doc.data() as Map<String, dynamic>;
    final userRef = raw['usuario_id'] as DocumentReference<Map<String, dynamic>>;
    final userSnap = await userRef.get();
    final userData = userSnap.data();

    data.add({
      'id': doc.id,
      'nombre': userData?['name'],
      'apellido': userData?['apellido'],
      'anio': raw['anio'],
      'mes': raw['mes'],
      'fechaRegistro': raw['fechaRegistro'],
      'completedAt': raw['completedAt'],
      'docSnapshot': doc, // 🔑 para paginación
    });
  }
  return data;
}