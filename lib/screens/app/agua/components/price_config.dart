import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/theme_colors.dart';

class PriceConfig extends ConsumerStatefulWidget {

  const PriceConfig({super.key}); // Price per gallon of water

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceConfigState();
}

class _PriceConfigState extends ConsumerState<PriceConfig> {
  final  _precioController = TextEditingController();
  String?  _precioError;
  final  _ivaController = TextEditingController();
  String?  _ivaError;

  double _precio = 1.00;
  double _iva = 0.0;

  @override
  void initState() {
    super.initState();
    _precioController.text = _precio.toString();
    _ivaController.text = _iva.toString();    
  }

  @override
  void dispose() {
    _precioController.dispose();
    _ivaController.dispose();
    super.dispose();
  }

  void  uptatePrice() async {
      // if (_formKey.currentState!.validate()) {
    // if (_precioController.text.isEmpty) {
    if (_precioController.text.isEmpty) {
      setState(() {
        _precioError = 'Campo requerido';
      });
      return;
  }
    if (_ivaController.text.isEmpty) {
      setState(() {
        _ivaError = 'Campo requerido';
      });
      return;
    }
    setState(() {
      _precio = double.tryParse(_precioController.text) ?? 0.0;
      _iva = double.tryParse(_ivaController.text) ?? 0.0;
    });
  }
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Configuración de precios',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.background1,
              ),
            ),
          ),
          Text('Establesca el precio del consumo de agua y el IVA a aplicar (opcional)', style: TextStyle(color: Colors.grey[600]),),
          const SizedBox(height: 20),
          TextFormField(
            controller: _precioController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Precio por litro',
              errorText: _precioError,
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.background1,),
              hintText: 'Precio del consumo de agua',
              prefixIcon: const Icon(Icons.attach_money, size:16,),
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1,),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.background1,
                  width: 1.0,
                ),
              ),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.background1, // o cualquier color que quieras
                  width: 1.5,
                ),
              ),
              ),
            validator: (String? value) => value == null ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 20),
          
          TextFormField(
            controller: _ivaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'IVA (opcional)',
              errorText: _ivaError,
              prefixIcon: const Icon(Icons.attach_money, size: 16,),
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.background1,),
              hintText: 'Ejemplo: 13.0',
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.background1,),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.background1,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.background1, // o cualquier color que quieras
                  width: 1.5,
                ),
              ),
              ),
            validator: (String? value) => value == null ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.background1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: uptatePrice,
            child: Text('Enviar', style: TextStyle(color: Colors.white),),
          ),
        ],
           ),
     );
  }
}