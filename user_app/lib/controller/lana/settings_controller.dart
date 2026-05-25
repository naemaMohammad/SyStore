import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final nameController =
      TextEditingController(text: "Lana abo Al-Qasab");

  final phoneController = TextEditingController();

  RxBool isEditing = false.obs;
  RxBool isDark = Get.isDarkMode.obs;

  final box = GetStorage();

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void changeLanguage(String langCode) {
    box.write('lang', langCode);

    Get.updateLocale(Locale(langCode));

    Get.forceAppUpdate();
  }

  void changeTheme(bool dark) {
    isDark.value = dark;

    Get.changeThemeMode(
      dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}