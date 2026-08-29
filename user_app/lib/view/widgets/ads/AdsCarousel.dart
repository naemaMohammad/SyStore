import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/controller/ads/ads_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/data/data_source/api_constants.dart';

class AdsCarousel extends StatefulWidget {
  const AdsCarousel({super.key});

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  final AdsController controller = Get.find<AdsController>();

  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String _getImageUrl(String image) {
    if (image.startsWith('http')) {
      return image;
    }

    return '${ApiConstants.imageBaseUrl}$image';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Loading
      if (controller.isLoading.value && controller.sliders.isEmpty) {
        return const SizedBox(
          height: 180,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // No sliders
      if (controller.sliders.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: pageController,
              itemCount: controller.sliders.length,
              onPageChanged: controller.changeIndex,
              itemBuilder: (context, index) {
                final slider = controller.sliders[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      _getImageUrl(slider.image),
                      fit: BoxFit.cover,

                      loadingBuilder: (
                        context,
                        child,
                        loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },

                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          SmoothPageIndicator(
            controller: pageController,
            count: controller.sliders.length,
            effect: ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: AppColors.primary,
              dotColor: Colors.grey.shade300,
            ),
          ),
        ],
      );
    });
  }
}