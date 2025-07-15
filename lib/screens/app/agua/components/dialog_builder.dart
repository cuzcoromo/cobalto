import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:prueva/screens/app/agua/components/list__medidor_config.dart';
import 'package:prueva/theme_colors.dart';

Widget dialogBuilder(BuildContext context, Medidor medidor) {
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      
      Future<bool> deleteMedidor(String id) async {
        final fireStore = ref.read(fireStoreProvider);
       try {
        await fireStore.collection('medidor').doc(id).update({
          'isPublished': false
          });
        return true;
       } catch (e) {
         return false;
       }
        
      }

      return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Número de medidor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background1,
                  ),
                ),
                Text(
                  '${medidor.numMed}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () async {
                        await deleteMedidor(medidor.id!);
                        Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ref.read(currentTabIndexProvider.notifier).setIndex(1);
                          ref.read(selectedMedidorIdProvider.notifier).state = medidor.id;
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        // content: Text('Medidor: ${medidor['numMed']}'),
      );
    },
  );
}
