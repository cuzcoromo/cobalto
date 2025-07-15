import 'package:flutter/material.dart';
import 'package:prueva/components/error_message.dart';
import 'package:prueva/presentation/users/read_data.dart';
import 'package:prueva/screens/app/users/users_register.dart';
import 'package:prueva/theme_colors.dart';

import '../domain/domain.dart';

class RenderList extends StatelessWidget {
  final List<User> items;

  const RenderList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {

  final ReadDataServices readDataServices = ReadDataServices();
  ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final user = items[i];
          return Card(
            child: ListTile(
              title: Text('${user.name} ${user.apellido}', overflow: TextOverflow.ellipsis),
              subtitle: Text('CI: ${user.ci} - Edad: ${user.edad}', style: TextStyle(fontSize: 12),),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.background2,
                child: Text(user.name[0].toUpperCase(), style: TextStyle(color: theme.colorScheme.background1),),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          // child: UsersRegister( userId: user['id'], ),
                          child: UsersRegister( userId: user.id, ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue.shade600,
                      size: 20,
                    ),
                  ),
                  SizedBox(width:12 ,),
                  GestureDetector(
                      onTap: ()async{
                        // await readDataServices.deleteUsersId(user['id']);
                        await readDataServices.deleteUsersId(user.id);
                        if (!context.mounted) return;
                        showFloatingError(context, 'Usuario actualizado', color:Theme.of(context).colorScheme.primaryColor);
                        return;
                      },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red.shade700,
                      size: 20,
                    ),
                  )
                ],
              ),
              // agregar botoners de editar y eleminar
            ),
          );
        },
      ),
    );
  }
}
