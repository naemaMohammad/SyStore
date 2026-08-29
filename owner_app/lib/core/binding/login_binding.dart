// lib/app/bindings/auth/login_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}