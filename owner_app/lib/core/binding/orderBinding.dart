import 'package:get/get.dart';
import 'package:owner_app/controller/orders/orderController.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}