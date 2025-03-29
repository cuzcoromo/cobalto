
import 'package:flutter/material.dart';

extension ColorsUi on ColorScheme {
  Color get primaryColor => brightness == Brightness.light ? Colors.blue : Colors.lightBlue;  // Versión para modo oscuro
  Color get secondaryColor => brightness == Brightness.light ? Colors.green : Colors.white;  // Versión para modo oscuro
  Color get background1 => brightness == Brightness.light ? Color(0xFF3f744a) : Colors.white;  // Versión para modo oscuro
  Color get background2 => brightness == Brightness.light ? Color(0xFFdae5dd) : Colors.white;  // Versión para modo oscuro
  Color get text1 => brightness == Brightness.light ? Color(0xFF3f744a) : Colors.white;  // Versión para modo oscuro
  Color get text2 => Colors.white60;
  Color get errorColor => Colors.red;

}