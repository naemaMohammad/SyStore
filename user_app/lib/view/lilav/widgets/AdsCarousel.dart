import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/controller/lilav/ads_controller.dart';
import 'package:user_app/core/theme/color.dart';

class AdsCarousel extends StatelessWidget {

 AdsCarousel({super.key});

final AdsController controller = Get.put(AdsController());

  @override
  Widget build(BuildContext context) {
     final pageController = PageController();
    return Column(
      children: [

        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: pageController,
            itemCount: controller.ads.length,
            onPageChanged: (index){
              controller.changeIndex( index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:Image.asset(
                  controller.ads[index],
                     fit: BoxFit.cover,
                   )
                ),
              );
            },
          ),
        ),

        SizedBox(height: 10),

        // 🔹 النقاط
        SmoothPageIndicator(
          controller: pageController,
          count: controller.ads.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: AppColors.primary,
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}