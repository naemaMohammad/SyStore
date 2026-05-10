import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  // دالة لتغيير اللغة
  void setLanguage(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale); // يغير لغة الواجهة فوراً
  }
}