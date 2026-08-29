import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/data/services/token_service.dart';
import 'package:user_app/data/utils/api_utils.dart';
import 'dart:async';

import 'package:user_app/view/screens/start/hello.dart';

class VerificationController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  var isLoading = false.obs;
  var isResending = false.obs;
  var attempts = 0.obs;
  var maxAttempts = 3.obs;
  var otp = ''.obs;

  final resendCount = 0.obs;
  final isCooldown = false.obs;
  final secondsLeft = 60.obs;
  Timer? cooldownTimer;

  final box = GetStorage();
  final String title;
  final String subtitle;
  final bool isRecovery;

  VerificationController({
    required this.title,
    required this.subtitle,
    required this.isRecovery,
  });

  late String email;

  ApiClient get api => Get.find<ApiClient>();
  TokenService get tokens => Get.find<TokenService>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      email = Get.arguments['email'] ?? '';
    }

    Future.delayed(Duration.zero, () {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      cooldownTimer?.cancel();
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startCooldown() {
    isCooldown.value = true;
    secondsLeft.value = 60;
    cooldownTimer?.cancel();
    cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        timer.cancel();
        isCooldown.value = false;
        resendCount.value = 0;
        secondsLeft.value = 60;
      } else {
        secondsLeft.value--;
      }
    });
  }

  String getFullOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  void onOtpChanged(String value, int index) {
    otp.value = getFullOtp();
    if (value.isNotEmpty) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  bool validateOtp() {
    String code = getFullOtp();
    if (code.length < 6) {
      Get.snackbar(
        'error'.tr,
        'full_code'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<void> verifyOtp() async {
    if (!validateOtp()) return;

    try {
      isLoading.value = true;

      final response = isRecovery
          ? await api.verifyResetOtp({'email': email, 'otp': getFullOtp()})
          : await api.verifyOtp({'email': email, 'otp': getFullOtp()});

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('valid') ||
              message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('verified'));

      if (isSuccess) {
        if (response.token != null) {
          await tokens.saveToken(response.token!);
        }

        if (response.userData != null) {
          box.write('user_data', response.userData!.toJson());
        }

        if (isRecovery) {
          box.write('reset_email', email);
          box.write('reset_otp', getFullOtp());
        } else {
          box.remove('register_email');
        }

        Get.snackbar(
          'success'.tr,
          'Verification successful!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        if (isRecovery) {
          Get.offNamed(AppRoutes.resetPassword);
        } else {
          Get.offAll(() => const ImageSlider(), transition: Transition.fade);
        }
      } else {
        attempts.value++;
        if (attempts.value >= maxAttempts.value) {
          showMaxAttemptsDialog();
        } else {
          Get.snackbar(
            'error'.tr,
            response.message ?? 'Invalid OTP. Please try again.'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
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

  Future<void> resendOtp() async {
    if (isCooldown.value) {
      showMaxAttemptsDialog();
      return;
    }
    if (resendCount.value >= 3) {
      showMaxAttemptsDialog();
      startCooldown();
      return;
    }
    try {
      isResending.value = true;
      final response = await api.resendOtp({'email': email});

      String? message = response.message;
      bool isSuccess =
          message != null &&
          (message.toLowerCase().contains('success') ||
              message.toLowerCase().contains('sent'));

      if (isSuccess) {
        resendCount.value++;
        Get.snackbar(
          'success'.tr,
          'OTP sent successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        attempts.value = 0;
        for (var controller in otpControllers) {
          controller.clear();
        }
        focusNodes[0].requestFocus();
        otp.value = '';
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Failed to resend OTP.'.tr,
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
      isResending.value = false;
    }
  }

  void showMaxAttemptsDialog() {
    Get.dialog(
      barrierDismissible: true,
      barrierColor: Theme.of(
        Get.context!,
      ).textTheme.bodyMedium?.color?.withOpacity(0.2),
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              decoration: BoxDecoration(
                color: Get.context!.theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'max_attempts'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Get.context!.theme.textTheme.bodyMedium?.color,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Get.context!.theme.textTheme.bodyMedium?.color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'okay'.tr,
                          style: TextStyle(
                            color: Get.context!.theme.scaffoldBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NunitoSans',
                            fontFamilyFallback: ['Tajawal'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Get.context!.theme.cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(Get.context!).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
