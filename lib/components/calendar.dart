import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/resumen/resumen.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  String? fecha;
  num? anio;
  num? mes;

  @override
  Widget build(BuildContext context) {
      final anio = ref.watch(anioProvider);
    final mes = ref.watch(mesProvider);
     String fechaTexto;
    if (anio != null && mes != null) {
      fechaTexto = 'Mes $mes, Año $anio';
    } else {
      fechaTexto = 'Fecha';
    }

    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          ref.read(anioProvider.notifier).state = selectedDate.year;
          ref.read(mesProvider.notifier).state = selectedDate.month;
          setState(() {
            fecha = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(fechaTexto, style: const TextStyle(color: Colors.black)),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    );
  }
}
