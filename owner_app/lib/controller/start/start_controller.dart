// lib/app/controllers/start_controller.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/create_store_controller.dart';
import 'package:owner_app/controller/auth/signup_controller.dart';
import 'package:owner_app/core/routes/app_routes.dart';


class StartController extends GetxController {
  void goToSignUp() {
    CreateStoreController.clearRegistrationTempData();
    if (Get.isRegistered<SignUpController>()) {
      Get.delete<SignUpController>(force: true);
    }
    if (Get.isRegistered<CreateStoreController>()) {
      Get.delete<CreateStoreController>(force: true);
    }
    Get.toNamed(AppRoutes.signUp);
  }

  void goToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
