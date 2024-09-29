import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/registration/screens/date_of_birth_screen.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class GenderScreen extends ConsumerStatefulWidget {
  const GenderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenderScreenState();
}

class _GenderScreenState extends ConsumerState<GenderScreen> {
  bool isLoading = false;
  final GlobalKey _formKey = GlobalKey();
  String _selectedGender = "male";
  final RegistrationService registrationService = RegistrationService();

  void genderUpdate() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final result = await registrationService.updateProfile(
        "gender", _selectedGender, 4, context, ref);
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        PageAnimationTransition(
          page: const DateOfBirthScreen(),
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
              child: Column(
                children: [
                  LogoWidget(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "What's Your Gender?",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Tell us about your gender",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  _buildGenderOption("male", Icons.male),
                                  const SizedBox(width: 20),
                                  _buildGenderOption("female", Icons.female),
                                ],
                              ),
                              _buildGenderOption("others", Icons.transgender),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: genderUpdate,
                              child: const Text("Continue"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            if (isLoading) const OverlayLoaderScreen()
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 2 - 40,
        width: MediaQuery.of(context).size.width / 2 - 40,
        decoration: BoxDecoration(
          color: _selectedGender == gender ? CColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              offset: Offset(0, 1),
              blurRadius: 5,
              spreadRadius: .6,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 34,
                color: _selectedGender == gender ? Colors.white : Colors.black,
              ),
              SizedBox(height: 2),
              Text(
                gender,
                style: TextStyle(
                  color:
                      _selectedGender == gender ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
