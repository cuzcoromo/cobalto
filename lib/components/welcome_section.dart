import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      // que ocupe todo el ancho de la pantalla
      width: MediaQuery.of(context).size.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'COBALTO',
                style: TextStyle(
                  color: Color(0xFF3f744a),
                  fontWeight: FontWeight.bold,
                  fontSize: 24

                ),
                ),
              Text(
                'Login to your account',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
                )
            ],
          ),
          SizedBox(width: 30,),
            Image.asset('images/login_favicon.png', height: 80,),
        ],
      ),
    );
  }
}