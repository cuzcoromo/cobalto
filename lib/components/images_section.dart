import 'package:flutter/material.dart';

class Imagessection extends StatelessWidget {
  final String image;

  const Imagessection({
    super.key,
    required this.image
    });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ocupa todo el ancho disponible
      constraints: BoxConstraints(
        maxHeight: 300
      ),
      child: 
      Image.asset(image, fit: BoxFit.cover,)
    );
  }
}