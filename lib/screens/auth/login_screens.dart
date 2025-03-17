import 'package:apk_register/components/images_section.dart';
import 'package:apk_register/components/welcome_section.dart';
import 'package:apk_register/providers/auth_provider.dart';
import 'package:apk_register/screens/app/home_one.dart';
import 'package:apk_register/screens/auth/register_screen.dart';
import 'package:apk_register/services/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;


import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Imagessection(image: 'images/login.jpg'),
            ),
          WelcomeSection(),
          _FormSection()
        ]
      ),
        
    );
  }
}


class _FormSection extends StatefulWidget {
  @override
  State<_FormSection> createState() => _FormSectionState();
}


class _FormSectionState extends State<_FormSection> {
  final _formkey  = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static String? token;
  bool _isLoading = false;

  @override
  void initState (){
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onFormLogin() async{
    final loginProvider = Provider.of<LoginProvider>(context, listen:false);

    if(_formkey.currentState!.validate()){
      setState(() {
      _isLoading = true;
      });
      loginProvider.loginUser(
        email: emailController.text.toLowerCase(),
        password: passwordController.text,
        onSucces: (){
          // verificar email
          User? user = FirebaseAuth.instance.currentUser;
          if(user != null && user.emailVerified){
            setState(() {
              _isLoading = false;
            });
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const HomeOne()), (route) => false);
          }else{
            setState(() {
              _isLoading = false;
            });
          }
        },
        onError: (String e){
          setState(() {
            _isLoading = false;
          });
          'Error de session';
        }
        );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.person,
                    color: Color(0xFF3f744a),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFdae5dd),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Color(0xFF3f744a),
                    )
                  ),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return 'Ingrese email!';
                  }
                  return null;
                } ,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true, // Oculta campo al escribir
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    color: Color(0xFF3f744a),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xFF3f744a),
                    ),
                    filled: true, //activa el fondo
                     fillColor: Color(0xFFdae5dd), // Color de fondo
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                     )
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return 'Ingrese password!';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    style:ButtonStyle(
                      backgroundColor:  WidgetStateProperty.all( Color(0xFF3f744a),),
                      // crecer todo el alcho de la pagina
                      minimumSize:  WidgetStateProperty.all(Size(double.infinity, 50)),

                    ) ,
                    onPressed: ()async {
                      onFormLogin();
                    },
                    child: const Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 18),
                    
                    )
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don`t have account?', style: TextStyle(fontSize: 15),),
                      SizedBox(width:10 ),
                      // detectar al hacer click
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen() ));
                        },
                        child: const Text('Sign up', style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
                      )
                    ],
                  ),
                  )
              ],
            ),
          ),
        )
        ],
    );
  }  
}