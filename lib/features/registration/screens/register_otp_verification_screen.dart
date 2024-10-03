import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RegisterOtpVerificationScreen extends ConsumerStatefulWidget {
  final String phone;
  const RegisterOtpVerificationScreen({super.key, required this.phone});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterOtpVerificationScreenState();
}

class _RegisterOtpVerificationScreenState
    extends ConsumerState<RegisterOtpVerificationScreen> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();
  RegistrationService registrationService = RegistrationService();
  bool _isLoading = false;
  String? _code; // This will store the auto-filled OTP code

  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode(); // Start listening for SMS with OTP
  }

  @override
  void dispose() {
    super.dispose();
    cancel(); // Cancel the SMS listener
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code; // Auto-fill the OTP code when received
      otpController.text = _code ?? ""; // Update the OTP input field
    });

    // Automatically verify the OTP when it's fully received
    if (_code != null && _code!.length == 6) {
      FocusScope.of(context).unfocus(); // Dismiss the keyboard
      verifyOtp();
    }
  }

  void verifyOtp() async {
    if (otpController.text.length < 6) {
      ShowToaster().succeesToast(context, "Otp required");
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await registrationService.registerVerifyOtp(
        widget.phone, otpController.text, context, ref);
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
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LogoWidget(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Verification Code",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Please enter code we just send to",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      widget.phone,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 28),
                    PinFieldAutoFill(
                      autoFocus: true,
                      codeLength: 6,
                      controller: otpController,
                      currentCode: otpController.text,
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
                        if (code.length == 6) {
                          setState(() {
                            otpController.text = code;
                          });
                          FocusScope.of(context).unfocus();
                          verifyOtp();
                        }
                      },
                      onCodeChanged: (code) {
                        setState(() {
                          otpController.text = code!;
                        });
                        if (code!.length == 6) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          verifyOtp();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
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
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: verifyOtp,
                        child: const Text("Verify"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading) OverlayLoaderScreen(),
          ],
        ),
      ),
    );
  }
}
