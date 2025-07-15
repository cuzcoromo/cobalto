
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  // final storage = const  FlutterSecureStorage();
  final storage = FlutterSecureStorage();
  static const keyToken = 'auth_token';

// alamacena el token en el storage
  Future<void> saveToken(String? token) async {
    await storage.write(key: keyToken, value: token);
  }

  Future<String?> getToken() async{
    return await storage.read(key: keyToken);
  }

  Future<void> deleteToken() async{
    await storage.delete(key: keyToken);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token !=null && token.isNotEmpty;
  }
}