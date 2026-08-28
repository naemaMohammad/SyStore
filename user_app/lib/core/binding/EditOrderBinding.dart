import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:user_app/controller/order/EditOrderController.dart';

class Orderbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditOrderController());
  }
}