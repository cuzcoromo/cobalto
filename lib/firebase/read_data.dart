import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadDataServices extends StateNotifier<Map<String, List<Map<String, dynamic>>>> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ReadDataServices() : super({}) {
    _listenToCollection('users');
    _listenToCollection('orders'); // Agrega más colecciones aquí según sea necesario
  }

  void _listenToCollection(String collectionName) {
    _fireStore.collection(collectionName).where('isPublished', isEqualTo: true).snapshots().listen((snapshot) {
      state = {
        ...state,
        collectionName: snapshot.docs.map((doc) {
          //  doc.data()
          final data = doc.data();
          return {
            ...data,
            'id': doc.id
          };
          }).toList(),
      };
    });
  }

  Map<String, dynamic>? getUserById(String userId) {
    final users = state['users'] ?? [];

    return users.firstWhere(
      (user) => user['ci'] == userId,
      orElse: () => <String, dynamic>{}, // Devuelve un mapa vacío en lugar de null
    ).isNotEmpty ? users.firstWhere((user) => user['ci'] == userId) : null;
  }

  Future<void> updateUsersId(Map<String, dynamic> data) async{
    try {
      final  userId = data['ci']?.toString();
      if(userId == null || userId.isEmpty){
        throw Exception('Id de usuario no valido');
      }
      await _fireStore.collection('users')
      .doc(userId)
      .update(data);

    } catch (e) {
      throw Exception('Error al actualizarr');
    }
  }

// filtar id de eliminacion 
 void filterUsersById(String userId) {
  final users = state['users'] ?? [];
  // Filtrar usuarios cuyo 'ci' no sea igual al userId
  final filteredUsers = users.where((user) => user['ci'] != userId).toList();
  // Actualizar el estado con los usuarios filtrados
  print('Filtered Users: $filteredUsers');

  state = {
    ...state,
    'users': filteredUsers,
  };
}

  Future<void> deleteUsersId(String userId) async{
    try {
      final doc = await _fireStore.collection('users').doc(userId).get();
      if(!doc.exists){
        throw Exception('Id no valido');
      }
        await _fireStore.collection('users')
        .doc(userId)
        .update({'isPublished': false});
      filterUsersById(userId);
    } catch (e) {
      throw Exception('Erro al eliminar');
    }
  }


}

final readDataProvider =
    StateNotifierProvider<ReadDataServices, Map<String, List<Map<String, dynamic>>>>(
        (ref) => ReadDataServices());
