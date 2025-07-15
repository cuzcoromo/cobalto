
import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF3f744a);

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Row(
        children: [
          // Padding solo al texto (izquierda)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'COBALTO',
                  style: TextStyle(
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(), // Empuja la imagen completamente a la derecha

          // Imagen sin padding, pegada al borde derecho
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'images/login_favicon.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
