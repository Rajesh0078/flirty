import 'package:country_picker/country_picker.dart';
import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/login/services/login_service.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _autoValidate = false;
  String _countryCode = '+91';
  String _selectedCountryFlag = '🇮🇳';
  LoginService loginService = LoginService();
  bool _isLoading = false;
  String code = "";

  void loginWithPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    String phoneNumber = _countryCode + _phoneController.text;
    await loginService.loginSendOtp(phoneNumber, code, context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    updateSignature();
  }

  Future<void> updateSignature() async {
    final hash = await SmsAutoFill().getAppSignature;
    setState(() {
      code = hash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/logo.svg",
                          height: 27,
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
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Text(
                        "Login with your Number",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      autovalidateMode: _autoValidate
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: _phoneController,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                fontSize: 18,
                              ),
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
                                          setState(() {
                                            _countryCode =
                                                '+${country.phoneCode}';
                                            _selectedCountryFlag =
                                                country.flagEmoji;
                                          });
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
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                  )),
                              keyboardType: TextInputType.phone,
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginWithPhoneNumber();
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                        child: const Text("Continue"),
                      ),
                    ),
                    const SizedBox(height: 39),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFD8D8D8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFD8D8D8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 64,
                            width: 64,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: CColors.accent, width: 1),
                            ),
                            child: SvgPicture.asset('assets/svg/facebook.svg'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 64,
                            width: 64,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: CColors.accent, width: 1),
                            ),
                            child: SvgPicture.asset('assets/svg/google.svg'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: CColors.textColor,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            splashFactory: NoSplash.splashFactory,
                            overlayColor: Colors.transparent,
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: CColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
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
