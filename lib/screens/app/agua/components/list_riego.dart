import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final List<Kitten> _kittens = <Kitten>[
  const Kitten(name: 'Mittens', description: 'A cute kitten', age: 1),
  const Kitten(name: 'Whiskers', description: 'A playful kitten', age: 2),
  const Kitten(name: 'Fluffy', description: 'A fluffy kitten', age: 3),
];

class _ListRiegoState extends ConsumerState<ListRiego> {
  
  Widget _dialogBuilder(BuildContext context, Kitten kitten) {
    ThemeData localTheme = Theme.of(context);
    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(kitten.name ?? ""),
                Text(kitten.age != null ? kitten.age.toString() : ""),
                Text(kitten.description ?? ""),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
                            // Aquí puedes implementar la lógica para editar el elemento
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

  Widget _listitemBuilder(BuildContext context, int index) {
    ThemeData localTheme = Theme.of(context);
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
         builder: (context) => _dialogBuilder( context, _kittens[index])),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          _kittens[index].name ?? 'No name',
          style: TextStyle(
            color: localTheme.colorScheme.background1,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Riego')),
      body: ListView.builder(
        itemCount: _kittens.length,
        itemExtent: 60.0,
        itemBuilder: _listitemBuilder,
      ),
    );
  }
}
