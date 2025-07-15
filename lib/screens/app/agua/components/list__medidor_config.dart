import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:prueva/screens/app/agua/components/dialog_builder.dart';
import 'package:prueva/theme_colors.dart';

class Medidor {
  const Medidor({this.id,this.apellido, this.nombre, this.numMed, this.ci, this.fechaIns });
  final String? id;
  final String? ci;
  final String? fechaIns;
  final String? nombre;
  final String? apellido;
  final String? numMed;
}

class ListMedidorConfig extends ConsumerStatefulWidget {
  const ListMedidorConfig({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListMedidorConfigState();
}

class _ListMedidorConfigState extends ConsumerState<ListMedidorConfig> {

  @override
  Widget build(BuildContext context) {
    final listMedidores = ref.watch(medidorListProvider);
    final themeColor = Theme.of(context).colorScheme;

    if (listMedidores.isLoading) {
      return Center(child: const CircularProgressIndicator());
    }

    if (listMedidores.hasError) {
      // volver llamar al provider
      return Center(child: SizedBox(child: Text('No data')));
    }

    final List<Medidor> medidorList = listMedidores.value!;

   
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lista de Medidores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background1,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                 // Cambia esto según la cantidad de medidores
                itemCount:medidorList.length,
                itemBuilder: (BuildContext context, int index) {
                  final medidor = medidorList[index];
      
                  return GestureDetector(
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (context) => dialogBuilder(context, medidor),
                        ),
                    child: Card(
                      child: ListTile(
                        title: RichText(
                            text: TextSpan(
                               style: DefaultTextStyle.of(context).style,
                               children: [
                                TextSpan(
                                  text: 'Usuario: ',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: themeColor.background1)
                                ),
                                TextSpan(
                                  text: '${medidor.nombre} ${medidor.apellido}',
                                ),
                               ],
                            ),
                        ),
                        subtitle: Text('Medidor: ${medidor.numMed}'),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        // aquí pones la acción que quieras; por ejemplo:
        ref.invalidate(medidorListProvider);
      },
      child: const Icon(Icons.refresh),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
