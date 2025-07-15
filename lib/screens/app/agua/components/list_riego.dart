import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/presentation/agua_riego/agua_riego_providers.dart';
import 'package:prueva/theme_colors.dart';

class ListRiego extends ConsumerStatefulWidget {
  const ListRiego({super.key});

  @override
  ConsumerState<ListRiego> createState() => _ListRiegoState();
}

class Kitten {
  const Kitten({this.name, this.description, this.age});
  final String? name;
  final String? description;
  final int? age;
}


class _ListRiegoState extends ConsumerState<ListRiego> {
  
  Widget _dialogBuilder(BuildContext context, Map<String, dynamic> item) {
    ThemeData localTheme = Theme.of(context);

    void onUpdateAgRie () async {

    }

    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Detalles del usuario', style: TextStyle(color: localTheme.colorScheme.background1, fontWeight: FontWeight.bold),),
                Text('Nombres: ${item['nombre']} ${item['apellido']}'),
                Text('C.i: ${item['ci']}'),
                Text('Dirección: ${item['direccion']}'),
                Text('Lotes: ${item['lotes']}'),
                // en ves de Text ahy otro wignet para ponet titulo y sumtitulo cual es

                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () async{
                          try {
                          ref.read(deleteAgRieProvider(item['ci']));
                          Navigator.of(context).pop();
                          MessageHelper.showSuccess(context, 'Actualización exitosa');
                          } catch (e) {
                            MessageHelper.showError(context, e.toString());
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      Tooltip(
                        message: 'Editar',
                        waitDuration: Duration.zero,
                        child: TextButton(
                          onPressed: () {
                            // final data = ref.read(getAgRieProvider(item['id']));
                            ref.read(currentTabIndexProvider.notifier).setIndex(1);
                            ref.read(selectedMedidorIdProvider.notifier).state = item['id'];
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue[600],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],              
            ),
            )
        ],

      );
  }

  Widget _listitemBuilder(BuildContext context, Map<String, dynamic> item) {
    ThemeData localTheme = Theme.of(context);
    return GestureDetector(
        onTap: () => showDialog(
            context: context,
             builder: (context) => _dialogBuilder( context, item)),
      child: Card(
        child: ListTile(
          title: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      backgroundColor: localTheme.colorScheme.background2,
                      child: Text(item['nombre'].toString().substring(0, 1), style: TextStyle(color: localTheme.colorScheme.background1),),
                    ),
                  )
                  ),
                 
                TextSpan(
                  text:'${item['nombre']} ${item['apellido']}',
                  style: TextStyle(color: Colors.black)
                ),
              ]
            )
          ),
          trailing: Icon(Icons.chevron_right),
        ),
        // child: GestureDetector(
        //   onTap: () => showDialog(
        //     context: context,
        //      builder: (context) => _dialogBuilder( context, item)),
        //   child: Container(
        //     padding: const EdgeInsets.only(left: 16.0),
        //     alignment: Alignment.centerLeft,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         CircleAvatar(
        //           backgroundColor: localTheme.colorScheme.background2,
        //           child: Text(
        //             item['nombre'].toString().substring(0, 1),
        //             style: TextStyle(color: localTheme.colorScheme.background1),
        //           ),
        //         ),
        //         const SizedBox(width: 16),
        //         RichText(
        //           text: TextSpan(
        //             children: [
        //               TextSpan(
        //                 text:'${item['nombre']} ${item['apellido']}',
        //               ),
        //             ]
        //           ),
        //           ),
        //         // Expanded(
        //         //   child: Text(
        //         //     '${item['nombre']} ${item['apellido']}',
        //         //     style: TextStyle(
        //         //       color: localTheme.colorScheme.background1,
        //         //       fontSize: 16,
        //         //     ),
        //         //   ),
        //         // ),
        //       ],
        //     ),
            
        //   ),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     final listRiego = ref.watch(getListUserAgRiProvider);
      
      if(listRiego.isLoading){
        return const Center( child: CircularProgressIndicator(),);
      }
      if(listRiego.hasError){
      return const Center(child: Text('No data'));
      }
      final list = listRiego.value!;
      
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Riego')),
      body: ListView.builder(
        // itemCount: _kittens.length,
        itemCount: list.length,
        itemExtent: 60.0,
        itemBuilder:  (context, index) => _listitemBuilder(context, list[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.refresh),
        ),
    );
  }
}
