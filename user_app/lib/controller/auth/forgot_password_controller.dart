import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/utils/api_utils.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final box = GetStorage();
  String? resetEmail;
  String? resetOtp;

  ApiClient get api => Get.find<ApiClient>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null &&
        args['email'] != null &&
        args['email'].toString().trim().isNotEmpty) {
      emailController.text = args['email'];
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.toggle();
  }

  Future<void> sendForgotPasswordEmail() async {
    try {
      isLoading.value = true;

      final response = await api.forgotPassword({
        'email': emailController.text.trim(),
      });

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('sent') ||
              message.toLowerCase().contains('email'));

      if (isSuccess) {
        resetEmail = emailController.text.trim();
        box.write('reset_email', resetEmail);

        Get.snackbar(
          'success'.tr,
          'OTP sent to your email!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(
          AppRoutes.verification,
          arguments: {
            'email': resetEmail,
            'isRecovery': true,
            'title': 'welcome_back',
            'subtitle': 'verification_code',
          },
        );
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Failed to send OTP. Please try again.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        apiErrorMessage(e, 'An error occurred. Please try again.'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    resetEmail = box.read('reset_email') ?? '';
    resetOtp = box.read('reset_otp') ?? '';

    if (resetEmail!.isEmpty || resetOtp!.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Missing required data. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await api.resetPassword({
        'email': resetEmail!,
        'password': passwordController.text,
        'otp': resetOtp!,
        'password_confirmation': confirmPasswordController.text,
      });

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('reset') ||
              message.toLowerCase().contains('changed'));

      if (isSuccess) {
        box.remove('reset_email');
        box.remove('reset_otp');

        Get.snackbar(
          'success'.tr,
          'Password reset successfully! Please login.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Failed to reset password. Please try again.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        apiErrorMessage(e, 'An error occurred. Please try again.'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }
}
