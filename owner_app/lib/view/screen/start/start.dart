// lib/view/lana/start/start.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/start/start_controller.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      if (!Get.isRegistered<StartController>()) {
        Get.put(StartController(), permanent: true);
      }
      final controller = Get.find<StartController>();

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100);
                  },
                ),
                Text(
                  'STORIA',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'start_desc'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 60),
                MaterialButton(
                  onPressed: () {
                    controller.goToSignUp();
                  },
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 20,
                  ),
                  child: Text(
                    'start_button'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                      color: Color(0xFFF3F3F3),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'have_account'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.goToLogin();
                      },
                      icon: Icon(
                        Get.locale?.languageCode == 'en'
                            ? Icons.arrow_circle_right
                            : Icons.arrow_circle_left,
                        color: Theme.of(context).primaryColor,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print('❌ Start Widget Error: $e');
      return const Scaffold(
        body: Center(
          child: Text('Error loading start screen'),
        ),
      );
    }
  }
}