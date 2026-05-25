import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/view/lana/settings/settings.dart';
import 'package:owner_app/view/lana/widgets/buttons/button.dart';
import 'package:owner_app/view/lana/widgets/textFields/password_field.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    // TITLE
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
                    // DESCRIPTION
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
                    // PASSWORD
                    CustomPasswordField(
                      controller: passwordController,
                      hint: "new_password".tr,
                    ),
                    const SizedBox(height: 25),
                    // CONFIRM PASSWORD
                    CustomPasswordField(
                      controller: confirmPasswordController,
                      hint: "confirm_password".tr,
                    ),
                    const Spacer(),
                    // BUTTON
                    CustomButton(
                      text: "save".tr,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
