import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/auth/forgot_password_controller.dart';
import 'package:user_app/view/widgets/buttons/button.dart';
import 'package:user_app/view/widgets/textFields/text_field.dart';


class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});
  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}
class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
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
                          const SizedBox(height: 20),
                          Text(
                            "recovery_title".tr,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway',
                              fontFamilyFallback: const ['Cairo'],
                            ),
                          ),
                          Text(
                            "recovery_desc".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.7,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: const ['Tajawal'],
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            hint: 'e-mail'.tr,
                           controller: controller.emailController,
                            isEmail: true,
                          ),
                          const SizedBox(height: 30),
                          const Spacer(),
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: "next".tr,
                                  onPressed: () {
                                    controller.sendForgotPasswordEmail();
                                  },
                                ),
                          const SizedBox(height: 18),
                          GestureDetector(
                            onTap: () {
                             controller.goToLogin();
                            },
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'NunitoSans',
                                fontFamilyFallback: const ['Tajawal'],
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
}
