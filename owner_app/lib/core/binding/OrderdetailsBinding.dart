import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:owner_app/controller/orders/orderDetailsController.dart';

class Orderdetailsbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Orderdetailscontroller());
  }
}