import 'package:flutter/material.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:get/get.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/view/lilav/screens/add_edit_product_page.dart';
import 'package:owner_app/view/lilav/screens/filter_page.dart';
import 'package:owner_app/view/lilav/widgets/product_card.dart';
import 'package:owner_app/view/lilav/widgets/store_header.dart';
import 'package:owner_app/view/lilav/widgets/store_info.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //HEADER
            StoreHeader(),

            // STORE INFO
            StoreInfo(),

            const SizedBox(height: 20),

            // ACTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                children: [
                  // ADD PRODUCT
                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddProductPage());
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Icon(Icons.add, color: Colors.white),

                            const SizedBox(width: 5),

                            Text(
                              'add_new_product'.tr,
                              style: TextStyle(
                                color: Colors.white,

                                fontFamily: AppFonts.body(),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  //FILTER BUTTON
                  Container(
                    width: 100,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => DetailedFilterPage());
                      },
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              "Filter",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.body(),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.grey,
                              size:
                                  20, 
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCTS GRID
            Obx(() {
              final productController = Get.find<ProductController>();

              final products = productController.isFiltering.value
                  ? productController.filteredProducts
                  : productController.products;

              if (products.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),

                        Text(
                          'there_is_no_product_to_offer'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.body(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ProductCard(product: product);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
