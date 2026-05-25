import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/view/lana/auth/verification.dart';
import 'package:owner_app/view/lana/widgets/buttons/button.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});
  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  bool isEmailSelected = false;
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
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    // TITLE
                    Text(
                      "recovery_title".tr,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: const ['Cairo'],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // DESCRIPTION
                    Text(
                      "recovery_desc".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: const ['Tajawal'],
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 60),
                    // TOGGLE
                    Center(
                      child: Container(
                        width: 220,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),

                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isEmailSelected = !isEmailSelected;
                            });
                          },

                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),

                                width: 24,
                                height: 24,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).primaryColor,
                                  ),

                                  color: isEmailSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),

                                child: isEmailSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),

                              const SizedBox(width: 30),

                              Text(
                                "email_method".tr,

                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'NunitoSans',
                                  fontFamilyFallback: const ['Tajawal'],

                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // BUTTON
                    CustomButton(
                      text: "next".tr,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CodeScreen(
                              title: 'welcome_back'.tr,
                              subtitle: 'verification_code'.tr,
                              isSignUp: true,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: const ['Tajawal'],
                          color: Theme.of(context).textTheme.bodySmall?.color,
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
    );
  }
}
