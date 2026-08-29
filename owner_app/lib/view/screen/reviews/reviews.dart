import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/reviews/ReviewsController.dart';
import 'package:owner_app/view/widgets/reviews/card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Reviewscontroller>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '32'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.reviews.isEmpty) {
          return Center(
            child: Text(
              '47'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            final review = controller.reviews[index];
            return Cardreviews(
              image: review.image ?? "",
              orderId: "#${review.orderId ?? 0}",
              customerName: review.userName ?? "",
              phone: review.userPhone ?? "",
              rating: double.tryParse(review.rating ?? "0") ?? 0.0,
              isSelected: false,
            );
          },
        );
      }),
    );
  }
}
