import 'package:country_picker/country_picker.dart';
import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberScreen extends ConsumerStatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends ConsumerState<PhoneNumberScreen> {
  final RegistrationService registrationService = RegistrationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _autoValidate = false;
  String _countryCode = '+91';
  String _selectedCountryFlag = '🇮🇳';
  bool _isLoading = false;

  void submitPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });
    final phone = _countryCode + _phoneController.text;
    await registrationService.registerSendOtp(phone, context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_isLoading) const OverlayLoaderScreen(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LogoWidget(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Mobile Number",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "We'll need your phone number to send an OTP for verification.",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Form(
                      key: _formKey,
                      autovalidateMode: _autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    countryListTheme:
                                        const CountryListThemeData(
                                      bottomSheetHeight: 400,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    onSelect: (country) {
                                      setState(
                                        () {
                                          _countryCode =
                                              '+${country.phoneCode}';
                                          _selectedCountryFlag =
                                              country.flagEmoji;
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 21,
                                        right: 8,
                                      ),
                                      child: Text(
                                        _selectedCountryFlag,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              _countryCode,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: CColors.textColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            " | ",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  21, 33, 31, .2),
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                              fontSize: 18,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.length < 8 || value.length > 10) {
                                return 'Invalid Phone number!';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _autoValidate = true;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  submitPhoneNumber();
                                } else {
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                }
                              },
                              child: const Text("Continue"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (_isLoading) const OverlayLoaderScreen()
          ],
        ),
      ),
    );
  }
}
