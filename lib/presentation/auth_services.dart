import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/storage/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ValueNotifier<AuthServices> authService = ValueNotifier(AuthServices());

// class AuthServices {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // salida a firebase
//   User? get user => _auth.currentUser;

//   // verifica si el usuario esta logeado
//   Stream<User?> get authStateChanges => _auth.authStateChanges();


//   Future<void> signIn({required String email, required String password}) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> createAccount({required String email, required String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e);
//     }
//   }
//   Future<void> signOut({required String email, required String password}) async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print(e);
//     }
//   }

// }

// part 'auth_services.g.dart';
enum AuthState{notAuthentication, chaeking, authenticated}

// @Riverpod(keepAlive: true)
class AuthServices extends StateNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // salida a firebase

  // verifica si el usuario esta logeado
  AuthState authState = AuthState.notAuthentication;
  AuthServices(): super(null){
    _auth.authStateChanges().listen((user){
      state = user;
      authState = AuthState.authenticated;
    });
    }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final String emailLowercase = email.toLowerCase().trim();
      // final QuerySnapshot result = await _fireStore
      //   .collection('users')
      //   .where('email', isEqualTo: emailLowercase)
      //   .limit(1)
      //   .get();

        // if(result.docs.isNotEmpty){
          // final String email = result.docs.first.get('email');
          final UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: emailLowercase,
            password: password
          );
          // TODO agregado para obtener token y guardar
          User? user = credential.user;
          if(user != null){
            final token = await user.getIdToken();
            final storageService = StorageService();
            await storageService.saveToken(token);
          }
        // }
        return;
    } catch (e) {
      throw Exception('Error al logearsw');
    }
  }

  // loout
  Future<void> logout() async {
  try {
    await _auth.signOut(); // Cierra sesión en Firebase
    final storageService = StorageService();
    await storageService.deleteToken(); // Borra token localmente
    state = null; // Actualiza Riverpod manualmente por seguridad
  } catch (e) {
    throw Exception('Error al cerrar sesión');
  }
}

  Future<void> createAccount({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}


final authProvider = StateNotifierProvider<AuthServices, User?>( (ref) => AuthServices());