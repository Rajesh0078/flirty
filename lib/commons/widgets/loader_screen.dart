import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OverlayLoaderScreen extends StatelessWidget {
  const OverlayLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        Center(
          child: Container(
            child: Lottie.asset(
              "assets/lottie/loader.json",
              height: 120,
            ),
          ),
        ),
      ],
    );
  }
}
