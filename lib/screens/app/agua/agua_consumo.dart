import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/screens/app/agua/components/list__medidor_config.dart';
import 'package:prueva/screens/app/agua/components/medidor_config.dart';
import 'package:prueva/screens/app/agua/components/price_config.dart';
import 'package:prueva/theme_colors.dart';

class AguaConsumo extends ConsumerStatefulWidget {
  const AguaConsumo({super.key});

  @override
  ConsumerState<AguaConsumo> createState() => _AguaConsumo();
}

class _AguaConsumo extends ConsumerState<AguaConsumo> {
  int currentPageIndex = 0;

  final List<Widget> _pages = const [
    PriceConfig(),
    MedidorConfig(),
    ListMedidorConfig(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(currentTabIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          // setState(() {
          //   currentPageIndex = index;
          // });
          ref.read(currentTabIndexProvider.notifier).setIndex(index);
        },
        height: 50,
        indicatorColor: Theme.of(context).colorScheme.background2,
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.price_change),
            label: 'Precios',
          ),
          NavigationDestination(
            icon: Icon(Icons.water_drop),
            label: 'Medidor',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Listado',
          ),
        ],
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
