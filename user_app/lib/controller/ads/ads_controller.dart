import 'package:get/get.dart';
import 'package:user_app/data/model/slider_model.dart';
import 'package:user_app/data/services/api_client.dart';

class AdsController extends GetxController {
  final ApiClient apiService = Get.find<ApiClient>();

  final RxList<SliderModel> sliders = <SliderModel>[].obs;

  final RxInt currentIndex = 0.obs;

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSliders();
  }

  Future<void> fetchSliders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.getSliders();

      sliders.assignAll(response.sliders);

      if (currentIndex.value >= sliders.length) {
        currentIndex.value = 0;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      sliders.clear();

      print('❌ Error fetching sliders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> refreshSliders() async {
    await fetchSliders();
  }
}