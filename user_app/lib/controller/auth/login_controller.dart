import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/data/services/token_service.dart';
import 'package:user_app/data/utils/api_utils.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  final box = GetStorage();

  ApiClient get api => Get.find<ApiClient>();
  TokenService get tokens => Get.find<TokenService>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await api.login({
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('welcome') ||
              message.toLowerCase().contains('logged in'));

      if (isSuccess) {
        if (response.token != null) {
          await tokens.saveToken(response.token!);
        }

        if (response.userData != null) {
          box.write('user_data', response.userData!.toJson());
        }

        Get.snackbar(
          'success'.tr,
          'Login successful!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Login failed. Please try again.'.tr,
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

  void goToForgotPassword() {
    Get.toNamed(
      AppRoutes.forgotPassword,
      arguments: {'email': emailController.text.trim()},
    );
  }

  void goToSignUp() {
    Get.offNamed(AppRoutes.signUp);
  }
}
