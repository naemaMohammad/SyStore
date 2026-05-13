// home_screen.dart
import 'package:flutter/material.dart';
import 'package:owner_app/core/theme/theme.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child:  Text(
            "احذفو هاد الملف عملته مشان ما كود شي بالمين",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.body(),
            ),
          ),
        ),
      ),
    );
  }
}