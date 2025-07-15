import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/components/head_content.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:prueva/presentation/rubros/cobros_consumo_providers.dart';
import 'package:prueva/theme_colors.dart';

class RubrosConfig extends ConsumerWidget {

  List<String> opciones = ['Consumo', 'Riego'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData localTheme = Theme.of(context);
    ref.watch(cobroSyncControllerProvider);
    final listActive = ref.watch(todosFilteredListProvider);
    final price = ref.watch(getPrecioCobroProvider);
    final currentFilter = ref.watch(todoCurrentFilterProvider);
    final data = ref.watch(listaCobroProvider);
    final isBloqued = ref.watch(isBloque);

    if (data.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final precio = price.value!;

    if (listActive.isNotEmpty) {
      ref.watch(isBloquedProvider);
    } 

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cobro de Agua',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: localTheme.colorScheme.background1,
                  ),
                ),
                SizedBox(
                  child: SegmentedButton<FilterType>(
                    segments: const [
                      ButtonSegment(value: FilterType.all, icon: Text('Todos')),
                      ButtonSegment(
                        value: FilterType.completed,
                        icon: Text('Pagado'),
                      ),
                      ButtonSegment(
                        value: FilterType.pending,
                        icon: Text('No pagado'),
                      ),
                    ],
                    selected: <FilterType>{currentFilter},
                    onSelectionChanged: isBloqued
                            ? null
                            : (value) {
                              ref
                                  .read(todoCurrentFilterProvider.notifier)
                                  .setFilter(value.first);
                            },
                  ),
                ),
                // SizedBox(child: _headConten(context, ref)),
                SizedBox(
                  child: HeadContent(title: 'Selecciona consumo a cobrar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (listActive.isNotEmpty && isBloqued)
                  ModalBarrier(
                    dismissible: false,
                    color: Colors.grey.withAlpha((0.2 * 255).round()),
                  ),

                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: listActive.length,
                        itemBuilder: (context, index) {
                          final user = listActive[index];
                          final precio_id = precio['id'];
                          return SwitchListTile(
                            title: Text('${user.nombre} ${user.apellido}'),
                            subtitle: Text(
                              'Valor a cobrar: ${precio['precio']}',
                            ),
                            value: user.completedAt != null,
                            onChanged:
                                isBloqued
                                    ? null
                                    : (value) {
                                      ref
                                          .read(listActiveProvider.notifier)
                                          .updateItem(user.id, precio_id);
                                    },
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: SizedBox(
                            width: double.infinity,
                            child:
                                !!isBloqued
                                    ? null
                                    : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            localTheme.colorScheme.background1,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 12.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          isBloqued
                                              ? null
                                              : () async {
                                                try {
                                                  final mensaje = await ref.read(registerCobroListProvider.future,);
                                                  if (mensaje != null) {
                                                    MessageHelper.showError(
                                                      context,
                                                      mensaje,
                                                    );
                                                    ref
                                                        .read(isBloque.notifier)
                                                        .state = false;
                                                  } else {
                                                    MessageHelper.showSuccess(
                                                      context,
                                                      'Registro exitoso',
                                                    );
                                                    ref
                                                        .read(isBloque.notifier)
                                                        .state = true;
                                                  }
                                                } catch (e) {
                                                  MessageHelper.showError(
                                                    context,
                                                    'Error al registrar',
                                                  );
                                                  ref
                                                      .read(isBloque.notifier)
                                                      .state = false;
                                                }
                                              },
                                      child: const Text(
                                        'Guardar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}