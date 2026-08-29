import 'package:get/get.dart';
import 'package:owner_app/controller/dashboard/dashController.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}