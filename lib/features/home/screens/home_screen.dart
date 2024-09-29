import 'package:flirty/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:flirty/provider/auth_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    print(user);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home screen"),
            ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  ref.read(userProvider.notifier).removeUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageAnimationTransition(
                          page: OnboardingScreen(),
                          pageAnimationType: FadeAnimationTransition()),
                      (route) => false);
                },
                child: Text("logout"))
          ],
        ),
      ),
    );
  }
}
