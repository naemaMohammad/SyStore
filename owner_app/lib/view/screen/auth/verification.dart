// lib/view/lana/auth/verification.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/verification_controller.dart';
import 'package:owner_app/view/widgets/buttons/button.dart';


class CodeScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSignUp;

  const CodeScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSignUp,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<VerificationController>()) {
      Get.put(VerificationController());
    }
    final controller = Get.find<VerificationController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      const SizedBox(height: 120),
                      Text(
                        title.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway',
                          fontFamilyFallback: ['Cairo'],
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        subtitle.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (index) =>
                                _buildCodeBox(context, index, controller),
                          ),
                        ),
                      ),
                      const Spacer(),
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              text: "next".tr,
                              onPressed: () {
                                controller.verifyOtp();
                              },
                            ),
                      const SizedBox(height: 5),
                      // lib/view/lana/auth/verification.dart

                      // ✅ زر إعادة الإرسال
                      controller.isResending.value
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Obx(
                              () => TextButton(
                                onPressed: controller.isWaiting.value
                                    ? null // ❌ تعطيل الزر أثناء الانتظار
                                    : () {
                                        controller.resendOtp();
                                      },
                                child: Text(
                                  controller.isWaiting.value
                                      ? '${'send_again'.tr} (${controller.waitSeconds.value}s)'
                                      : 'send_again'.tr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'NunitoSans',
                                    fontFamilyFallback: ['Tajawal'],
                                    color: controller.isWaiting.value
                                        ? Colors.grey
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.color,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox(
    BuildContext context,
    int index,
    VerificationController controller,
  ) {
    return Container(
      width: 42,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'NunitoSans',
          fontFamilyFallback: ['Tajawal'],
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) => controller.onOtpChanged(value, index),
      ),
    );
  }
}
