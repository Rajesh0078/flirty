import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/features/registration/screens/gender_screen.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  RegistrationService registrationService = RegistrationService();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _submitEmail() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final result = await registrationService.updateProfile(
        "email", emailController.text, 3, context, ref);
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        PageAnimationTransition(
          page: const GenderScreen(),
          pageAnimationType: FadeAnimationTransition(),
        ),
        (route) => false,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Email Address",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We'll need your email to stay in touch!",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.8,
                            fontSize: 18,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitEmail();
                              }
                            },
                            child: const Text("Continue"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isLoading) const OverlayLoaderScreen()
        ],
      )),
    );
  }
}
