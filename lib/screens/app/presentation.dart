

import 'package:flutter/material.dart';

class AnimatedUnderline extends StatefulWidget {
  const AnimatedUnderline({super.key});

  @override
  State<AnimatedUnderline> createState() => _AnimatedUnderlineState();
}

class _AnimatedUnderlineState extends State<AnimatedUnderline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const double lineWidth = 250.0;
  static const double circleRadius = 6.0;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true); // bucle de ida y vuelta

    _animation = Tween<double>(begin:lineWidth  - circleRadius, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Registro de usuario",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: lineWidth,
          height: 20,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              bool directiopoint = _controller.status == AnimationStatus.forward;
              return CustomPaint(
                painter: LineWithTrailPainter(_animation.value, directiopoint),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LineWithTrailPainter extends CustomPainter {
  final double circleX;
  final bool directiopoint;
  

  LineWithTrailPainter(this.circleX, this.directiopoint);
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.grey.shade400
      // ..color = Colors.white12
      ..strokeWidth = 0.1;

    final paintTrail = Paint()
      // ..color = Colors.blueAccent
      ..color = Color(0xFF3f744a)
      ..strokeWidth = 2;

    final paintCircle = Paint()
      // ..color = Colors.blue
      ..color = Color(0xFF3f744a)
      ..style = PaintingStyle.fill;


    // Línea base
    // canvas.drawLine(Offset(0, size.height / 2),
    //     Offset(size.width, size.height / 2), paintLine);

    // Estela (de círculo hacia atrás)
    if(directiopoint){
      canvas.drawLine(
        Offset(circleX + 20, size.height / 2), 
        Offset(circleX, size.height / 2), 
        paintTrail
        );
    }else{
    canvas.drawLine(
      Offset(circleX - 20, size.height / 2),
      Offset(circleX, size.height / 2),
      // Offset(size.width, size.height / 2), 
      paintTrail
      );
    }

    // canvas.drawLine(Offset(0, size.height / 2),
    //     Offset(size.width, size.height / 2), paintTrail);


    // Círculo que se mueve
    canvas.drawCircle(Offset(circleX, size.height / 2), 4, paintCircle);
  }

  @override
  

  @override
  bool shouldRepaint(covariant LineWithTrailPainter oldDelegate) =>
      oldDelegate.circleX != circleX;


}
