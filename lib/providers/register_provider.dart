import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

enum UserRole {admin, user, superAdmin}

class RegisterProvider extends ChangeNotifier{
  // instancia de firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // RegisterProvider(){
      // 
  // }

  // futures
  Future<void> registerUser({ 
    required String username,
    required String email,
    required String password,
    required UserRole rol,
    required String birth,
    required String age,
    required String token,
    required File? image,
    required Function createAt,
    required Function(String) onError,

  })async{
    try {
      final emailLowercase = email.toLowerCase();
      // todo: verificar si el usuario existe en la db
      final bool userExist = await checkUserExist(email: emailLowercase);
      if(userExist){
        onError('Usuario registrado');
        return;
      }
      
      // ! registro
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailLowercase,
        password: password
        );
        final User user = userCredential.user!;
        final String userId = user.uid;
        
        //todo: subir iamgen al storage
        String imageUrl = ';';
        if(image != null){
          String direction = 'users/$username/$userId.jpg';
          imageUrl = await uploadImage(direction, image);
        }

        //Todo: duardar data en db
        final  userData = {
          'id': userId,
          'username': username,
          'email': emailLowercase,
          'rol': rol,
          'birth': birth,
          'age': age,
          'token': token,
          'imageUrl': imageUrl,
          'createAt': createAt,
        };
        await _firestore.collection('user').doc(userId).set(userData);

    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        onError('Password debil');
      }else if(e.code == 'email-already-in-use'){
        onError('Email registrado');

      }
    }
    catch (e) {
      onError(e.toString());
    }
  }

  //? metodo verificr usuarioi existe
  Future<bool> checkUserExist({required String email})async{
    final QuerySnapshot result = await _firestore
    .collection('users')
    .where('email', isEqualTo: email)
    .limit(1)
    .get();
    return result.docs.isNotEmpty;
  }

  //? Guardar imagen en el storage
  Future<String> uploadImage(String ref, File file )async{
    final UploadTask uploadTask = _storage.ref(ref).child(ref).putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}