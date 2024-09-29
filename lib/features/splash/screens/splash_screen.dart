import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/splash/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.navigateToNextScreen(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 120,
                    colorFilter: const ColorFilter.mode(
                      CColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Roaste",
                        style: TextStyle(
                          color: CColors.primary,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14159),
                        child: const Text(
                          "R",
                          style: TextStyle(
                            color: CColors.primary,
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150)
                ],
              ),
            ),
          ),
          const Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    "Welcome to the world of dating!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CColors.textColor, // Change to desired color
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "V 1.0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
