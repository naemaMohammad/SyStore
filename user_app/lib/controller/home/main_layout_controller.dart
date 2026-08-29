import 'package:get/get.dart';
import 'package:user_app/controller/store/store_controller.dart';


class MainLayoutController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<StoreController>().getStores();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
