import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class AguaCaudal extends ConsumerStatefulWidget {
  const AguaCaudal({super.key});

  @override
  ConsumerState<AguaCaudal> createState() => _AguaCaudalState();
}

class _AguaCaudalState extends ConsumerState<AguaCaudal> {
  // Clave global del formulario para validación y manejo de estado
  final _formKey = GlobalKey<FormState>();

  // Controladores para el manejo de los campos de texto
  final TextEditingController _caudalController = TextEditingController();
  final TextEditingController _unidadController = TextEditingController();

  @override
  void dispose() {
    _caudalController.dispose();
    _unidadController.dispose();
    super.dispose();
  }

  /// Método para procesar el envío del formulario
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Recolección de datos
      final String caudal = _caudalController.text;
      final String unidad = _unidadController.text;

      // Aquí puedes implementar la lógica para almacenar o enviar los datos
      // Por ejemplo, actualizar un provider o enviar los datos a un servicio backend
      print('Registro de caudal: $caudal, Unidad: $unidad');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acceso al tema actual para usar sus colores y estilos
    final theme = Theme.of(context);

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
                    'Registro de caudal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.background1,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo para ingresar el caudal
                TextFormField(
                  controller: _caudalController,
                  decoration: InputDecoration(
                    hintText: 'Caudal',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      'Por favor ingresa el caudal';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Campo para ingresar la unidad de medida
                TextFormField(
                  controller: _unidadController,
                  decoration: InputDecoration(
                    hintText: 'Unidad de medida',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background2,
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
