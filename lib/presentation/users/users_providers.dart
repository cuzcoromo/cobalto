import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';


part 'users_providers.g.dart';
// final FirebaseFirestore fireStore = FirebaseFirestore.instance;

@riverpod
FirebaseFirestore fireStore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
// Stream<List<Map<String, dynamic>>> users(Ref ref) async* {
//   Stream<List<Map<String, dynamic>>> users(Ref ref) async* {
//   final fireStore = ref.watch(fireStoreProvider);

//     final userList = <Map<String, dynamic>>[];
//     await for( final snapshot in fireStore
//   .collection('users')
//   .where('isPublished', isEqualTo: true)
//   .snapshots()){
//     userList.clear();
//     userList.addAll( snapshot.docs.map((doc){
//       final data = doc.data();
//       return {...data, 'id':doc.id};
//     }));
//     yield userList;
//   }
  
// }

@riverpod
Stream<List<User>> users(Ref ref) async* {
  final fireStore = ref.watch(fireStoreProvider);

  await for (final snapshot in fireStore
      .collection('users')
      .where('isPublished', isEqualTo: true)
      .snapshots()) {
    final userList = snapshot.docs.map((doc) {
      final data = doc.data();
      return User.fromJson(data).copyWith(id: doc.id); // Si quieres usar doc.id como id
    }).toList();

    yield userList;
  }
}
