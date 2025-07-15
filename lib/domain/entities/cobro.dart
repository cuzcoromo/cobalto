// import 'package:cloud_firestore/cloud_firestore.dart';

// class Cobro {
//   final String id;
//   final String nombre;
//   final String apellido;
//   final DocumentReference<Map<String, dynamic>> usuario_id;
//   final int anio;
//   final int mes;
//   final DateTime fechaRegistro;
//   final DateTime? completedAt;

//   Cobro({
//     required this.id,
//     required this.nombre,
//     required this.apellido, 
//     required this.usuario_id,
//     required this.anio,
//     required this.mes,
//     required this.fechaRegistro,
//     this.completedAt,
//   });

//   bool get done => completedAt != null;

//   Cobro copyWith({
//     String? id,
//     String? nombre,
//     String? apellido,
//     DocumentReference<Map<String, dynamic>>? usuario_id,
//     int? anio,
//     int? mes,
//     DateTime? fechaRegistro,
//     DateTime? completedAt,
//   }) {
//     return Cobro(
//       id: id ?? this.id,
//       nombre: nombre ?? this.nombre,
//       apellido: apellido ?? this.apellido,
//       usuario_id: usuario_id ?? this.usuario_id,
//       anio: anio ?? this.anio,
//       mes: mes ?? this.mes,
//       fechaRegistro: fechaRegistro ?? this.fechaRegistro,
//       completedAt: completedAt, 
//     );
//   }

//    // --- Agregado método toJson ---
//   Map<String, dynamic> toJson() {
//   final fechaSoloDia = DateTime(fechaRegistro.year, fechaRegistro.month, fechaRegistro.day);
//   final completadoSoloDia = completedAt != null
//       ? DateTime(completedAt!.year, completedAt!.month, completedAt!.day)
//       : null;

//   return {
//     'usuario_id': usuario_id,
//     'anio': anio,
//     'mes': mes,
//     'fechaRegistro': fechaSoloDia,
//     'completedAt': completadoSoloDia,
//   };
// }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class Cobro {
  final String id;
  final String nombre;
  final String apellido;
  final DocumentReference<Map<String, dynamic>> usuario_id;
  final DocumentReference<Map<String, dynamic>>? precio_id; // ✅ Agregado
  final int anio;
  final int mes;
  final DateTime fechaRegistro;
  final DateTime? completedAt;

  Cobro({
    required this.id,
    required this.nombre,
    required this.apellido, 
    required this.usuario_id,
    required this.precio_id, // ✅ Agregado
    required this.anio,
    required this.mes,
    required this.fechaRegistro,
    this.completedAt,
  });

  bool get done => completedAt != null;

  Cobro copyWith({
    String? id,
    String? nombre,
    String? apellido,
    DocumentReference<Map<String, dynamic>>? usuario_id,
    DocumentReference<Map<String, dynamic>>? precio_id, // ✅ Agregado
    int? anio,
    int? mes,
    DateTime? fechaRegistro,
    DateTime? completedAt,
  }) {
    return Cobro(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      usuario_id: usuario_id ?? this.usuario_id,
      precio_id: precio_id ?? this.precio_id, // ✅ Agregado
      anio: anio ?? this.anio,
      mes: mes ?? this.mes,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      completedAt: completedAt, 
    );
  }

  Map<String, dynamic> toJson() {
    final fechaSoloDia = DateTime(fechaRegistro.year, fechaRegistro.month, fechaRegistro.day);
    final completadoSoloDia = completedAt != null
        ? DateTime(completedAt!.year, completedAt!.month, completedAt!.day)
        : null;

    return {
      'usuario_id': usuario_id,
      'precio_id': precio_id, // ✅ Agregado
      'anio': anio,
      'mes': mes,
      'fechaRegistro': fechaSoloDia,
      'completedAt': completadoSoloDia,
    };
  }
}
