import 'package:get/get.dart';
import 'package:user_app/core/routes/app_routes.dart';

class StartController extends GetxController {
  void goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void goToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
