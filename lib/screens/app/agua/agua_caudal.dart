import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/screens/app/agua/components/list_riego.dart';
import 'package:prueva/screens/app/agua/components/price_riego.dart';
import 'package:prueva/screens/app/agua/components/register_riego.dart';
import 'package:prueva/theme_colors.dart';

class AguaCaudal extends ConsumerStatefulWidget {
  const AguaCaudal({super.key});

  @override
  ConsumerState<AguaCaudal> createState() => _AguaCaudalState();
}

class _AguaCaudalState extends ConsumerState<AguaCaudal> {
  // Clave global del formulario para validación y manejo de estado
  final _formKey = GlobalKey<FormState>();

  // Controladores para el manejo de los campos de texto
  final TextEditingController _caudalController = TextEditingController();
  final TextEditingController _unidadController = TextEditingController();
  final TextEditingController _direccionControler = TextEditingController();

  int currentPageIndex = 0;

  @override
  void initState() {
    // Inicialización de los controladores si es necesario
    _direccionControler.text = 'Cobalto';
    super.initState();
  }

  @override
  void dispose() {
    _caudalController.dispose();
    _unidadController.dispose();
    super.dispose();
  }

  /// Método para procesar el envío del formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Recolección de datos
      final String caudal = _caudalController.text;
      final String unidad = _unidadController.text;

      // Aquí puedes implementar la lógica para almacenar o enviar los datos
      // Por ejemplo, actualizar un provider o enviar los datos a un servicio backend
      print('Registro de caudal: $caudal, Unidad: $unidad');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acceso al tema actual para usar sus colores y estilos
    ThemeData localTheme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        height: 50,
        indicatorColor: localTheme.colorScheme.background2,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.price_change),
            // selectedIcon: Icon(Icons.price_change),
            label: 'Precios',
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop),
            label: 'Registro',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
        ],
        animationDuration: const Duration(milliseconds: 1000),
      ),
      body:
          [
            const PriceRiego(),
            const RegisterRiego(),
            const ListRiego(),
          ][currentPageIndex],
    );
  }
}

