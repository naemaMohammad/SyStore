// lib/app/bindings/auth/verification_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/verification_controller.dart';


class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() => VerificationController());
  }
}