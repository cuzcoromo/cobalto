
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:apk_register/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
  FirebaseMessaging.instance;

  static String? token;

  static Future initializeApp () async{
    await Firebase.initializeApp(
      options:DefaultFirebaseOptions.currentPlatform
    );
      // push notification
      await _firebaseMessaging.requestPermission();
      token = await _firebaseMessaging.getToken();
  }
}