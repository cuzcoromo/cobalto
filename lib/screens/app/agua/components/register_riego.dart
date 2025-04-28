import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class RegisterRiego extends ConsumerStatefulWidget {
  const RegisterRiego({super.key});


  @override
  ConsumerState<RegisterRiego> createState() => _RegisterRiegoState();
}

class _RegisterRiegoState extends ConsumerState<RegisterRiego> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _caudalController = TextEditingController();
  final TextEditingController _unidadController = TextEditingController();
  final TextEditingController _direccionControler = TextEditingController();
  int currentPageIndex = 0;

  void _submitForm(){
    if (_formKey.currentState!.validate()){}
  }


  @override
  Widget build(BuildContext context) {
  ThemeData localTheme = Theme.of(context);  
  return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Título del formulario
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Registro de usuario de Riego',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: localTheme.colorScheme.background1,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo para ingresar el caudal
                TextFormField(
                  controller: _caudalController,
                  decoration: InputDecoration(
                    hintText: 'Cedula',
                    hintStyle: TextStyle(
                      color: localTheme.colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: localTheme.colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Por favor ingresa el caudal';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo para ingresar la unidad de medida
                TextFormField(
                  controller: _direccionControler,
                  decoration: InputDecoration(
                    hintText: 'Dirección',
                    hintStyle: TextStyle(
                      color: localTheme.colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: localTheme.colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la unidad de medida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _unidadController,
                  decoration: InputDecoration(
                    hintText: 'Numero de lotes',
                    hintStyle: TextStyle(
                      color: localTheme.colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: localTheme.colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                    keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la unidad de medida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Botón para enviar el formulario
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.background1,
                    ),
                  ),
                  child: Text('Registrar',style: TextStyle(color: Colors.white),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}