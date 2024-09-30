import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/login/services/login_service.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen>
    with CodeAutoFill {
  String? _code = '';
  bool _isLoading = false;
  LoginService loginService = LoginService();

  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code;
    });
  }

  void submitOtp(String code) async {
    if (code.length < 6) {
      ShowToaster().succeesToast(context, "Otp should be 6 digit!");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    await loginService.loginVerifyOtp(widget.phoneNumber, code, ref, context);

    setState(() {
      _isLoading = false;
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
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
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        "Verification Code",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Please enter code we just send to",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PinFieldAutoFill(
                      currentCode: _code,
                      decoration: BoxLooseDecoration(
                        strokeColorBuilder: PinListenColorBuilder(
                          CColors.primary,
                          CColors.accent,
                        ),
                        gapSpace: 8,
                        bgColorBuilder: PinListenColorBuilder(
                          CColors.primary,
                          Colors.transparent,
                        ),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      onCodeSubmitted: (code) {
                        print(code);
                        if (code.length == 6) {
                          submitOtp(code);
                        }
                      },
                      onCodeChanged: (code) {
                        if (code?.length == 6) {
                          setState(() {
                            _code = code;
                          });
                          FocusScope.of(context)
                              .unfocus(); // Dismiss the keyboard
                          submitOtp(code!); // Automatically submit the OTP
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Didn't recieve OTP?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: CColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          submitOtp(_code!);
                        },
                        child: const Text("Verify"),
                      ),
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
