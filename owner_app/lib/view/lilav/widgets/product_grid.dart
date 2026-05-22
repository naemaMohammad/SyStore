import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/view/lilav/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({super.key});

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      
      if (controller.isLoading.value) {

  return const Center(
    child: Padding(
      padding: EdgeInsets.all(40),
      child: CircularProgressIndicator(),
    ),
  );
}
      return GridView.builder(
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),

        padding: const EdgeInsets.symmetric(horizontal: 16),

        itemCount: controller.isFiltering.value
            ? controller.filteredProducts.length
            : controller.products.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,

          childAspectRatio: 0.68,

          crossAxisSpacing: 14,

          mainAxisSpacing: 14,
        ),

        itemBuilder: (context, index) {
          final product = controller.isFiltering.value
              ? controller.filteredProducts[index]
              : controller.products[index];

          return ProductCard(product: product);
        },
      );
    });
  }
}
