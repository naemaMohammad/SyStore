import 'package:get/get.dart';
import 'package:owner_app/data/data_source/api_call.dart';
import 'package:owner_app/data/model/all_stores_reviews_model.dart';
import 'package:owner_app/data/services/api_service.dart';

class Reviewscontroller extends GetxController {
  // نفس نسخة الـ ApiCall المشتركة (المسجّلة في ApiService.init) بدل whathappens().
  final ApiCall api = ApiService.apiCall;

  var reviews = <Reviews>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      isLoading.value = true;

      final response = await api.allStoreReviews();

      reviews.value = response.reviews ?? [];
    } catch (e) {
      print("ERROR REVIEWS: $e");
    } finally {
      isLoading.value = false;
    }
  }
}