
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/resumen/history_user.dart';
import 'package:prueva/screens/app/resumen/history_user.dart';
import 'package:prueva/theme_colors.dart';

class ResumenCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final WidgetRef? ref;

  const ResumenCard({super.key, required this.item, this.ref});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

     return Card(
       child: ListTile(
                title: Text('Usr: ${item['nombre']} ${item['apellido']}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13 ), ),
                subtitle: Text('Año: ${item['anio']}, Mes: ${item['mes']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item['completedAt'] != null ? 'Pagado' : 'Deudor', style: TextStyle(
                  color: item['completedAt'] != null ? theme.colorScheme.primaryColor : theme.colorScheme.errorColor,
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(width: 8,),
                Icon(Icons.chevron_right)
                  ],
                ),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      if(item['completedAt'] == null){
                      final anio = item['anio'];
                      Future.microtask((){
                        ref?.read(anioSeleccionadoProvider.notifier).state = anio ;
                      });
                      }
                    return HistoryUser(userId: item['id']);
                    } 
                  ),
                  );
                },
                
              ),
     );
  }
}