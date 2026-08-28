// lib/app/bindings/settings_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/settings/settings_controller.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}