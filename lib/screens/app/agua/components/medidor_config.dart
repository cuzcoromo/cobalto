
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class MedidorConfig extends ConsumerStatefulWidget {
  const MedidorConfig({super.key}); // Price per gallon of water

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MedidorConfigState();
}

class _MedidorConfigState extends ConsumerState<MedidorConfig> {
  final TextEditingController _fechaControler = TextEditingController();
  final TextEditingController _numMedidorControler = TextEditingController();
  final TextEditingController _costoInstalacionControler = TextEditingController();
  final TextEditingController _ciControler = TextEditingController();
  final TextEditingController _obsControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _costoInstalacionControler.text = 0.00.toStringAsFixed(2);
    super.initState();
  }

  @override
  void dispose() {
    // _precioController.dispose();
    // _ivaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), 
              child: Center(
                child: Text('Registro de medidor', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.background1, fontSize: 24, fontWeight: FontWeight.bold),
                )
                ),
            ),

            TextFormField(
              controller: _fechaControler,
              decoration: InputDecoration(
                hintText: 'Fecha',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.background1,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background2,
                border:OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)
                ),
                ),
                validator: (String? value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  // _fechaController.text = pickedDate.toIso8601String();
                }
              },
            ),
            // Campo para medidor
            SizedBox(height: 10,),
            TextFormField(
              controller: _numMedidorControler,
              decoration: InputDecoration(
                hintText: 'Número de Medidor',
                hintStyle: TextStyle( color: Theme.of(context).colorScheme.background1),
                prefixIcon: Icon(
                  Icons.numbers_outlined,
                  color: Theme.of(context).colorScheme.background1,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background2,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              validator: (String? value) => value == null || value.isEmpty ? 'Campo requerido' : null,
            ),
            // Campo para lectura final
            SizedBox(height: 10,),
            TextFormField(
              controller: _costoInstalacionControler,
              decoration: InputDecoration(
                hintText: 'Costo de instalación',
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: Theme.of(context).colorScheme.background1,
                ),
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background2,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)
                )
                ),
                validator: (String? value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              keyboardType: TextInputType.number,
            ),
            // Campo para observaciones
            SizedBox(height: 10,),
            TextFormField(
              controller: _ciControler,
              decoration: InputDecoration(
                hintText: 'Cedula del usuario',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background2,
                prefixIcon: Icon(
                  Icons.person_add,
                  color: Theme.of(context).colorScheme.background1,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)
                )
                ),
              validator: (String? value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              inputFormatters: [LengthLimitingTextInputFormatter(10)], 
              keyboardType: TextInputType.number,
            ),
            // Mostrar consumo calculado
            SizedBox(height: 10,),
            // Campo para costo
            TextFormField(
              controller: _obsControler,
              maxLines: null,
              inputFormatters: [LengthLimitingTextInputFormatter(200), ],
              decoration: InputDecoration(
                hintText: 'Observaciones max. 200 caracteres',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background2,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)
                )
                ),
              validator: (String? value) => value == null || value.isEmpty ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.background1
                )
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí guardarías la data en Firestore o la procesarías
                  print('Datos a guardar:');
                  // print({
                  //   'fecha': _fechaController.text,
                  //   'medidor': _medidorController.text,
                  //   'lecturaInicial': _lecturaInicialController.text,
                  //   'lecturaFinal': _lecturaFinalController.text,
                  //   'consumo': consumo,
                  //   'costo': _costoController.text,
                    // 'observaciones': _observacionesController.text,
                  };
                },
              child: const Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
          ],
      ),
      ),
      ),
    );
  }
}