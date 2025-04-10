

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class ListMedidorConfig extends ConsumerStatefulWidget {
  const ListMedidorConfig({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListMedidorConfigState();
}

class _ListMedidorConfigState extends ConsumerState<ListMedidorConfig> {
  @override
  Widget build(BuildContext context) {
    return Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text( 'Lista de Medidores',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background1),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Cambia esto según la cantidad de medidores
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Medidor ${index + 1}'),
                  subtitle: Text('Detalles del medidor ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
 
  }
}