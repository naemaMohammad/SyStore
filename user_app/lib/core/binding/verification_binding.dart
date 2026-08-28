import 'package:get/get.dart';
import 'package:user_app/controller/auth/verification_controller.dart';


class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() {
      final args = Get.arguments;
      return VerificationController(
        title: args?['title'] ?? 'hello_title',
        subtitle: args?['subtitle'] ?? 'activation_code',
        isRecovery: args?['isRecovery'] ?? false,
      );
    });
  }
}
