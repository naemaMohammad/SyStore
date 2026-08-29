// lib/app/controllers/auth/verification_controller.dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/model/otp_request.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/view/screen/auth/pending_dialog.dart';
import 'package:owner_app/view/screen/start/start.dart';

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
  var resendAttempts = 0.obs;
  var isWaiting = false.obs;
  var waitSeconds = 60.obs;

  final box = GetStorage();

  late String email;
  late bool isSignUp;
  late String title;
  late String subtitle;

  // lib/app/controllers/auth/verification_controller.dart

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    print('🔍 Full args: $args');

    print('🔍 args: $args');
    print('🔍 isSignUp from args: ${args?['isSignUp']}');

    if (args != null) {
      email = args['email'] ?? '';
      // ✅ تأكد من قراءة isSignUp بشكل صحيح
      isSignUp = args['isSignUp'] ?? false;
      title = args['title'] ?? 'hello_title';
      subtitle = args['subtitle'] ?? 'activation_code';
    } else {
      email = box.read('register_email') ?? '';
      isSignUp = true; // ✅ هذا للتسجيل فقط
      title = 'hello_title';
      subtitle = 'activation_code';
    }

    print('🔍 isSignUp: $isSignUp');
    print('🔍 email: $email');
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otp.value = '';
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
    if (getFullOtp().length < 6) {
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

      final request = OtpRequest(email: email, otp: getFullOtp());

      print('═══════════════════════════════════════════');
      print('📤 Sending OTP Verification Data:');
      print('   • email: ${request.email}');
      print('   • otp: ${request.otp}');
      print('   • isSignUp: $isSignUp');
      print('═══════════════════════════════════════════');

      final response = isSignUp
          ? await ApiService.merchantApi.verifyOtp(request) // ✅ للتسجيل
          : await ApiService.merchantApi.verifyResetOtp(request);
      print('📥 Response:');
      print('   • success: ${response.success}');
      print('   • message: ${response.message}');
      print('═══════════════════════════════════════════');

      String? message = response.message;
      bool isSuccess =
          response.success ||
          (message != null &&
              (message.toLowerCase().contains('success') ||
                  message.toLowerCase().contains('verified') ||
                  message.toLowerCase().contains('valid')));

      print('🔍 isSuccess: $isSuccess');

      if (isSuccess) {
        if (response.token != null) {
          box.write('token', response.token);
        }
        if (response.userData != null) {
          box.write('user_data', response.userData!.toJson());
        } else if (response.merchant != null) {
          box.write('user_data', response.merchant);
        }
        if (isSignUp) {
          box.remove('reset_email');
          box.remove('reset_otp');
        } else {
          box.write('reset_email', email);
          box.write('reset_otp', getFullOtp());
          box.remove('register_email');
        }
        Get.snackbar(
          'success'.tr,
          'Verification successful!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        _clearOtpFields();

        if (isSignUp) {
          Get.dialog(const PendingDialog(), barrierDismissible: false);
          Future.delayed(const Duration(seconds: 5), () {
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.offAll(() => const Start(), transition: Transition.fade);
          });
        } else {
          Get.offAllNamed(AppRoutes.resetPassword);
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
    } on DioException catch (e) {
      print("========== VERIFY OTP ==========");
      print("Status: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");
      print("Request: ${e.requestOptions.data}");
      print("================================");

      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print('❌ Verification Error: $e');

      Get.snackbar(
        'error'.tr,
        'An error occurred. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // lib/app/controllers/auth/verification_controller.dart

  Future<void> resendOtp() async {
    // ✅ إذا كان في انتظار، لا تفعل شي
    if (isWaiting.value) {
      Get.snackbar(
        'info'.tr,
        'Please wait ${waitSeconds.value} seconds before trying again'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // ✅ إذا وصلنا للحد الأقصى (3 محاولات) وما في انتظار، ابدأ الانتظار
    if (resendAttempts.value >= 3) {
      showMaxAttemptsDialog();
      _startWaiting();
      return;
    }

    try {
      isResending.value = true;

      resendAttempts.value++;
      print('🔁 Resend Attempts: ${resendAttempts.value}');

      final request = ResendOtpRequest(email: email);
      final response = await ApiService.merchantApi.resendOtp(request);

      final message = response.message?.toLowerCase() ?? '';
      final isSuccess = response.success ||
          message.contains('success') ||
          message.contains('sent') ||
          message.contains('resent');

      if (isSuccess) {
        Get.snackbar(
          'success'.tr,
          'OTP sent successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        attempts.value = 0;
        _clearOtpFields();
        focusNodes[0].requestFocus();
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
      print('❌ Resend OTP Error: $e');
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isResending.value = false;
    }
  }

  // ✅ دالة بدء الانتظار
  void _startWaiting() {
    isWaiting.value = true;
    waitSeconds.value = 60;

    // ✅ عد تنازلي لمدة 60 ثانية
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (waitSeconds.value > 0) {
        waitSeconds.value--;
      } else {
        timer.cancel();
        isWaiting.value = false;
        resendAttempts.value = 0; // ✅ إعادة تعيين المحاولات
        Get.snackbar(
          'info'.tr,
          'You can now resend OTP again'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    });
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
