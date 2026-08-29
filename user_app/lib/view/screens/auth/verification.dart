import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/auth/verification_controller.dart';
import 'package:user_app/view/widgets/buttons/button.dart';

class CodeScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isRecovery;
  const CodeScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isRecovery,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerificationController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/STORIA4.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            Get.find<VerificationController>().title.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway',
                              fontFamilyFallback: ['Cairo'],
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            Get.find<VerificationController>().subtitle.tr,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                (index) => _buildCodeBox(context, index),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Get.find<VerificationController>().isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: 'next'.tr,
                                  onPressed: () {
                                    Get.find<VerificationController>()
                                        .verifyOtp();
                                  },
                                ),
                          const SizedBox(height: 5),
                          Get.find<VerificationController>().isResending.value
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
                              : TextButton(
                                  onPressed: () {
                                    Get.find<VerificationController>()
                                        .resendOtp();
                                  },
                                  child: Text(
                                    controller.isCooldown.value
                                        ? '${'send_again'.tr} (${controller.secondsLeft.value}s)'
                                        : 'send_again'.tr,

                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'NunitoSans',
                                      fontFamilyFallback: ['Tajawal'],
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBox(BuildContext context, int index) {
    final controller = Get.find<VerificationController>();
    return Container(
      width: 40,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
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
          fontSize: 22,
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
