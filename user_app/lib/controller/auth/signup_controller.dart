import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/data/services/notification_service.dart';
import 'package:user_app/data/utils/api_utils.dart';

class SignUpController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var gender = ''.obs;

  final box = GetStorage();

  ApiClient get api => Get.find<ApiClient>();

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      String fullName = fullNameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text;

      // Get FCM Token from storage
      String fcmToken = box.read('fcm_token') ?? '';

      if (fcmToken.isEmpty || fcmToken.startsWith('temp_token_')) {
        final token = await NotificationService.getFcmTokenFromFirebase();
        if (token != null && token.isNotEmpty) {
          fcmToken = token;
          box.write('fcm_token', fcmToken);
        } else {
          fcmToken = 'temp_token_${DateTime.now().millisecondsSinceEpoch}';
          box.write('fcm_token', fcmToken);
        }
      }

      final response = await api.register(
        fullName,
        phone,
        email,
        password,
        fcmToken,
      );

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('successfully') ||
              message.toLowerCase().contains('success'));

      if (isSuccess) {
        box.write('register_email', email);

        Get.snackbar(
          'success'.tr,
          'Account created successfully! Please verify your email.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(
          AppRoutes.verification,
          arguments: {
            'title': 'hello_title',
            'subtitle': 'activation_code',
            'isRecovery': false,
            'email': email,
          },
        );
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Registration failed'.tr,
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
    Get.offNamed(AppRoutes.login);
  }

  void cancelRegistration() {
    Get.back();
  }
}
