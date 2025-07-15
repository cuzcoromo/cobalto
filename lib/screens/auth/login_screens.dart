import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/components/images_section.dart';
import 'package:prueva/components/welcome_section.dart';
import 'package:prueva/presentation/auth_services.dart';
import 'package:prueva/screens/app/home_one.dart';

class LoginScreens extends ConsumerStatefulWidget {
  const LoginScreens({super.key});

  @override
  ConsumerState<LoginScreens> createState()  => _LoginScreensState();
}

class _LoginScreensState extends ConsumerState<LoginScreens> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), (){
    setState(() => opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final imageHeight =
        bottomInset == 0 ? 250.0 : 150.0; // Ajustar la altura de la imagen

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // 👈 evita que el teclado empuje el layout
      body: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottomInset),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Imagessection(
                            image: 'images/login.jpg',
                            height: imageHeight,
                          ),
                          const WelcomeSection(),
                          _FormSection(ref: ref),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
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
  bool _isLoading = false;
  bool obscure = true;

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
      await widget.ref
          .read(authProvider.notifier)
          .signIn(
            email: emailController.text,
            password: passwordController.text,
          );

      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null && user.emailVerified) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return; // Si el widget no está montado, salimos temprano
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeOne()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                    prefixIcon: Icon(Icons.person, color: Color(0xFF3f744a)),
                    filled: true,
                    fillColor: const Color(0xFFdae5dd),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xFF3f744a)),
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF3f744a)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xFF3f744a)),
                    filled: true,
                    fillColor: Color(0xFFdae5dd),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Text(
                //         'Don`t have account?',
                //         style: TextStyle(fontSize: 15),
                //       ),
                //       SizedBox(width: 10),
                //       GestureDetector(
                //         onTap: () {
                //           // Navigator.push(
                //             // context,
                //             // MaterialPageRoute(
                //                 // builder: (context) => RegisterScreen()),
                //           // );
                //         },
                //         child: const Text(
                //           'Sign up',
                //           style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
