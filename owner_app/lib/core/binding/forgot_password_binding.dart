// lib/app/bindings/auth/forgot_password_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/forgot_password_controller.dart';


class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}