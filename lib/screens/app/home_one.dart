import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/auth_services.dart';
import 'package:prueva/presentation/navigation/home_one_providers.dart';
import 'package:prueva/presentation/users/read_data.dart';
import 'package:prueva/screens/app/agua/agua_caudal.dart';
import 'package:prueva/screens/app/agua/agua_consumo.dart';
import 'package:prueva/screens/app/agua/rubros_config.dart';
import 'package:prueva/screens/app/historial/history.dart';
import 'package:prueva/screens/app/presentation.dart';
import 'package:prueva/screens/app/resumen/resumen.dart';
import 'package:prueva/screens/app/users/users_list.dart';
import 'package:prueva/screens/app/users/users_register.dart';
import 'package:prueva/screens/auth/login_screens.dart';

// import 'package:prueva/firebase/auth_services.dart';
final selectedIndex = StateProvider<int>((ref) => 0);

class HomeOne extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Definimos el GlobalKey
  HomeOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final name = user?.email?.split('@').first;
    // final selectedIndexMenu = ref.watch(selectedIndex);
    final selectedIndexMenu = ref.watch(optionNavigationProvider);

    List<Widget> pages = [
      WelcomePage(),
      UsersRegister(),
      UsersList(),
      AguaConsumo(),
      AguaCaudal(),
      RubrosConfig(),
      Resumen(),
    ];

    void onDrawerItem(int index) async {
      // Espera un poco para que se vea la animación
      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.pop(context); // Cierra el drawer después de seleccionar un ítem
      ref
          .read(optionNavigationProvider.notifier)
          .setOption(index); // Actualiza el índice seleccionado
    }

    return Scaffold(
      key: _scaffoldKey, // Asignamos el GlobalKey al Scaffold
      appBar: AppBar(
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xFF3f744a),
        backgroundColor: const Color(0xFF589966),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hola, ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.red[100],
            onPressed: () async {
              try {
                await ref.read(authProvider.notifier).logout();
                if (!context.mounted) return;

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreens()),
                  (route) => false,
                );
                MessageHelper.showSuccess(context, 'Sesion cerrada');
              } catch (e) {
                MessageHelper.showSuccess(context, 'Error al cerrar sesion');
              }
            },
          ),
        ],
      ),
      drawer: SizedBox(
        width: 200,
        child: MyDrawer(onDrawerItem: onDrawerItem, ref: ref),
      ),
      body: pages[selectedIndexMenu], // Mostrar la página según la selección
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function(int) onDrawerItem;
  final WidgetRef ref;

  const MyDrawer({super.key, required this.onDrawerItem, required this.ref});

  void onPress() {
    ref.read(readDataProvider)['users'];
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(optionNavigationProvider);

    // logica para determinar  que grupo expandir
    final isUsuariosExpanded = selectedIndex == 1 || selectedIndex == 2;
    final isAguaExpanded = selectedIndex >= 3 && selectedIndex <= 5;

    return Drawer(
      // inicializar en la pantalla seleccionada que abierto en el drawer
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 30),
          Container(
            height: 60, // Altura personalizada (ajústala)
            color: Color(0xFF3f744a),
            alignment: Alignment.center,
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            selected: selectedIndex == 0,
            selectedTileColor: Colors.grey[350],
            onTap: () {
              ref.read(optionNavigationProvider.notifier).setOption(0);
              onDrawerItem(0);
            },
          ),

          //todo Usuarios
          ExpansionTile(
            initiallyExpanded: isUsuariosExpanded,
            leading: const Icon(Icons.group),
            title: const Text('Usuarios'),
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: const Text('Registar'),
                selected: selectedIndex == 1,
                selectedTileColor: Colors.grey[350],
                onTap: () {
                  ref.read(optionNavigationProvider.notifier).setOption(1);
                  onDrawerItem(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Ver'),
                selected: selectedIndex == 2,
                selectedTileColor: Colors.grey[350],
                onTap: () {
                  ref.read(optionNavigationProvider.notifier).setOption(2);
                  onDrawerItem(2);
                  onPress();
                },
              ),
            ],
          ),
          ExpansionTile(
            initiallyExpanded: isAguaExpanded,
            leading: const Icon(Icons.water),
            title: const Text('Agua'),
            children: [
              ListTile(
                leading: Icon(Icons.water_damage_outlined),
                title: const Text('Consumo'),
                selected: selectedIndex == 3,
                selectedTileColor: Colors.grey[350],
                onTap: () {
                  ref.read(optionNavigationProvider.notifier).setOption(3);
                  onDrawerItem(3);
                },
              ),
              ListTile(
                leading: Icon(Icons.water_drop_outlined),
                selected: selectedIndex == 4,
                selectedTileColor: Colors.grey[350],
                title: const Text('Riego'),
                onTap: () {
                  ref.read(optionNavigationProvider.notifier).setOption(4);
                  onDrawerItem(4);
                },
              ),
              ListTile(
                leading: Icon(Icons.monetization_on_outlined),
                title: const Text('Cobros'),
                selected: selectedIndex == 5,
                selectedTileColor: Colors.grey[350],
                onTap: () {
                  ref.read(optionNavigationProvider.notifier).setOption(5);
                  onDrawerItem(5);
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.summarize_outlined),
            title: const Text('Resumen'),
            selected: selectedIndex == 6,
            selectedTileColor: Colors.grey[350],
            onTap: () => onDrawerItem(6),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            selected: selectedIndex == 7,
            selectedTileColor: Colors.grey[350],
            // onTap: () => onDrawerItem(7),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => History()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () => onDrawerItem(1),
          // ),
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('About'),
          //   onTap: () => onDrawerItem(2),
          // ),
        ],
      ),
    );
  }
}
