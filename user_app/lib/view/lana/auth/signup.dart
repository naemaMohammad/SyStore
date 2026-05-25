import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/lana/auth/verification.dart';
import 'package:user_app/view/lana/widgets/buttons/button.dart';
import 'package:user_app/view/lana/widgets/textFields/password_field.dart';
import 'package:user_app/view/lana/widgets/textFields/phone_field.dart';
import 'package:user_app/view/lana/widgets/textFields/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isPasswordHidden = true;
  String gender = " ";

  @override
  Widget build(BuildContext context) {
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
                      borderRadius: BorderRadius.only(
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
                          CustomTextField(
                            hint: "username".tr,
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          PhoneTextField(
                            controller: phoneController,
                            hintText: "number".tr,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hint: 'e-mail'.tr,
                            controller: emailController,
                            isEmail: true,
                          ),
                          SizedBox(height: 20),
                          CustomPasswordField(
                            controller: passwordController,
                            hint: "password".tr,
                          ),
                          SizedBox(height: 30),
                          CustomButton(
                            text: 'done'.tr,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CodeScreen(
                                    title: 'hello_title',
                                    subtitle: 'activation_code',
                                    isRecovery: false,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
