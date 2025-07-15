import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/agua_consumo/medidor_providers.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/presentation/agua_consumo/precio_ac_provider.dart';
import 'package:prueva/theme_colors.dart';

class MedidorConfig extends ConsumerStatefulWidget {
  const MedidorConfig({super.key}); // Price per gallon of water

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MedidorConfigState();
}

class _MedidorConfigState extends ConsumerState<MedidorConfig> {
  final TextEditingController _fechaControler = TextEditingController();
  final TextEditingController _numMedidorControler = TextEditingController();
  final TextEditingController _ciControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;

  @override
  void dispose() {
    _fechaControler.dispose();
    _numMedidorControler.dispose();
    _ciControler.dispose();
    super.dispose();
  }

  void onRegister() async {
    final ci = _ciControler.text;
    final fecha = _fechaControler.text;
    final numM = _numMedidorControler.text;
    if (ci.isEmpty || fecha.isEmpty || numM.isEmpty) return;

    final data = <String, dynamic>{
      'ci': ci,
      'fechaIns': fecha,
      'numMed': numM,
      'isPublished': true,
    };
    final seccess = await ref
        .read(onRegisterProvider.notifier)
        .setOnRegister(data);
    if (!seccess) {
      MessageHelper.showError(context, 'Usuario no registrado');
      return;
    }
    MessageHelper.showSuccess(context, 'Registro exitoso');
    _formKey.currentState?.reset();
  }

  void _clearSelection() {
    // resetea el provider
    ref.read(selectedMedidorIdProvider.notifier).state = null;
    FocusScope.of(context).unfocus();
    // limpia los controladores y el flag
    setState(() {
      _ciControler.clear();
      _fechaControler.clear();
      _numMedidorControler.clear();
      _initialized = false;
    });
  }

  void onUpdate () async{
    final ci = _ciControler.text;
    final fechaIns = _fechaControler.text;
    final numMed = _numMedidorControler.text;
    if( ci.isEmpty || fechaIns.isEmpty || numMed.isEmpty) return;
    final data = <String, dynamic>{
      'ci': ci,
      'fechaIns': fechaIns,
      'numMed': numMed
    };
    try {
      await ref.read(updateMedidorProvider(data).future);
      MessageHelper.showSuccess(context, 'Actualizacion exitosa');
      // 1) Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
      _clearSelection();
    } catch (e) {
      MessageHelper.showError(context, 'Error al actualizar');
      
    }
  }

 
  @override
  Widget build(BuildContext context) {
    // 1) escucha si hay un cambio en el medidorId y limpia los controladores y renicia el ini..
    ref.listen<String?>(selectedMedidorIdProvider, (previous, next) {
      // Solo cuando cambie el valor
      if (next != previous) {
        _ciControler.clear();
        _fechaControler.clear();
        _numMedidorControler.clear();
        setState(() {
          _initialized = false;
        });
      }
    });
    final medidorId = ref.watch(selectedMedidorIdProvider);

    if (medidorId != null) {
      final medidor = ref.watch(getMedidorProvider(medidorId));

      if (medidor.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (medidor.hasError) {
        return Center(child: SizedBox(child: Text('No data')));
      }
      final List<MedidorId> medidorData = medidor.value!;

      if (!_initialized && medidorData.isNotEmpty) {
        _ciControler.text = medidorData[0].ci;
        _fechaControler.text = medidorData[0].fechaIns;
        _numMedidorControler.text = medidorData[0].numMed;
        _initialized = true;
      }
    }

    return Scaffold(
      floatingActionButton:  medidorId != null
      ?FloatingActionButton(
        onPressed: _clearSelection,
        backgroundColor: Theme.of(context).colorScheme.background2,
        child: const Icon(Icons.add),
        
      ) : null,

      // Ubicación por defecto es bottomRight, pero puedes explicitarlo:
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                (medidorId != null) ? 'Actualizar' : 'Registro de medidor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background1,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _ciControler,
                  decoration: InputDecoration(
                    hintText: 'Cedula del usuario',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background2,
                    prefixIcon: Icon(
                      Icons.person_add,
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator:
                      (String? value) =>
                          value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _fechaControler,
                  decoration: InputDecoration(
                    hintText: 'Fecha',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator:
                      (String? value) =>
                          value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      // si el controlador  tiene un valor seleccionar o sino muestrar fecha acltual
                      initialDate: _fechaControler.text.isNotEmpty
                      ?DateFormat('yy-MM-dd').parse(_fechaControler.text) 
                      :DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      _fechaControler.text = DateFormat(
                        'yy-MM-dd',
                      ).format(pickedDate);
                      // cerrar l teclado
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
                // Campo para medidor
                SizedBox(height: 10),
                TextFormField(
                  controller: _numMedidorControler,
                  decoration: InputDecoration(
                    hintText: 'Número de Medidor',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers_outlined,
                      color: Theme.of(context).colorScheme.background1,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background2,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator:
                      (String? value) =>
                          value == null || value.isEmpty
                              ? 'Campo requerido'
                              : null,
                ),

                // Mostrar consumo calculado
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.background1,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if(medidorId != null){
                          onUpdate();
                          return;
                        }
                        onRegister();
                        // Aquí guardarías la data en Firestore o la procesarías
                      }
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
