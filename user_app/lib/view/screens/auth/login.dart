import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/auth/login_controller.dart';
import 'package:user_app/view/widgets/buttons/button.dart';
import 'package:user_app/view/widgets/textFields/password_field.dart';
import 'package:user_app/view/widgets/textFields/text_field.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    print("Login View -> ${controller.hashCode}");
    print("Email Controller -> ${controller.emailController.hashCode}");
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.40),
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
                      child: Form(
                        key: controller
                            .formKey, 
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "login".tr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway',
                                    fontFamilyFallback: ['Cairo'],
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 11,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "welcome".tr,
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
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.favorite,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                                ],
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
                                hint: 'pass'.tr,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password'.tr;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      text: 'done'.tr,
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.login();
                                        }
                                      },
                                    ),

                              const SizedBox(height: 10),

                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    controller.goToForgotPassword();
                                  },
                                  child: Text(
                                    "forgot_password".tr,
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
