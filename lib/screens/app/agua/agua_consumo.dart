import 'package:flutter/material.dart';
import 'package:prueva/screens/app/agua/components/list__medidor_config.dart';
import 'package:prueva/screens/app/agua/components/medidor_config.dart';
import 'package:prueva/screens/app/agua/components/price_config.dart';
import 'package:prueva/theme_colors.dart';

class AguaConsumo extends StatefulWidget {
  const AguaConsumo({super.key});

  @override
  State<AguaConsumo> createState() => _AguaConsumo();
}

class _AguaConsumo extends State<AguaConsumo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _medidorController = TextEditingController();
  final TextEditingController _lecturaInicialController = TextEditingController();
  final TextEditingController _lecturaFinalController = TextEditingController();
  final TextEditingController _costoController = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();

  int currentPageIndex = 0;

  // Este método podría calcular el consumo automáticamente
  int get consumo {
    final lecturaInicial = int.tryParse(_lecturaInicialController.text) ?? 0;
    final lecturaFinal = int.tryParse(_lecturaFinalController.text) ?? 0;
    return lecturaFinal - lecturaInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar :NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // backgroundColor: Theme.of(context).colorScheme.background2,
        // labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 50,
        indicatorColor: Theme.of(context).colorScheme.background2,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.price_change),
            label: 'Precios',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.water_drop),
            icon: Icon(Icons.water_drop),
            label: 'Medidor',
          ),
          NavigationDestination(
            icon: Icon(Icons.electric_bolt),
            label: 'Electricidad',
          ),
        ],
        animationDuration: Duration(milliseconds: 1000),

      ),
      body: [
        PriceConfig(),
        MedidorConfig(),
        ListMedidorConfig(),
      ][currentPageIndex],
      
      
    
    );
  }
}
