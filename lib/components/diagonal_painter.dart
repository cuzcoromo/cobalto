
import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ..color = const Color(0xFF3f744a).withValues()
      ..color =Color.fromARGB(204, 255, 255, 255) // 204/255 ≈ 0.8
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.45, 0); // Punto superior izquierdo de la franja
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.80, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
