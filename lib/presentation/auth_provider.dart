// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:prueva/presentation/auth_services.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'auth_provider.g.dart';

// @Riverpod(keepAlive: true)
// Future<String> authLogin(Ref ref) async {
// // class AuthServices extends _$AthServices {
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//   // verifica si el usuario esta logeado
//   AuthState authState = AuthState.notAuthentication;
  
//   AuthServices(): super(null){
//     _auth.authStateChanges().listen((user){
//       state = user;
//       authState = AuthState.authenticated;
//     });
//     }
//   // 
//   final UserCredential credential = await _auth.signInWithEmailAndPassword(
//             email: emailLowercase,
//             password: password
//           );
//   return;
// }
