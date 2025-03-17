import 'package:apk_register/components/validate_error.dart';
import 'package:apk_register/screens/auth/login_screens.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final age = TextEditingController();
  final image = TextEditingController();
  bool _isObscure = true;
  final  userError = ValueNotifier(null);
  final  emailError = ValueNotifier<String?>(null);
  final  passError = ValueNotifier<String?>(null);

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    age.dispose();
    image.dispose();
    userError.dispose();
    emailError.dispose();
    passError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Registro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3f744a),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Create your new account',
                        style: TextStyle(color: Colors.grey[350]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF3f744a),
                      ),
                      hintText: 'Nombre Completo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF3f744a),
                      ),
                      filled: true,
                      fillColor: Color(0xFFdae5dd),
                    ),
                    onChanged: (value){
                      if(_formKey.currentState != null){
                        _formKey.currentState!.validate();
                      }
                    },
                    validator: (String? value) {
                      return validateField(
                        value: value,
                        errorMessage: 'nombre completo'
                        );
                      // if (value == null || value.isEmpty) return 'Ingrese nombre completo';
                      // return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF3f744a),
                      ),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF3f744a),
                      ),
                      filled: true,
                      fillColor: Color(0xFFdae5dd),
                    ),
                    onChanged: (value){
                      if(_formKey.currentState != null ) _formKey.currentState!.validate();
                    },
                    validator: (String? value) {
                      return validateField(value: value,errorMessage: 'email',
                        validator: (value){
                          final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',);
                          if(value != null &&  !emailRegex.hasMatch(value)) return 'Email no valido';
                        }
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<String?>(
                    valueListenable: passError,
                    builder: (context, error, _) {
                      return TextFormField(
                        controller: password,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF3f744a),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFF3f744a),
                          ),
                          filled: true,
                          fillColor: Color(0xFFdae5dd),
                          errorText: error,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                            color: Color(0xFF3f744a),
                          ),
                        ),
                        onChanged: (value) {
                        // Limpiar el error cuando el usuario comienza a escribir
                          if (_formKey.currentState != null) _formKey.currentState!.validate(); // Valida el campo en tiempo real
                        },
                        validator: (String? value) {
                          return validateField(
                            value: value,
                            errorMessage: 'contraseña', // Mensaje de error si está vacío
                            // errorNotifier: passError,
                            validator: (value) {
                              if (value != null && value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres'; // Validación personalizada
                              }
                              return null; // No hay error
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: age,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF3f744a),
                      ),
                      hintText: 'Edad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF3f744a),
                      ),
                      filled: true,
                      fillColor: Color(0xFFdae5dd),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return 'Ingrese edad';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: image,
                    decoration: const InputDecoration(
                      hintText: 'Imagen URL',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF3f744a),
                      ),
                      filled: true,
                      fillColor: Color(0xFFdae5dd),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return 'Ingrese Imagen';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color(0xFF3f744a)),
                      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
                    ),
                    child: const Text(
                      'Registrar',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Formulario válido')),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Already have account?'),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreens() ));
                          },
                          child: const Text('Sign up', style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}