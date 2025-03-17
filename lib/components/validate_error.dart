import 'package:flutter/material.dart';

String? validateField<T>({
  required T? value,
  required String errorMessage,
  // required ValueNotifier<String?> errorNotifier,
  String? Function(T?)? validator,
}) {
  String? error;

  // Validar que sea un email correcto
  if(errorMessage is String  && errorMessage == 'email'){
    
  }
  // Validación básica: campo vacío o nulo
  if (value == null || (value is String && value.isEmpty)) {
    // error = errorMessage;
    error = 'Ingrese $errorMessage';
  }
  // Validación personalizada (si se proporciona)
  else if (validator != null) {
    error = validator(value);
  }

  // Actualiza el ValueNotifier con el error (o lo limpia si es null)
  // errorNotifier.value = error;
  return error;
}