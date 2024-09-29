import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/registration/screens/images_screen.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class InterentsScreen extends ConsumerStatefulWidget {
  const InterentsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InterestsScreenState();
}

class _InterestsScreenState extends ConsumerState<InterentsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final RegistrationService registrationService = RegistrationService();
  final List<Map<String, String>> interests = [
    {'name': 'Reading', 'icon': 'assets/svg/reading.svg'},
    {'name': 'Photography', 'icon': 'assets/svg/camera.svg'},
    {'name': 'Gaming', 'icon': 'assets/svg/gaming.svg'},
    {'name': 'Music', 'icon': 'assets/svg/music.svg'},
    {'name': 'Travel', 'icon': 'assets/svg/travel.svg'},
    {'name': 'Painting', 'icon': 'assets/svg/painting.svg'},
    {'name': 'Politics', 'icon': 'assets/svg/politics.svg'},
    {'name': 'Pets', 'icon': 'assets/svg/pets.svg'},
    {'name': 'Sports', 'icon': 'assets/svg/sports.svg'},
    {'name': 'Charity', 'icon': 'assets/svg/charity.svg'},
    {'name': 'Cooking', 'icon': 'assets/svg/cooking.svg'},
    {'name': 'Fashion', 'icon': 'assets/svg/fashion.svg'},
  ];

  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  bool isSelected(String interest) {
    return selectedInterests.contains(interest);
  }

  void _submitInterests() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final result = await registrationService.updateProfile(
        "interests", selectedInterests, 6, context, ref);
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        PageAnimationTransition(
          page: const ImagesScreen(),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Select Up to 3 Interests",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Tell us what piques your curiosity and passions",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  interestButton(interests[0]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[1]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  interestButton(interests[2]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[3]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[4]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  interestButton(interests[5]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[6]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  interestButton(interests[7]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[8]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[9]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  interestButton(interests[10]),
                                  const SizedBox(width: 8),
                                  interestButton(interests[11]),
                                ],
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (selectedInterests.length > 3) {
                                  _submitInterests();
                                } else {
                                  return null;
                                }
                              },
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
            )
          ],
        ),
      ),
    );
  }

  Widget interestButton(Map<String, String> list) {
    bool selected = isSelected(list['name']!);

    return GestureDetector(
      onTap: () {
        toggleInterest(list['name']!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: selected ? CColors.primary : CColors.primary.withOpacity(.1),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              list['icon']!,
              color: selected ? Colors.white : CColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              list['name']!,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
