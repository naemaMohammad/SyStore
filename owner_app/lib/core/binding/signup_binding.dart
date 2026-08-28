// lib/app/bindings/auth/signup_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}