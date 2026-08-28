// lib/app/controllers/auth/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/controller/auth/create_store_controller.dart';
import 'package:owner_app/controller/auth/signup_controller.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/model/merchant_login_request.dart';
import 'package:owner_app/data/services/api_service.dart';


class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  final box = GetStorage();

  @override
  void onClose() {
   // emailController.dispose();
  //  passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final request = MerchantLoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      print('═══════════════════════════════════════════');
      print('📤 Sending Merchant Login Data:');
      print('   • email: ${request.email}');
      print('═══════════════════════════════════════════');

      final response = await ApiService.merchantApi.login(request);

      print('📥 Response:');
      print('   • success: ${response.success}');
      print('   • message: ${response.message}');
      print('   • token: ${response.token}');
      print('═══════════════════════════════════════════');

      String? message = response.message;
      bool isSuccess = response.success ||
          (message != null &&
              (message.toLowerCase().contains('success') ||
                  message.toLowerCase().contains('welcome') ||
                  message.toLowerCase().contains('logged in')));

      if (isSuccess) {
        if (response.token != null) {
          box.write('token', response.token);
        }

        if (response.userData != null) {
          box.write('user_data', response.userData!.toJson());
        } else if (response.merchant != null) {
          box.write('user_data', response.merchant);
        }

        Get.snackbar(
          'success'.tr,
          'Login successful!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.mainScaffold);
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
      print('❌ Login Error: $e');
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

  void goToForgotPassword() {
    Get.toNamed(
      AppRoutes.forgotPassword,
      arguments: {
        'email': emailController.text.trim(),
      },
    );
  }

  void goToSignUp() {
    CreateStoreController.clearRegistrationTempData();
    if (Get.isRegistered<SignUpController>()) {
      Get.delete<SignUpController>(force: true);
    }
    if (Get.isRegistered<CreateStoreController>()) {
      Get.delete<CreateStoreController>(force: true);
    }
    Get.offNamed(AppRoutes.signUp);
  }
}
