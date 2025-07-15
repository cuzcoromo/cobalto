import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum MessageType {showSuccess, showError, warning, info}

class MessageHelper {
  static void showSuccess(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    ).show(context);
  }

  static void showError(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.error, color: Colors.white),
    ).show(context);
  }
}
