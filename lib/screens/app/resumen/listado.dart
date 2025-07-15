import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/resumen/resumen.dart';
import 'package:prueva/screens/app/resumen/resumen_card.dart';

class Listado extends ConsumerWidget {
  const Listado({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dataResumenProvider);

    return asyncData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => const Center(child: Text('Error al cargar data')),
      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text('Sin datos'));
        }

        return Column(
          children: List.generate(list.length, (index) {
            final item = list[index];
            return ResumenCard(item: item, ref: ref);
          }),
        );
      },
    );
  }
}
