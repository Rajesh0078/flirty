import 'package:flirty/features/home/screens/home_screen.dart';
import 'package:flirty/features/login/screens/login_screen.dart';
import 'package:flirty/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:flirty/features/registration/screens/phone_number_screen.dart';
import 'package:flirty/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onBoarding = '/onboarding';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';

  // Function to generate routes

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case splash:
        page = const SplashScreen();
        break;
      case onBoarding:
        page = const OnboardingScreen();
        break;
      case login:
        page = const LoginScreen();
        break;
      case register:
        page = const PhoneNumberScreen();
        break;
      case home:
        page = const HomeScreen();
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }

    return PageAnimationTransition(
      page: page,
      pageAnimationType: FadeAnimationTransition(),
    );
  }
}
