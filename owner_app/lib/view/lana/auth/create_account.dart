import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/view/lana/auth/create_store.dart';

import 'package:owner_app/view/lana/widgets/buttons/button.dart';
import 'package:owner_app/view/lana/widgets/image_picker/show_image_paker.dart';
import 'package:owner_app/view/lana/widgets/textFields/password_field.dart';
import 'package:owner_app/view/lana/widgets/textFields/phone_field.dart';
import 'package:owner_app/view/lana/widgets/textFields/text_field.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  bool isPasswordHidden = true;
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          // MATERIAL CONTAINER
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      // TITLE
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
                      // NAME FIELD
                      CustomTextField(
                        controller: nameController,
                        hint: "username".tr,
                      ),
                      const SizedBox(height: 30),
                      PhoneTextField(
                        controller: phoneController,
                        hintText: "personal_phone".tr,
                      ),
                      SizedBox(height: 30),
                      // EMAIL FIELD
                      CustomTextField(
                        controller: emailController,
                        hint: "email".tr,
                        isEmail: true,
                      ),
                      SizedBox(height: 30),
                      CustomPasswordField(controller: passwordController,hint: 'password',),
                      SizedBox(height: 30),
                      // SOCIAL LINK
                      CustomTextField(
                        controller: linkController,
                        hint: "link".tr,
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          ShowImagePicker.show(
                            context: context,
                            onPick: (source) {
                              pickImage(source);
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        fontFamilyFallback: const ['Tajawal'],
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // BUTTON
                      CustomButton(
                        text: "continue".tr,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateStore(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 5),
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
