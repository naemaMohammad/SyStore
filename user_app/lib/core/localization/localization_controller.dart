import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  void setLanguage(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale); 
  }
}