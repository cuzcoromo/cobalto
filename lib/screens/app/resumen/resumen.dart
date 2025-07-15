import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/components/calendar.dart';
import 'package:prueva/components/head_content.dart';
import 'package:prueva/components/pagination.dart';
import 'package:prueva/presentation/resumen/history_user.dart';
import 'package:prueva/presentation/resumen/resumen.dart';
import 'package:prueva/screens/app/resumen/listado.dart';
import 'package:prueva/theme_colors.dart';

class Resumen extends ConsumerStatefulWidget {
  const Resumen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ResumenState();
}

class ResumenState extends ConsumerState<Resumen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
 
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        children: [
          Center(
            child: Text(
              'Resumen de Cobros',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.background1,
              ),
            ),
          ),
          SizedBox(height: 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeadContent(),
              SizedBox(width: 14),
              Calendar(),
              Text('pendiente'),
            ],
          ),
          
          SizedBox(height: 1),
          Listado(), // Ya no necesitas altura fija
          Pagination(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            ref.invalidate(anioProvider);
            ref.invalidate(mesProvider);
            ref.read(anioSeleccionadoProvider.notifier).state = null;
          });
        }
        ),
    );
  }
}
