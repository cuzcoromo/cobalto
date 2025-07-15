import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/agua_consumo/precio_ac_provider.dart';
import 'package:prueva/presentation/agua_riego/agua_riego_providers.dart';
import 'package:prueva/theme_colors.dart';

class PriceRiego extends ConsumerStatefulWidget {
  const PriceRiego({super.key}); // Price per gallon of water

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceConfigState();
}

class _PriceConfigState extends ConsumerState<PriceRiego> {
  final _precioController = TextEditingController();
  final _precioMantenimientoController = TextEditingController();
  // formKey
  final _formKey = GlobalKey<FormState>();
  final List<String> options = ['Mensual', 'Lotes'];

  // precio inicial de los campos
  double _precio = 0.00;
  double _preciom = 0.00;
  String? selectedTipo;

  @override
  void initState() {
    super.initState();
    _precioController.text = _precio.toString();
    _precioMantenimientoController.text = _preciom.toString();
  }

  // limpieza de los controladores a cambiar de ruta
  @override
  void dispose() {
    _precioController.dispose();
    _precioMantenimientoController.dispose();
    super.dispose();
  }

  // Actualizacion de precio async
  void uptatePrice() async {
    if (_formKey.currentState!.validate()) {
      final nuevoPrecio = double.tryParse(_precioController.text)!;
      final nuevoMto = double.tryParse(_precioMantenimientoController.text)!;

      setState(() {
        _precio = nuevoPrecio;
        _preciom = nuevoMto;
      });
      final data = {
        'precio': nuevoPrecio,
        'precioMto': nuevoMto,
        'tipo': selectedTipo,
        'isPublished': true,
        'category': 'R'
      };
      try {
        await ref.read(setPrecioProvider(data, 'aguaR').future);
        MessageHelper.showSuccess(context, 'Registro exitoso');
      } catch (e) {
        MessageHelper.showError(context, 'Error al registrar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final price = ref.watch(getPriceMtoProvider);
    price.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const Center(child: Text('No data')),
      data: (data) {
        _precioController.text = data['precio'].toString();
        _precioMantenimientoController.text = data['precioMto'].toString();
        selectedTipo = data['tipo'].toString();
      },
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Precio de riego',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.background1,
                ),
              ),
            ),
          ),
          Text(
            'Establesca el precio y el IVA si desea aplicar (opcional)',
            style: TextStyle(color: Colors.grey[600]),
          ),
          // Formulaio de precios
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border:  OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius .circular(10.0)),
                      borderSide: BorderSide(width: 1),
                    ),
                  ) ,
                  isExpanded: true, // ocupar toda la pantalla
                  value: selectedTipo,
                  hint: Text('Selecciona tipo de cobro', style: TextStyle(color: theme.colorScheme.background1),),
                  items: options.map(
                  (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: theme.colorScheme.background1),),
                      ),
                    ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTipo = value;
                    });
                  },
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Campo requerido';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 10),
                Text('Precio'),
                TextFormField(
                  controller: _precioController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Precio del consumo de agua',
                    prefixIcon: Icon(
                      Icons.attach_money,
                      size: 16,
                      color: theme.colorScheme.background1,
                    ),
                    hintStyle: TextStyle(color: theme.colorScheme.background1),
                    filled: true,
                    fillColor: theme.colorScheme.background2,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.background1,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color:
                            theme
                                .colorScheme
                                .background1, // o cualquier color que quieras
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator:
                      (String? value) =>
                          (value == null || value.isEmpty)
                              ? 'Campo requerido'
                              : null,
                ),
                const SizedBox(height: 10),
                Text('precio mantenimiento'),
                TextFormField(
                  controller: _precioMantenimientoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Ejemplo: 13.0',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    prefix: Icon(
                      Icons.attach_money,
                      size: 16,
                      color: theme.colorScheme.background1,
                    ),
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
                        color:
                            theme
                                .colorScheme
                                .background1, // o cualquier color que quieras
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator:
                      (String? value) =>
                          (value == null || value.isEmpty)
                              ? 'Campo requerido'
                              : null,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.background1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            uptatePrice();
                          }
                    },
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
