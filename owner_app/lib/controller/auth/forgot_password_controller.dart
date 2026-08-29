// lib/app/controllers/auth/forgot_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/model/forgot_password_request.dart';
import 'package:owner_app/data/services/api_service.dart';

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
    //  passwordController.dispose();
    //confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.toggle();
  }

  Future<void> sendForgotPasswordEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final request = ForgotPasswordRequest(email: emailController.text.trim());

      final response = await ApiService.merchantApi.forgotPassword(request);

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('sent'));

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
            'isSignUp': false,
            'title': 'welcome_back',
            'subtitle': 'verification_code',
          },
        );
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Failed to send OTP.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Forgot Password Error: $e');
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    resetEmail = box.read('reset_email') ?? '';
    resetOtp = box.read('reset_otp') ?? '';

    // ✅ طباعة البيانات
    print('🔍 resetEmail: $resetEmail');
    print('🔍 resetOtp: $resetOtp');

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

      final request = ResetPasswordRequest(
        email: resetEmail!,
        password: passwordController.text,
        otp: resetOtp!,
        passwordConfirmation: confirmPasswordController.text,
      );

      print('📤 Sending Reset Password Request:');
      print('   • email: ${request.email}');
      print('   • otp: ${request.otp}');
      print('   • password: ${request.password}');
      print('   • password_confirmation: ${request.passwordConfirmation}');

      final response = await ApiService.merchantApi.resetPassword(request);

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('reset'));

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
          response.message ?? 'Failed to reset password.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Reset Password Error: $e');
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
