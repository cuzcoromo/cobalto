// import 'package:apk_register/components/images_section.dart';
import 'package:apk_register/providers/auth_provider.dart';
import 'package:apk_register/screens/auth/login_screens.dart';
import 'package:apk_register/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // inicializa la comunicacion con firebase cuadno se inicia la aplicacion
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) =>LoginProvider())
    ],
    child: MyApp()),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'COBALTO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '¡Bienvenido a COBALTO! '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
      // ),
      body: LoginScreens()
    );
  }
}
