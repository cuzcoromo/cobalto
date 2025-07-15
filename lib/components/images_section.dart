import 'package:flutter/material.dart';

class Imagessection extends StatelessWidget {
  final String image;
  final double height;

  const Imagessection({
    super.key,
    required this.image, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,   // ancho fijo
      height: height,  // alto fijo
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
