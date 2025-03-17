import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


enum AuthStatus{notAuthentication, chaeking, authenticated}

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore  _fireStore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAuthentication;

  Future<void> loginUser({
    required String email,
    required String password,
    required Function onSucces,
    required Function(String) onError,
  }) async{
    try {
      authStatus = AuthStatus.chaeking;
      notifyListeners();
      final String emailLowercase = email.toLowerCase();
      final  QuerySnapshot result = await _fireStore
        .collection('users')
        .where('email', isEqualTo: emailLowercase )
        .limit(1)
        .get();


      if(result.docs.isNotEmpty){
        final String email = result.docs.first.get('email');
        print('Email: $email');
        final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email ,
          password: password
        );
        onSucces();
        return;
      }
      onError('Usuario no encontrado!');
    }  on FirebaseAuthException catch (e){
      if(e.code == 'user-not-fount' || e.code == 'wrong-password'){
        onError('Credenciales incorecto!');
      }
    }
    catch (e) {
      onError(e.toString());      
    }
  }
}