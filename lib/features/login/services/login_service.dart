import 'package:dio/dio.dart';
import 'package:flirty/features/home/screens/home_screen.dart';
import 'package:flirty/features/login/screens/otp_verification_screen.dart';
import 'package:flirty/provider/auth_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class LoginService {
  Dio dio = Dio();

  Future<bool> loginSendOtp(
      String phone, String hash, BuildContext context) async {
    try {
      final response = await dio.post(
        ApiRoutes.loginSendOtp,
        data: {"phone": phone, "hash": hash},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          ShowToaster().succeesToast(context, data['message']);
          Navigator.push(
            context,
            PageAnimationTransition(
              page: OtpVerificationScreen(phoneNumber: phone),
              pageAnimationType: FadeAnimationTransition(),
            ),
          );
          return true;
        } else {
          print(data);
          ShowToaster().succeesToast(context, data['message']);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> loginVerifyOtp(
      String phone, String otp, WidgetRef ref, BuildContext context) async {
    try {
      final response = await dio.post(
        ApiRoutes.login,
        data: {
          'phone': phone,
          'otpCode': otp,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final user = response.data['user'];
        if (data['success']) {
          ShowToaster().succeesToast(context, data['message']);
          ref.read(authProvider.notifier).login(data['token'], user['phone']);
          ref.read(userProvider.notifier).initializeUser(user);
          Navigator.pushAndRemoveUntil(
            context,
            PageAnimationTransition(
              page: HomeScreen(),
              pageAnimationType: FadeAnimationTransition(),
            ),
            (route) => false,
          );
          return true;
        } else {
          ShowToaster().succeesToast(context, data['message']);
          return false;
        }
      } else {
        print(response.data);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
