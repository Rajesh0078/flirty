import 'package:dio/dio.dart';
import 'package:flirty/features/login/screens/otp_verification_screen.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class LoginService {
  Dio dio = Dio();

  Future<bool> loginSendOtp(String phone, BuildContext context) async {
    try {
      final response = await dio.post(
        ApiRoutes.loginSendOtp,
        data: {"phone": phone},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          ShowToaster().succeesToast(context, data['message']);
          Navigator.pushReplacement(
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

  Future<bool> loginVerifyOtp(String phone, String otp) async {
    try {
      final response = await dio.post(
        ApiRoutes.login,
        data: {
          'phone': phone,
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          print(data);
          return true;
        } else {
          print(data);
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
