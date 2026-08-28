// lib/view/lana/auth/forget_password.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/forgot_password_controller.dart';
import 'package:owner_app/view/widgets/buttons/button.dart';
import 'package:owner_app/view/widgets/textFields/password_field.dart';


class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ForgotPasswordController>()) {
      Get.put(ForgotPasswordController());
    }
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 140),
                      Text(
                        'password_title'.tr,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway',
                          fontFamilyFallback: const ['Cairo'],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'password_desc'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: const ['Tajawal'],
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomPasswordField(
                        controller: controller.passwordController,
                        hint: "new_password".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password'.tr;
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      CustomPasswordField(
                        controller: controller.confirmPasswordController,
                        hint: "confirm_password".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password'.tr;
                          }
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match'.tr;
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      Obx(
                        () => controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: "save".tr,
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.resetPassword();
                                  }
                                },
                              ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
