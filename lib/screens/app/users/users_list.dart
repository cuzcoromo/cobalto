import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/components/render_list.dart';
import 'package:prueva/firebase/read_data.dart';
import 'package:prueva/theme_colors.dart';

class UsersList extends ConsumerStatefulWidget {
  const UsersList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsersDataList();
}

class _UsersDataList extends ConsumerState<UsersList> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(readDataProvider)['users'] ?? [];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Lista de usuarios',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.background1,
                  ),
                ),
              ),
              // Renderizar la lista de usuarios
              users.isNotEmpty
                  ? RenderList(items: users,)
                  : const Center(child: Text('No data.')),
            ],
          ),
        ),
      ),
    );
  }
}
