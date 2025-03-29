import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prueva/components/error_message.dart';

class DataServices {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Create
  Future<void> create(String collection, Map<String, dynamic> data) async {
    try {
       await _firestore.collection('users')
          .doc(data['ci']) // Usamos la cédula como ID
          .set(data, SetOptions(merge: false));
    } catch (e) {
      throw Exception('Error al registar');
    }
  }
  
  // exist ci 
  Future<bool> existCi(String ci) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('ci', isEqualTo: ci)
        .get();
    return snapshot.docs.isNotEmpty ? true: false;
  }
  // Read
  Future<DataSnapshot?> read(String path) async {
    final ref = _firebaseDatabase.ref().child(path);
    final snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  // Update
  Future<void> update (String path, Map<String, dynamic> data) async{
    final  DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }
  // Delete
  Future<void> delete(String path) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }

  // guaradr imagen el sl storage
  Future<String?> uploadImage(File file) async {
    try {
      final Reference storageRef = _storage
      .ref()
      .child('user_photos')
       .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
       
       final  UploadTask uploadTask= storageRef.putFile(file);
       final  TaskSnapshot snapshot = await uploadTask;
       return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
    Future<void> registerUser({ 
        required String  name,
        required String apellido,
        required int edad,
        required String ci,
        required String ec,
        required String fn,
        required File? image,
 
  })async{
    try {

      // ! registro
        //todo: subir iamgen al storage
        // String imageUrl = '';
        // if(image != null){
        //   // String direction = 'users/$username/$userId.jpg';
        //   imageUrl = await uploadImage(image);
        // }

        //Todo: duardar data en db
        final  userData = {
          'nombre': name,
          'apellido': apellido,
          'ci':  ci,
          'edad': edad,
          'ec': ec,
          'fn': fn,
          // 'imageUrl': imageUrl,
        };
        // await _firestore.collection('users').doc(userId).set(userData);

    }
    catch (e) {
      // showFloatingError( context,'Error al registrar el usuario');
      print('Error al registrar el usuario');
    }
  }
}
