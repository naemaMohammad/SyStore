// lib/view/lana/auth/create_account.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/controller/auth/signup_controller.dart';
import 'package:owner_app/view/widgets/buttons/button.dart';
import 'package:owner_app/view/widgets/image_picker/show_image_paker.dart';
import 'package:owner_app/view/widgets/textFields/password_field.dart';
import 'package:owner_app/view/widgets/textFields/phone_field.dart';
import 'package:owner_app/view/widgets/textFields/text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SignUpController>()) {
      Get.put(SignUpController(), permanent: true);
    }
    final controller = Get.find<SignUpController>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "create_account".tr,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                            fontFamilyFallback: const ['Cairo'],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: controller.fullNameController,
                          hint: "username".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        PhoneTextField(
                          controller: controller.phoneController,
                          hintText: "personal_phone".tr,
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: controller.emailController,
                          hint: "email".tr,
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
                        const SizedBox(height: 30),
                        CustomPasswordField(
                          controller: controller.passwordController,
                          hint: 'password',
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
                        CustomTextField(
                          controller: controller.socialMediaController,
                          hint: "link".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'social_media_required'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            ShowImagePicker.show(
                              context: context,
                              onPick: (source) async {
                                final picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                  source: source,
                                  imageQuality: 80,
                                );
                                if (image != null) {
                                  controller.setImage(File(image.path));
                                }
                              },
                            );
                          },
                          child: Obx(
                            () => Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: controller.idImageFile.value != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        controller.idImageFile.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 40,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.color,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "id".tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'NunitoSans',
                                            fontFamilyFallback: const [
                                              'Tajawal',
                                            ],
                                            color: Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.color,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: "continue".tr,
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.register();
                                    }
                                  },
                                ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
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
