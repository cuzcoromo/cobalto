import 'package:flutter/material.dart';
import 'dart:io';

class FormUtils {
  static void clearFormRegister({
    required TextEditingController nameController,
    required TextEditingController apellidoControler,
    required TextEditingController edadControler,
    required TextEditingController ciControler,
    required TextEditingController ecControler,
    required TextEditingController fnControler,
    required void Function(void Function()) setState,
    File? imageFile,
  }) {
    nameController.clear();
    apellidoControler.clear();
    edadControler.clear();
    ciControler.clear();
    ecControler.clear();
    fnControler.clear();
    setState( () => imageFile = null);
  }
}