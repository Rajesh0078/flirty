import 'package:flirty/constants/colors.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/logo.svg",
                          height: 32,
                          colorFilter: const ColorFilter.mode(
                            CColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Text(
                          "roaster",
                          style: TextStyle(
                            color: CColors.primary,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Image.asset(
                        "assets/images/onboarding.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  bottom: 20,
                  right: 24,
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    const Text(
                      "Discover Love where your story begins.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(flex: 1),
                    const Text(
                      "Join us to discover your ideal partner and ignite the sparks of romance in your journey.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: const Text(
                          "Join Now",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: CColors.textColor,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, AppRoutes.login);
                            // final code = await SmsAutoFill().getAppSignature;
                            // print(code);
                            // Navigator.push(
                            //   context,
                            //   PageAnimationTransition(
                            //     page: const OtpVerificationScreen(
                            //         phoneNumber: "51215115151"),
                            //     pageAnimationType: FadeAnimationTransition(),
                            //   ),
                            // );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            splashFactory: NoSplash.splashFactory,
                            overlayColor: Colors.transparent,
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: CColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
