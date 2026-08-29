import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/store/store_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/view/widgets/stores/store_card.dart';

import '../../../core/theme/theme.dart';

class TopRatedStoresSection extends StatelessWidget {
  TopRatedStoresSection({super.key});

  final StoreController controller = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
     final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                 Text(
          'top_stores'.tr,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.heading(),
            color: isDark
                ? AppColors.textSecondaryDarkHome
                : const Color(0xFF202020),
          ),
        ),

        const SizedBox(height: 12),

        Obx(() {
          if (controller.isLoading.value &&
              controller.topStores.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.topStores.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topStores.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160,
                  child: StoreCard(
                    selectedStore:
                    controller.topStores[index],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}