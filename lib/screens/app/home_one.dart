import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/firebase/auth_services.dart';
import 'package:prueva/screens/app/users/users_register.dart';
// import 'package:prueva/firebase/auth_services.dart';
final selectedIndex = StateProvider<int>( (ref) => 0);

class HomeOne extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Definimos el GlobalKey
  HomeOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final selectedIndexMenu = ref.watch(selectedIndex);

    List<Widget> pages = [
      const Center(child: Text('page 1')),
      UsersRegister(),
      const Center(child: Text('page 2')),
    ];

    void onDrawerItem(int index) {
      ref.read(selectedIndex.notifier).state = index; // Actualiza el índice seleccionado
      Navigator.pop(context); // Cierra el drawer después de seleccionar un ítem
    }

    return Scaffold(
      key: _scaffoldKey, // Asignamos el GlobalKey al Scaffold
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3f744a),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Bienvenido a COBALTO', style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(width: 10),
            Text('${user?.email}' , style: const TextStyle(fontSize: 14, color: Colors.white60)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              // ref.read(authProvider.notifier).signOut();
            },
          ),
        ],
      ),
      drawer: SizedBox(
        width: 200,
        child: MyDrawer(onDrawerItem: onDrawerItem))
        ,
      body: pages[selectedIndexMenu], // Mostrar la página según la selección
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function(int) onDrawerItem;

  const MyDrawer({super.key, required this.onDrawerItem});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ExpansionTile(
            leading: const Icon(Icons.group),
            title: const Text('Usuarios'),
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: const Text('Registar'),
                onTap: () => onDrawerItem(1),
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Ver'),
                onTap: () => onDrawerItem(2),
              ),
              
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.business),
            title: const Text('Agua'),
            children: [
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Consumo'),
                onTap: () => onDrawerItem(0),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: const Text('Riego'),
                onTap: () => onDrawerItem(1),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => onDrawerItem(1),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => onDrawerItem(2),
          ),
        ],
      ),
    );
  }
}
