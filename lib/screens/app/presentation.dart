import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // igual que justify-between
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    12,
                  ), // @[480px]:px-4 @[480px]:py-3
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // @[480px]:rounded-xl
                    child: Container(
                      height: 320, // min-h-80
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: AssetImage('images/presentation.png'),
                        ),
                        color: Color(0xFFF9FAFB),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'COBALTO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF101418),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '"Gestiona tu consumo de agua de manera eficiente y sostenible."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF101418),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            // Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 16,
            //         vertical: 12,
            //       ),
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             foregroundColor: const Color(0xFF101418),
            //             backgroundColor: const Color(0xFFb2cae5),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(
            //                 100,
            //               ), // rounded-full
            //             ),
            //             padding: const EdgeInsets.symmetric(horizontal: 20),
            //             minimumSize: const Size.fromHeight(48), // h-12
            //             textStyle: const TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //               letterSpacing: 0.24,
            //             ),
            //           ),
            //           onPressed: () {},
            //           child: const Text(
            //             'Get Started',
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: 20), // h-5
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
