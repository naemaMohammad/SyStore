import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/auth/signup_controller.dart';
import 'package:user_app/view/widgets/buttons/button.dart';
import 'package:user_app/view/widgets/textFields/password_field.dart';
import 'package:user_app/view/widgets/textFields/phone_field.dart';
import 'package:user_app/view/widgets/textFields/text_field.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              "create_account".tr,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                fontFamilyFallback: ['Cairo'],
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Form(
                            key: controller.formKey,
                            child: Obx(
                              () => Column(
                                children: [
                                  CustomTextField(
                                    hint: "username".tr,
                                    controller: controller.fullNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  PhoneTextField(
                                    controller: controller.phoneController,
                                    hintText: "number".tr,
                                  ),
                                  const SizedBox(height: 20),

                                  CustomTextField(
                                    hint: 'e-mail'.tr,
                                    controller: controller.emailController,
                                    isEmail: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email'.tr;
                                      }
                                      if (!GetUtils.isEmail(value)) {
                                        return 'Please enter a valid email'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  CustomPasswordField(
                                    controller: controller.passwordController,
                                    hint: "pass".tr,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password'.tr;
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 characters'
                                            .tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 30),

                                  controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomButton(
                                          text: 'done'.tr,
                                          onPressed: () {
                                            if (controller.formKey.currentState!
                                                .validate()) {
                                              controller.register();
                                            }
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                controller.cancelRegistration();
                              },
                              child: Text(
                                'cancel'.tr,
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
                          ),
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
