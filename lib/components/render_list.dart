import 'package:flutter/material.dart';
import 'package:prueva/components/error_message.dart';
import 'package:prueva/firebase/read_data.dart';
import 'package:prueva/screens/app/users/users_register.dart';
import 'package:prueva/theme_colors.dart';

class RenderList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const RenderList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {

  final ReadDataServices readDataServices = ReadDataServices();

    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final user = items[i];
          return ListTile(
            title: Text('${user['name']} ${user['apellido']}'),
            subtitle: Text('CI: ${user['ci']} - Edad: ${user['edad']}'),
            leading: CircleAvatar(
              child: Text(user['name'][0]),
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
                        child: UsersRegister( userId: user['id'], ),
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
                      await readDataServices.deleteUsersId(user['id']);
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
          );
        },
      ),
    );
  }
}
