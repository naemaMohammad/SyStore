import 'package:get/get.dart';
import 'package:user_app/data/model/can_rate_model.dart';
import 'package:user_app/data/model/show_order_model.dart';
import 'package:user_app/data/services/api_client.dart';

class Showmycartcontroller extends GetxController {
  late String orderStatus;
  late int orderId;

  Rxn<Order> order = Rxn<Order>();
  RxBool isLoading = true.obs;
  RxBool isRatingLoading = false.obs;

  RxSet<int> ratedProducts = <int>{}.obs;

  RxList<Data> canRateReviews = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    orderStatus = args["status"] ?? "";
    orderId = args["id"] ?? 0;

    if (orderId != 0) {
      fetchOrder();
      fetchCanRate();
    }
  }

  
  Future<void> fetchOrder() async {
    try {
      isLoading.value = true;

      final api = Get.find<ApiClient>();

      final response = await api.showOrder(orderId);

      final data = response is Map<String, dynamic>
          ? show_order_model.fromJson(response)
          : response;

      order.value = data?.order;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchCanRate() async {
    try {
      final api = Get.find<ApiClient>();

      final response = await api.canRate({});

      if (response.status == true) {
        canRateReviews.value = response.data ?? [];

        ratedProducts.clear();

        for (final item in canRateReviews) {
          if (item.isRated == 1 && item.productId != null) {
            ratedProducts.add(item.productId!);
          }
        }

        print("Can Rate Reviews => ${canRateReviews.length}");
        print("Rated Products => $ratedProducts");
      }
    } catch (e) {
      print("Can Rate Error: $e");
    }
  }

 
  int? getReviewId(int productId) {
    final review = canRateReviews.firstWhereOrNull(
      (item) => item.productId == productId,
    );

    return review?.id;
  }

 
  Future<bool> sendRating({
    required int productId,
    required double rating,
  }) async {
    try {
      isRatingLoading.value = true;

   
      if (ratedProducts.contains(productId)) {
        Get.snackbar(
          "Already Rated",
          "You have already rated this product and cannot rate it again.",
        );

        return false;
      }

 
      final reviewId = getReviewId(productId);

      if (reviewId == null) {
        Get.snackbar(
          "Sorry",
          "You have already rated this product and cannot rate it again.",
        );

        return false;
      }

      final api = Get.find<ApiClient>();

      print("Product ID => $productId");
      print("Review ID => $reviewId");
      print("Rating => $rating");

 
      final response = await api.rate({
        "review_id": reviewId,
        "rating": rating,
      });
      if (response.status == true) {
        ratedProducts.add(productId);

        final review = canRateReviews.firstWhereOrNull(
          (item) => item.productId == productId,
        );

        if (review != null) {
          review.isRated = 1;
          review.rating = rating.toString();

          canRateReviews.refresh();
        }

        Get.snackbar(
          "Success",
          response.message ?? "Rating submitted successfully",
        );

        return true;
      }

      Get.snackbar(
        "Error",
        response.message ?? "Failed to submit rating",
      );

      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );

      return false;
    } finally {
      isRatingLoading.value = false;
    }
  }


  String normalizeStatus(String? status) {
    switch (status) {
      case "process":
        return "Process";

      case "preparing":
        return "Preparing";

      case "on_the_way":
        return "On the way";

      case "delivered":
        return "Delivered";

      case "cancelled":
        return "Cancelled";

      case "rejected":
        return "Rejected";

      default:
        return "";
    }
  }
}