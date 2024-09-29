import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/registration/screens/interents_screen.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class DateOfBirthScreen extends ConsumerStatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends ConsumerState<DateOfBirthScreen> {
  String? selectedDate;
  RegistrationService registrationService = RegistrationService();
  bool isLoading = false;

  void _submitDOB() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final result = await registrationService.updateProfile(
        "dob", selectedDate!, 5, context, ref);
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        PageAnimationTransition(
          page: const InterentsScreen(),
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
    DateTime currentDate = DateTime.now();
    DateTime lastDate =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const LogoWidget(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "What's Your Date of Birth",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Please provide your Date of Birth!",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatePickerWidget(
                        onChange: (dateTime, selectedIndex) {
                          setState(() {
                            selectedDate = dateTime.toString();
                          });
                        },
                        lastDate: lastDate,
                        locale: DatePicker.localeFromString('en'),
                        pickerTheme: const DateTimePickerTheme(
                          pickerHeight: 250,
                          dividerSpacing: 10,
                          diameterRatio: 3,
                          squeeze: 0.8,
                          itemHeight: 46,
                          dividerColor: CColors.primary,
                          itemTextStyle: TextStyle(
                            color: CColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedDate!.isNotEmpty) {
                              _submitDOB();
                            }
                          },
                          child: const Text("Continue"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          if (isLoading) const OverlayLoaderScreen()
        ],
      )),
    );
  }
}
