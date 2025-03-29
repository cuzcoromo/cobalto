// import 'package:apk_register/components/images_section.dart';
// import 'package:apk_register/components/welcome_section.dart';
// import 'package:apk_register/providers/auth_provider.dart';
// import 'package:apk_register/screens/app/home_one.dart';
// import 'package:apk_register/screens/auth/register_screen.dart';
// import 'package:apk_register/services/push_notification.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';


// import 'package:firebase_auth/firebase_auth.dart';

// // import 'package:flutter_riverpod/flutter_riverpod.dart';


// class LoginScreens extends StatefulWidget {
//   const LoginScreens({super.key});

//   @override
//   State<LoginScreens> createState() => _LoginScreensState();
// }

// class _LoginScreensState extends State<LoginScreens> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Flexible(
//             child: Imagessection(image: 'images/login.jpg'),
//             ),
//           WelcomeSection(),
//           _FormSection()
//         ]
//       ),
        
//     );
//   }
// }


// class _FormSection extends StatefulWidget {
//   @override
//   State<_FormSection> createState() => _FormSectionState();
// }


// class _FormSectionState extends State<_FormSection> {
//   final _formkey  = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   static String? token;
//   bool _isLoading = false;

//   @override
//   void initState (){
//     super.initState();
//     token = PushNotificationService.token;
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void onFormLogin() async{

//     try {
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailController.text,
//     password: passwordController.text,
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }

//     // final loginProvider = Provider.of<LoginProvider>(context, listen:false);

//     // if(_formkey.currentState!.validate()){
//     //   setState(() {
//     //   _isLoading = true;
//     //   });
//     //   loginProvider.loginUser(
//     //     email: emailController.text.toLowerCase(),
//     //     password: passwordController.text,
//     //     onSucces: (){
//     //       // verificar email
//     //       User? user = FirebaseAuth.instance.currentUser;
//     //       if(user != null && user.emailVerified){
//     //         setState(() {
//     //           _isLoading = false;
//     //         });
//     //         Navigator.pushAndRemoveUntil(context,
//     //           MaterialPageRoute(builder: (context) => const HomeOne()), (route) => false);
//     //       }else{
//     //         setState(() {
//     //           _isLoading = false;
//     //         });
//     //       }
//     //     },
//     //     onError: (String e){
//     //       setState(() {
//     //         _isLoading = false;
//     //       });
//     //       'Error de session';
//     //     }
//     //     );
//     // }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Form(
//           key: _formkey,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextFormField(
//                   controller: emailController,
//                   decoration:InputDecoration(
//                     prefixIcon: Icon(Icons.person,
//                     color: Color(0xFF3f744a),
//                     ),
//                     filled: true,
//                     fillColor: const Color(0xFFdae5dd),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(15)
//                     ),
//                     hintText: 'Email',
//                     hintStyle: TextStyle(
//                       color: Color(0xFF3f744a),
//                     )
//                   ),
//                 validator: (String? value){
//                   if(value == null || value.isEmpty){
//                     return 'Ingrese email!';
//                   }
//                   return null;
//                 } ,
//                 ),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: true, // Oculta campo al escribir
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.lock,
//                     color: Color(0xFF3f744a),
//                     ),
//                     hintText: 'Password',
//                     hintStyle: TextStyle(
//                       color: Color(0xFF3f744a),
//                     ),
//                     filled: true, //activa el fondo
//                      fillColor: Color(0xFFdae5dd), // Color de fondo
//                      border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none
//                      )
//                   ),
//                   validator: (String? value){
//                     if(value == null || value.isEmpty){
//                       return 'Ingrese password!';
//                     }
//                     return null;
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: ElevatedButton(
//                     style:ButtonStyle(
//                       backgroundColor:  WidgetStateProperty.all( Color(0xFF3f744a),),
//                       // crecer todo el alcho de la pagina
//                       minimumSize:  WidgetStateProperty.all(Size(double.infinity, 50)),

//                     ) ,
//                     onPressed: ()async {
//                       onFormLogin();
//                     },
//                     child: const Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 18),
                    
//                     )
//                     ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text('Don`t have account?', style: TextStyle(fontSize: 15),),
//                       SizedBox(width:10 ),
//                       // detectar al hacer click
//                       GestureDetector(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen() ));
//                         },
//                         child: const Text('Sign up', style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
//                       )
//                     ],
//                   ),
//                   )
//               ],
//             ),
//           ),
//         )
//         ],
//     );
//   }  
// }


// Todo 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/components/images_section.dart';
import 'package:prueva/components/welcome_section.dart';
import 'package:prueva/firebase/auth_services.dart';
import 'package:prueva/screens/app/home_one.dart';

class LoginScreens extends ConsumerWidget {
  const LoginScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(child: Imagessection(image: 'images/login.jpg')),
          WelcomeSection(),
          _FormSection(ref: ref), // Pasamos el `ref` al widget de formulario
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  final WidgetRef ref; // Recibimos el `ref` desde el widget padre
  const _FormSection({required this.ref});

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static String? token;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onFormLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {

      // Usamos el `ref.read` correctamente para acceder a `AuthNotifier` y hacer el login
      // await widget.ref.read(authProvider.notifier).loginUser(
      //    email: emailController.text,
      //   password: passwordController.text,
      // );
      // todo
      // await authService.value.signIn(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );

      await widget.ref.read(authProvider.notifier).signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null && user.emailVerified) {
        setState(() {
          _isLoading = false;
        });
        if (!mounted) return;  // Si el widget no está montado, salimos temprano
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeOne()),
          (route) => false,
        );
      // } else {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error de login: $e'); // Manejo de error de login
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF3f744a),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFdae5dd),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Color(0xFF3f744a),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese email!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF3f744a),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xFF3f744a),
                    ),
                    filled: true,
                    fillColor: Color(0xFFdae5dd),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese password!';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xFF3f744a),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        Size(double.infinity, 50),
                      ),
                    ),
                    onPressed: () async {
                      onFormLogin();
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don`t have account?',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                            // context,
                            // MaterialPageRoute(
                                // builder: (context) => RegisterScreen()),
                          // );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
