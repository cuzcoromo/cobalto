

// file: lib/presentation/widgets/head_conten.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/resumen/resumen.dart';
import 'package:prueva/presentation/rubros/cobro_providers.dart';

class HeadContent extends ConsumerStatefulWidget {
  final String? title;
  const HeadContent({super.key, this.title});

  @override
  ConsumerState<HeadContent> createState() => _HeadContentState();
}

class _HeadContentState extends ConsumerState<HeadContent> { 

  @override
  Widget build(BuildContext context) {
    final opcions = ref.watch(filterOpcionPagoProvider);

     // ✅ Escuchar cambios de filtro dentro del build
    ref.listen<FilterPago>(
      filterOpcionPagoProvider,
      (previous, next) {
        if (previous != next) {
          ref.read(lastDocProvider.notifier).state = null;
          ref.read(historyProvider.notifier).state = [];
          ref.invalidate(dataResumenProvider);
        }
      },
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.vertical,
        // spacing: 0,
        children: [
          if (widget.title != null) Text(widget.title!), // 👈 Solo se renderiza si hay título
          DropdownButton<FilterPago>(
            value: opcions,
            items: FilterPago.values
                .map((FilterPago value) => DropdownMenuItem<FilterPago>(
                      value: value,
                      child: Text(value.name),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(filterOpcionPagoProvider.notifier).select(value);
              }
            },
          ),
        ],
      ),
    );
  }
}