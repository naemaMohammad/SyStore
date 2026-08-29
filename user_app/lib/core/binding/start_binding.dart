import 'package:get/get.dart';
import 'package:user_app/controller/start/start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(() => StartController());
  }
}