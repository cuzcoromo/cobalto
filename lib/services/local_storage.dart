import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorage {
    static final LocalStorage _instance = LocalStorage._internal();
    
    factory LocalStorage () {
      return _instance;
    }
    
    LocalStorage._internal();
    
    late Box _userBox;

    Future<void> init () async {
      // inicializar hive
      final appDocumentDirectory = 
        await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);

      // abrir la caja Box para alamacenar datos de usuario
      _userBox = await Hive.openBox('userBox');
    }

    // limpiar la caja
    Future<void> clean() async{
      await _userBox.clear();
    }

    Future<void> saveUserData(String usernameOrEmail, String password)async{
      // guardar datos en al caja
      await _userBox.put('usernameOrEmail', usernameOrEmail);
      await _userBox.put('password', password);
    }

    // getUserData
    Future< dynamic> getUserData(String usernameOrEmail) async{
      // ontenr datos del usuario de la caja
      final String password = _userBox.get('password', defaultValue: '') as String;

      // Devolver datos del usuario
      return {
        "usernameOrEmail": usernameOrEmail,
        'password': password
      };
    }

    String getEmailOrUsername(){
      // ontenr datos del usuario de la caja
      return _userBox.get('usernameOrEmail', defaultValue: '') as String;
    }

    String getPassword(){
      // ontenr datos del usuario de la caja
      return _userBox.get('password', defaultValue: '') as String;
    }

    Future<void> setIsSignedIn (bool isSignedIn)async{
      // Guardar estado de inicio de sesion en la caja
      await _userBox.put('is_signedIn', isSignedIn);
    }

    bool getIsSignedIn(){
      // obtener estado de sesion de la caja
      return _userBox.get('is_signedIn', defaultValue: false) as bool;
    }

    Future<void> deleteIsSignedIn() async{
      // Eliminar la clase is_signedIn de la caja
      await _userBox.delete('is_signedIn');
    }

    Future<void> setIsLoggedIn (bool isLoggedIn)async{
      // Guardar el valor de isLogged en la caja
      await _userBox.put('isLoggedIn', isLoggedIn);
    }
    
    bool getIsLoggedIn(){
      // obtener el valor de isLogged de la caja
      return _userBox.get('isLoggedIn', defaultValue: false) as bool;
    }

    Future<bool> getIsFirstTime() async{
      // ontener el valor de 'isFirstTime' de la caja
      final bool isFirstTime = _userBox.get('isFirstTime', defaultValue: true) as bool;

      // si e sla primera vez, actualiza el valor y devuelve true
      if(isFirstTime){
        await _userBox.put('isFirstTime', false);
        return true;
      }

      // si no es la primera vez devuleve false
      return false;
    }


}