import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/resumen/history_user.dart';
import 'package:prueva/theme_colors.dart';

enum FilterType { month, year }

enum FilterValue {
  all('all', null),
  enero('1', 'Enero'),
  febrero('2', 'Febrero'),
  marzo('3', 'Marzo'),
  abril('4', 'Abril'),
  mayo('5', 'Mayo'),
  junio('6', 'Junio'),
  julio('7', 'Julio'),
  agosto('8', 'Agosto'),
  septiembre('9', 'Septiembre'),
  octubre('10', 'Octubre'),
  noviembre('11', 'Noviembre'),
  diciembre('12', 'Diciembre');

  final String id;
  final String? month;
  const FilterValue(this.id, this.month);
}
class HistoryUser extends ConsumerStatefulWidget {
  final String? userId;
  const HistoryUser({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryUserState();
}

class _HistoryUserState extends ConsumerState<HistoryUser> {
  String ci = '';
  num? selectedMounth;

  final TextEditingController _anio = TextEditingController();

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    ci = widget.userId?.split('_').first ?? '';
  }

  void _mostrarConfirmacionCobro(BuildContext context, WidgetRef ref, Map<String, dynamic> item, String mesNombre) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar'),
      // content: Text('¿Cobrar mes de $mesNombre del año ${item['anio']}?'),
      content: RichText(
        text: TextSpan(
          text: 'Cobro para ',
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$mesNombre del ${item['anio']}?',
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background1),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async{
              final id = item['id'];
              if (id == null || id is! String) {
                MessageHelper.showError(context, 'ID inválido');
                return;
              }
             final success = await ref.read(updateHistoryUserProvider(id).future);
              if (!mounted) return;
              Navigator.pop(context);

              if (success) {
                MessageHelper.showSuccess(context, 'Cobro confirmado...');
              } else {
                MessageHelper.showError(context, 'Error al confirmar...');
              }

          },
          child: const Text('Confirmar'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial del Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👉 Fila de filtros
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 32,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _anio,
                    decoration: const InputDecoration(
                      isDense: true, // elimina espacio extra vertical del InputDecoration,
                      hintText: 'Año',
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      final parsed = int.tryParse(value);
                      if (parsed != null && parsed >= 2000) {
                        ref.read(anioSeleccionadoProvider.notifier).state = parsed;
                        _anio.clear();
                        FocusScope.of(context).unfocus();
                        // ref.read(historyUserProvider(ci: ci, anio: parsed));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 90, maxHeight: 30),
                  child: ElevatedButton(
                  onPressed: () {
                      ref.read(anioSeleccionadoProvider.notifier).state = null;
                    }, child: Text('Actual'),
                  ),
                ),
                const SizedBox(width: 10,),
                // ConstrainedBox(
                //   constraints: BoxConstraints(maxWidth: 80),
                //   child: DropdownButton<String>(
                //     isExpanded: true,
                //     menuMaxHeight: 200,
                //     hint: const Text('Mes'),
                //     items: [
                //       for (var mes in FilterValue.values)
                //         DropdownMenuItem(
                //           value: mes.id,
                //           child: Text(mes.month ?? 'Todos', overflow: TextOverflow.ellipsis,),
                //         ),
                //     ],
                //     onChanged: (value) {
                //       if(value == null) return;
                //       selectedMounth = int.tryParse(value);
                //       print(selectedMounth);
                //       // ref.read(filterListUserProvider(mes: selectedMounth));
                //     },
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 16),

            // 👉 Lista de historial (ejemplo con ListView.builder)
            Consumer(
              builder: (context, ref, _) {
                final dataHistory = ref.watch(historyUserProvider(ci: ci));
                
                if(dataHistory.isLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(dataHistory.hasError){
                  return const Center(child: Text('No data'),);
                }
                final  list =  dataHistory.value!;
                
                return list.isEmpty ? const Center(child: Text('No data'),)
                : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length, // aquí va tu data.length
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final completedAt = item['completedAt'] as Timestamp?;
                        final mes = item['mes'] ;
                        final mesStr = mes.toString();
                        final mesNombre = FilterValue.values.firstWhere((e) => e.id == mesStr, orElse: () => FilterValue.all).month ?? 'Desconocido';

                        return Card(
                          shadowColor: completedAt == null ? Colors.red : null,
                          color: completedAt == null ? Colors.red[50] : null,
                          child: ListTile(
                            title: Text('Año ${list[index]['anio']}'),
                            // subtitle: Text('Mes ${list[index]['mes']}'),
                            subtitle: Text('Mes $mesNombre'),
                            trailing:
                                completedAt == null
                                    ? Icon(Icons.money_off_csred_outlined,
                                      color: Colors.red[300],
                                      size: 20,
                                    )
                                    : null,
                            onTap:
                                completedAt == null
                                    ? () {
                                      _mostrarConfirmacionCobro(context, ref, item, mesNombre);
                                    }
                                    : null,
                          ),
                        );
                      },
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
