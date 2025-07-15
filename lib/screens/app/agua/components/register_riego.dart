import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/message.dart';
import 'package:prueva/presentation/agua_consumo/navigation_providers.dart';
import 'package:prueva/presentation/agua_riego/agua_riego_providers.dart';
import 'package:prueva/theme_colors.dart';

class RegisterRiego extends ConsumerStatefulWidget {
  const RegisterRiego({super.key});

  @override
  ConsumerState<RegisterRiego> createState() => _RegisterRiegoState();
}

class _RegisterRiegoState extends ConsumerState<RegisterRiego> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _lotesController = TextEditingController();
  final TextEditingController _direccionControler = TextEditingController();


  void _clearForm() {
    _ciController.clear();
    _lotesController.clear();
    _direccionControler.clear();
  }

  void loadingData(String idSelect) {
  final data = ref.read(getAgRieProvider(idSelect));
  _ciController.text = data['ci'] ?? '';
  _lotesController.text = data['lotes'] ?? '';
  _direccionControler.text = data['direccion'] ?? '';
}

  @override
  Widget build(BuildContext context) {
    // Obtener el tema local
  ThemeData localTheme = Theme.of(context);  
  final idSelect = ref.watch(selectedMedidorIdProvider);

  final formState = ref.watch(riegoFormControlProvider);
  final formCtrl = ref.read(riegoFormControlProvider.notifier);

    //todo Cargar datos si hay selección
    // if (idSelect != null && !formState.isLoading)  {
    //   loadingData(idSelect);
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (idSelect != null && !formState.isLoading && _ciController.text.isEmpty) {
      loadingData(idSelect);
    }
  });

  return Scaffold(
    // appBar: ,
    floatingActionButton:  idSelect != null ?FloatingActionButton(
      backgroundColor:  localTheme.colorScheme.background2,
      child: const Icon(Icons.add),
      onPressed: (){
        _clearForm();
        ref.read(selectedMedidorIdProvider.notifier).state = null;
      }
      ) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  // spacing: 10.0,
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
                    const SizedBox(height: 10),
                    // Campo para ingresar el caudal
                    TextFormField(
                      controller: _ciController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Cedula',
                        hintStyle: TextStyle(color: localTheme.colorScheme.background1),
                        prefixIcon: Icon(Icons.medical_information_outlined, 
                         color: localTheme.colorScheme.background1
                         ),
                        filled: true,
                        fillColor: localTheme.colorScheme.background2,                    
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        counterText: '',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (String? value) =>
                         (value == null || value.isEmpty) ? 'Campo requerido' :null,
                    ),
          
                    const SizedBox(height: 10),
                    // Campo para ingresar la unidad de medida
                    TextFormField(
                      controller: _direccionControler,
                      decoration: InputDecoration(
                        hintText: 'Dirección',
                        hintStyle: TextStyle(color: localTheme.colorScheme.background1,),
                        filled: true,
                        fillColor: localTheme.colorScheme.background2,
                        prefixIcon:  Icon(Icons.location_history_outlined, color: localTheme.colorScheme.background1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (String? value) =>
                        (value == null || value.isEmpty) ? 'Campo requerido':null,
                    ),
                    
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lotesController,
                      decoration: InputDecoration(
                        hintText: 'Número de lotes',
                        hintStyle: TextStyle(
                          color: localTheme.colorScheme.background1,
                        ),
                        filled: true,
                        fillColor: localTheme.colorScheme.background2,
                        prefixIcon: Icon(Icons.numbers, color: localTheme.colorScheme.background1,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                        keyboardType: TextInputType.number,
                      validator: (String? value) =>
                        (value == null || value.isEmpty) ? 'Campo requerido':null,
                    ),
                    const SizedBox(height: 10),
                    // Botón para enviar el formulario
                    Align(
                      alignment: Alignment.center,
                      // child:  asyncCreate.isLoading || asyncUpdate.isLoading
                      child: formState.isLoading == true
                      ? const CircularProgressIndicator()
                      :ElevatedButton(
                        onPressed:  formState.isLoading
                        ? null
                        :() async{
                          if (_formKey.currentState!.validate()){
                            final data = {
                              'ci': _ciController.text.trim(),
                              'direccion': _direccionControler.text.trim(),
                              'lotes': _lotesController.text.trim()
                            };

                            await formCtrl.onRegisterAgRie(data: data, id: idSelect);

                          final result = ref.read(riegoFormControlProvider);
                          result.whenOrNull(
                            error: (e, _){ 
                              MessageHelper.showError(context, e.toString());
                              return;
                              },
                            data: (_) {
                              MessageHelper.showSuccess(context, 'Operacion exitosa');
                              _clearForm();
                              ref.read(selectedMedidorIdProvider.notifier).state = null;
                            }
                          );
                          }
                        },
                        style: ButtonStyle
                        (
                          backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.background1,
                          ),
                        ),
                        child:Text(formState.isLoading ?'Enviando...' :'Guardar',style: TextStyle(color: Colors.white),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}