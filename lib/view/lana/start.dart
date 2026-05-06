import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/lana/login.dart';
import 'package:user_app/view/lana/signup.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/images/STORIA4.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 130),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 250,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'STORIA',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 60),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                    child: Text(
                      'start_button'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                        color: Color(0xFFF3F3F3),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
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
          ],
        ),
      ),
    );
  }
}
