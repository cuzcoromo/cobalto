import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class RubrosConfig extends ConsumerStatefulWidget {
  const RubrosConfig({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RubrosConfigState();
}

class _RubrosConfigState extends ConsumerState<RubrosConfig> {
  bool isChecked = false;
  List<bool> isCheckedList = List.generate(20, (index) => false);
  String? opcionSelect;
  DateTime? dateSelect;

  final List<String> opciones = ['Consumo', 'Riego'];
 
  @override
  void initState() {
    super.initState();
    opcionSelect = opciones.first;
  }

  Future<void> _selectData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateSelect ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) {
        final  now = DateTime.now();
        return day.month == now.month || day.isAfter(now); // Disable weekends

      }
    );
    if (picked != null && picked != dateSelect) {
      setState(() {
        dateSelect = picked;
      });
    }
  }

  

  Widget _headConten(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          DropdownButton<String>(
            // hint: const Text('Selecciona'),
            value: opcionSelect,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              color: Colors.transparent,
            ),
            items:
                opciones.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (String? value) {
              setState(() {
                opcionSelect = value;
              });
            },
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () => _selectData(context),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(side: BorderSide.none),
              ),
            ),
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dateSelect != null
                      ? '${dateSelect!.day}/${dateSelect!.month}/${dateSelect!.year}'
                      : 'fecha',
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Cobro de Agua', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: localTheme.colorScheme.background1,
                )),
                SizedBox(child: _headConten(context), ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Rubro ${index + 1}'),
                  subtitle: Text('Descripción del rubro ${index + 1}'),
                  trailing: Checkbox(
                    value: isCheckedList[index],
                    onChanged: (value) {
                      setState(() {
                        isCheckedList[index] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 2.0,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: localTheme.colorScheme.background1,
              ),
              onPressed: () {
                // Acción para agregar un nuevo rubro
              },
              child: Text('Guardar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
