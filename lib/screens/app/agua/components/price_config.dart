import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:prueva/theme_colors.dart';

class PriceConfig extends ConsumerStatefulWidget {
  const PriceConfig({super.key}); // Price per gallon of water

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PriceConfigState();
}

// class _PriceConfigState extends ConsumerState<PriceConfig> {
class PriceConfigState extends ConsumerState<PriceConfig> {
  final _precioController = TextEditingController();
  final _precioInstaalcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;

  @override
  void dispose() {
    _precioController.dispose();
    _precioInstaalcionController.dispose();
    super.dispose();
  }

  void uptatePrice() async {
    final precio = _precioController.text;
    final pInstalacion = _precioInstaalcionController.text;
    if (precio.isEmpty) return;
    final precioValue = double.tryParse(precio) ?? 0.0;
    ref.read(precioConsumoProvider.notifier).setprecio(precioValue);

    if (pInstalacion.isEmpty) return;
    final precioIns = double.tryParse(pInstalacion) ?? 0.0;
    ref.read(precioConsumoProvider.notifier).setPrecioIns(precioIns);

    final data = <String, dynamic>{
      'precio': precioValue,
      'precioins': precioIns,
    };

    try {
      // Llamas al provider como función async
      // await ref.read(setPrecioProvider(data, 'aguaC').future);
      await ref.read(setPrecioProvider(data, 'aguaC').future);
      MessageHelper.showSuccess(context, 'Precio actualizado');
    } catch (e) {
      MessageHelper.showError(context, 'Error al actualizar precio');
    }
  }

  @override
  Widget build(BuildContext context) {
    final preciodata = ref.watch(precioConsumoProvider);
    final getPrecioData = ref.watch(getPrecioProvider);

    // if (!_initialized) {
      // getPrecioData.whenData((dbData) {
      //   final precioCon = dbData['precio'] ?? preciodata.precio;
      //   final precioIns = dbData['precioins'] ?? preciodata.iva;

      //   _precioController.text = precioCon.toString();
      //   _precioInstaalcionController.text = precioIns.toString();
      //   _initialized = true;
      //   // sincronizar el proveedor local
      //   ref.read(precioConsumoProvider.notifier).setprecio(precioCon);
      //   ref.read(precioConsumoProvider.notifier).setPrecioIns(precioIns);
      // });
    // }
 // Inicialización basada en el stream
  getPrecioData.when(
    data: (dbData) {
       if (!_initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final precioCon = dbData['precio'] ?? preciodata.precio;
        final precioIns = dbData['precioins'] ?? preciodata.iva;

        _precioController.text = precioCon.toString();
        _precioInstaalcionController.text = precioIns.toString();
        _initialized = true;

        ref.read(precioConsumoProvider.notifier).setprecio(precioCon);
        ref.read(precioConsumoProvider.notifier).setPrecioIns(precioIns);
      });
    }
      return const SizedBox.shrink();
    },
    loading: () => const Center(child: CircularProgressIndicator(),),
    error: (e, _) => const SizedBox.shrink(),
  );
     
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Configuraciónde precios',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              'Establesca el precio del consumo de agua y el costo de instalacion del medidor',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Precio de consumo'),
                  TextFormField(
                    controller: _precioController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Precio del consumo de agua',
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background1,
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
                          color: Theme.of(context).colorScheme.background1,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Precio de instalción del medidor:'),
                  TextFormField(
                    controller: _precioInstaalcionController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background1,
                      ),
                      hintText: 'Ejemplo: 13.0',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background1,
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
                          color: Theme.of(context).colorScheme.background1,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
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
      ),
    );
  }
}
