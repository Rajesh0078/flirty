import 'package:flirty/features/home/screens/home_screen.dart';
import 'package:flirty/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:flirty/features/registration/screens/date_of_birth_screen.dart';
import 'package:flirty/features/registration/screens/email_screen.dart';
import 'package:flirty/features/registration/screens/gender_screen.dart';
import 'package:flirty/features/registration/screens/images_screen.dart';
import 'package:flirty/features/registration/screens/interents_screen.dart';
import 'package:flirty/features/registration/screens/username_screen.dart';
import 'package:flirty/provider/auth_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/dio/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class SplashService {
  DioClient dioClient = DioClient();

  Future<void> fetchUser(WidgetRef ref, BuildContext context) async {
    try {
      final response = await dioClient.get(ApiRoutes.getUser);
      if (response.statusCode == 200 && response.data['success']) {
        final user = response.data['user'];
        ref.read(userProvider.notifier).initializeUser(user);
        Navigator.pushAndRemoveUntil(
          context,
          PageAnimationTransition(
            page: const HomeScreen(),
            pageAnimationType: FadeAnimationTransition(),
          ),
          (route) => false,
        );
      } else {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> navigateToNextScreen(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final authStatus = ref.read(authProvider);
    await Future.delayed(const Duration(seconds: 3));
    print(authStatus);
    if (authStatus['accessToken'] != null) {
      fetchUser(ref, context);
    } else {
      if (authStatus['isRegistrationStarted'] == true) {
        int currentStep = authStatus['currentStep'];
        switch (currentStep) {
          case 1:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const UsernameScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          case 2:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const EmailScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          case 3:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const GenderScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          case 4:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const DateOfBirthScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          case 5:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const InterentsScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          case 6:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const ImagesScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
          default:
            Navigator.pushAndRemoveUntil(
              context,
              PageAnimationTransition(
                page: const OnboardingScreen(),
                pageAnimationType: FadeAnimationTransition(),
              ),
              (route) => false,
            );
            break;
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          PageAnimationTransition(
            page: const OnboardingScreen(),
            pageAnimationType: FadeAnimationTransition(),
          ),
          (route) => false,
        );
      }
    }
  }
}
