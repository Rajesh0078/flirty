import 'package:dio/dio.dart';
import 'package:flirty/features/registration/screens/register_otp_verification_screen.dart';
import 'package:flirty/features/registration/screens/username_screen.dart';
import 'package:flirty/provider/auth_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class RegistrationService {
  Dio dio = Dio();

  Future<bool> registerSendOtp(
      String phone, String hash, BuildContext context) async {
    try {
      final response = await dio.post(
        ApiRoutes.registerSendOtp,
        data: {"phone": phone, "hash": hash},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        if (data['success']) {
          ShowToaster().succeesToast(context, data['message']);
          Navigator.push(
            context,
            PageAnimationTransition(
              page: RegisterOtpVerificationScreen(
                phone: phone,
              ),
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

  Future<bool> registerVerifyOtp(
      String phone, String otp, BuildContext context, WidgetRef ref) async {
    try {
      final response = await dio.post(
        ApiRoutes.registerVerifyOtp,
        data: {"phone": phone, "otpCode": otp},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          ShowToaster().succeesToast(context, data['message']);
          ref
              .read(authProvider.notifier)
              .startRegistration(data['user']['phone']);
          Navigator.pushAndRemoveUntil(
            context,
            PageAnimationTransition(
              page: const UsernameScreen(),
              pageAnimationType: FadeAnimationTransition(),
            ),
            (route) => false,
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

  Future<bool> updateProfile(String typeName, dynamic value, int currentStep,
      BuildContext context, WidgetRef ref) async {
    final auth = ref.read(authProvider);

    try {
      final response = await dio.post(
        ApiRoutes.updateProfile,
        data: {typeName: value, "phone": '${auth['userId']}'},
      );
      if (response.statusCode == 200 && response.data['success']) {
        ref.read(authProvider.notifier).advanceRegistrationStep(currentStep);
        return true;
      } else {
        print(response.data);
        ShowToaster().succeesToast(context, response.data['message']);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> uploadImges(BuildContext context, WidgetRef ref,
      XFile? profilePicture, List<XFile?> photos) async {
    final auth = ref.read(authProvider);

    try {
      FormData formData = FormData();

      // Add profile picture if it's not null
      if (profilePicture != null) {
        formData.files.add(
          MapEntry('profile_picture',
              await MultipartFile.fromFile(profilePicture.path)),
        );
      }

      // Add photos to the FormData
      for (var photo in photos) {
        if (photo != null) {
          formData.files.add(
            MapEntry('photos', await MultipartFile.fromFile(photo.path)),
          );
        }
      }

      // Add the phone number from the auth provider
      formData.fields.add(MapEntry('phone', '${auth['userId']}'));
      final response = await dio.post(
        ApiRoutes.uploadImges,
        data: formData,
      );
      if (response.statusCode == 200 && response.data['success']) {
        final data = response.data;
        final user = data['user'];
        print(user);
        final token = data['token'];
        ref.read(authProvider.notifier).completeRegistration();
        ref.read(authProvider.notifier).login(token, user['phone']);
        ref.read(userProvider.notifier).updateUser(user);
        return true;
      } else {
        print(response.data);
        ShowToaster().succeesToast(context, response.data['message']);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
