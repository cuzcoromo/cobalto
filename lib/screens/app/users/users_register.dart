import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueva/components/error_message.dart';
import 'package:prueva/firebase/data_services.dart';
import 'package:prueva/theme_colors.dart';
import 'package:intl/intl.dart';

class UsersRegister extends ConsumerStatefulWidget {
  const UsersRegister({super.key});

  @override
  ConsumerState<UsersRegister> createState() => _UsersRegisterState();
}

class _UsersRegisterState extends ConsumerState<UsersRegister> {
  final _formKey = GlobalKey<FormState>();
  final DataServices dataServices = DataServices();

  final _nameController = TextEditingController();
  final _apellidoControler = TextEditingController();
  final _edadControler = TextEditingController();
  final _ciControler = TextEditingController();
  final _ecControler = TextEditingController();
  final _fnControler = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void onRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool exist = await dataServices.existCi(_ciControler.text);
      if(exist){
        showFloatingError(context, 'Usuario registrado');
        return;
      }
      try {
        // todo Subir todo primero 
        // String? photoUrl;
        // if(_imageFile != null){
        //   photoUrl = await dataServices.uploadImage(_imageFile!);
        //   if(photoUrl == null ){
        //     showFloatingError(context, 'Error al subir foto');
        //     return;
        //   }
        // }

        await dataServices.create(
          'users', {
            'name': _nameController.text,
            'apellido': _apellidoControler.text,
            'edad': _edadControler.text,
            'ci': _ciControler.text,
            'ec': _ecControler.text,
            'fn': _fnControler.text,
          },
        );
        showFloatingError(context, 'Usuario registrado', color:Theme.of(context).colorScheme.background2);
      } catch (e) {
        showFloatingError(context, 'Error al registrar el usuario');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Registro de Usuarios',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Nombres',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background1,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _apellidoControler,
                    decoration: InputDecoration(
                      hintText: 'Apellidos',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _edadControler,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Edad',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2,
                      prefixIcon: Icon(
                        Icons.cake,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: ( value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ciControler,
                    decoration: InputDecoration(
                      hintText: 'Cedula',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2,
                      prefixIcon: Icon(
                        Icons.badge,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _ecControler.text.isEmpty ? null : _ecControler.text,
                    decoration: InputDecoration(
                      hintText: 'Estado Civil',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                      prefixIcon: Icon(
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2, 
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    items: [ 'Soltero', 'Casado', 'Divorciado', 'Viudo', 'Unión libre',].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _ecControler.text = newValue ?? '';
                    },
                    validator: (value) {
                      if (_ecControler.text.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _fnControler,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        _fnControler.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Fecha de nacimiento',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background2,
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _takePhoto,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background2,
                        borderRadius: BorderRadius.circular(100),
                        image: _imageFile != null 
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              )
                            : null,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          if (_imageFile == null)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, 
                                    color: Theme.of(context).colorScheme.background1),
                                Text('Tomar foto',
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.background1)),
                              ],
                            ),
                          if (_imageFile != null)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: GestureDetector(
                                onTap: () => setState(() => _imageFile = null),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:  Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.background1
                        ),
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                      ),
                      onPressed: () => onRegister(context),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}