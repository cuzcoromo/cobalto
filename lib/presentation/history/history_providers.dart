import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/users/users_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

final anioFiltro = StateProvider<num>((ref) => DateTime.now().year);
final mesFiltro = StateProvider<num>((ref) => DateTime.now().month);
final historialProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => [],
);
final historialProviderResultado = StateProvider<List<Map<String, dynamic>>>(
  (ref) => [],
);
final ciFiltroProvider = StateProvider<String>((ref) => '');

enum FilterSearch { consumo, riego }

final filterSearProvider = StateProvider<FilterSearch>(
  (ref) => FilterSearch.values[0],
);

//todo total de deuda
@riverpod
Future<num> totalHistory(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final filterSearch = ref.watch(filterSearProvider);

  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };

  final snapshot =
      await firestore
          .collection(collection)
          .where('completedAt', isNull: true)
          .get();

  num total = 0;

  for (var doc in snapshot.docs) {
    final precioRef = doc.data()['precio_id'];
    if (precioRef == null) return 0;
    final precioSnap = await precioRef.get();
    final data = precioSnap.data();
    if (data == null || data['precio'] == null) continue;
    final montoInt = data['precio'] as num;
    total += montoInt;
  }
  return total;
}

//todo total por mes
@riverpod
Future<num> totalMes(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final filterSearch = ref.watch(filterSearProvider);
  final now = DateTime.now();
  final year = now.year;
  final month = now.month;
  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };

  final snapshot =
      await firestore
          .collection(collection)
          .where('anio', isEqualTo: year)
          .where('mes', isEqualTo: month)
          .where('completedAt', isGreaterThan: DateTime(2000))
          .get();

  num total = 0;
  for (var doc in snapshot.docs) {
    final precioRef = doc.data()['precio_id'];
    if (precioRef == null) return 0;
    final dataW = await precioRef.get();
    final data = dataW.data();
    if (data == null || data['precio'] == null) continue;
    final monto = data['precio'] as num;
    total += monto;
  }
  // ref.read(montoTotalProvider.notifier).state = 0.0;
  return total;
}

// todo listado de pagados
@riverpod
Future<List<Map<String, dynamic>>> listRegisterCobro(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final anio = ref.watch(anioFiltro);
  final mes = ref.watch(mesFiltro);
  final filterSearch = ref.watch(filterSearProvider);
  final ci = ref.watch(ciFiltroProvider);
  List<Map<String, dynamic>> lista = [];

  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };

  // Construir la query base
  var query = firestore
      .collection(collection)
      .where('anio', isEqualTo: anio)
      .where('mes', isEqualTo: mes);

  // Si hay filtro por ci, agregarlo a la query
  if (ci.isNotEmpty) {
    final userRef = firestore.doc('users/$ci');
    query = query.where('usuario_id', isEqualTo: userRef);
  }

  final snapshot = await query.get();

  for (var doc in snapshot.docs) {
    final userRef = doc.data()['usuario_id'];
    if (userRef == null) continue;

    final userDoc = await userRef.get();
    final userData = userDoc.data();
    if (userData == null) continue;

    lista.add({
      'id': doc.id,
      'nombre': userData['name'],
      'apellido': userData['apellido'],
      'completedAt':
          doc.data()['completedAt']?.toDate().toLocal().toString().split(
            ' ',
          )[0],
      'fechaR':
          doc.data()['fechaRegistro']?.toDate().toLocal().toString().split(
            ' ',
          )[0],
    });
  }

  if (lista.isNotEmpty) {
    ref.read(historialProvider.notifier).state = lista;
    ref.read(historialProviderResultado.notifier).state = lista;
  }

  return lista;
}

// todo deuda de usuario
@riverpod
Future<num> deudaUser(Ref ref, String? id) async {
  final firestore = ref.read(fireStoreProvider);
  final filterSearch = ref.watch(filterSearProvider);
  final idRef = id?.split('_').first;
  final userRef = firestore.doc('users/$idRef');

  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };
  num total = 0;

  final snapshot =
      await firestore
          .collection(collection)
          .where('usuario_id', isEqualTo: userRef)
          .where('completedAt', isNull: true)
          .get();
  for (var doc in snapshot.docs) {
    final priceRef =
        doc.data()['precio_id'] as DocumentReference<Map<String, dynamic>>;
    final priceDoc = await priceRef.get();
    final priceData = priceDoc.data();
    final precio = priceData?['precio'];
    if (precio is num) {
      total += precio;
    }
  }
  final list = ref.read(historialProviderResultado);
  // final listMap = {for (var e in list) e['id']: e};
  if (list.isNotEmpty) {
    ref.read(historialProviderResultado.notifier).state =
        list.map((item) {
          if (item['id'] == id) {
            return {...item, 'deuda': total};
          }
          return item;
        }).toList();
  }
  return total;
}

// todo monto aportado
@riverpod
Future<num> totalAporte(Ref ref, String? id) async {
  final firestore = ref.read(fireStoreProvider);
  final filterSearch = ref.watch(filterSearProvider);
  final idRef = id?.split('_').first;
  final userRef = firestore.doc('users/$idRef');

  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };

  final snapshot =
      await firestore
          .collection(collection)
          .where('usuario_id', isEqualTo: userRef)
          .where('completedAt', isGreaterThan: DateTime(2000))
          .get();
  num total = 0;
  for (var doc in snapshot.docs) {
    final data = doc.data();
    if (data.containsKey('precio_id') && data['precio_id'] != null) {
      final priceRef =
          doc.data()['precio_id'] as DocumentReference<Map<String, dynamic>>;
      final priceDoc = await priceRef.get();
      final priceData = priceDoc.data();
      final precio = priceData?['precio'];
      if (precio is num) {
        total += precio;
      }
    }
  }
  final list = ref.read(historialProviderResultado);
  // final monto = ref.read(montoTotalProvider);
  // ref.read(montoTotalProvider.notifier).state = monto + total;

  ref.read(historialProviderResultado.notifier).state =
      list.map((item) {
        if (item['id'] == id) {
          return {
            ...item,
            'total': total, // se agrega este campo
          };
        }
        return item; // los demás quedan igual
      }).toList();
  return total;
}

// todo total de categoria
@riverpod
Future<num> totaltCategoria(Ref ref) async {
  final firestore = ref.read(fireStoreProvider);
  final filterSearch = ref.watch(filterSearProvider);

  final collection = switch (filterSearch) {
    FilterSearch.consumo => 'cobro_realizado_medidor',
    FilterSearch.riego => 'cobro_realizado_riego',
  };

  final snapshot =
      await firestore
          .collection(collection)
          .where('completedAt', isGreaterThan: DateTime(2000))
          .get();
  num total = 0;
  for (var doc in snapshot.docs) {
    final data = doc.data();
    if (data.containsKey('precio_id') && data['precio_id'] != null) {
      final priceRef =
          doc.data()['precio_id'] as DocumentReference<Map<String, dynamic>>;
      final priceDoc = await priceRef.get();
      final priceData = priceDoc.data();
      if (priceData == null) continue;
      final precio = priceData['precio'];
      if (precio is num) {
        total += precio;
      }
    }
  }

  return total;
}
