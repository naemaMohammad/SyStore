import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/product/product_controller.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/widgets/product/product_card.dart';

class TopProductsSection extends StatelessWidget {
  TopProductsSection({super.key});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
      print('=== TopProductsSection build ===');
    return Obx(() {
      final products = controller.topProducts;

      if (products.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'top_rated_products'.tr,
            style: TextStyle(
              fontSize: 22,
              fontFamily: AppFonts.heading(),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 170,
                  child: ProductCard(product: products[index],  
                  store: products[index].store),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}