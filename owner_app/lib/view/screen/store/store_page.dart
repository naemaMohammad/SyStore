import 'package:flutter/material.dart';
import 'package:owner_app/controller/products/product_controller.dart';
import 'package:owner_app/controller/stores/store_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:get/get.dart';
import 'package:owner_app/view/screen/filter/filter_page.dart';
import 'package:owner_app/view/screen/product/add_edit_product_page.dart';
import 'package:owner_app/view/widgets/image_picker/image_picker_widget.dart';
import 'package:owner_app/view/widgets/store/store_info.dart';

import '../../widgets/product/product_card.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});

  final productController = Get.find<ProductController>();
  final storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final bool filterActive = productController.isFilterActive.value;
      return PopScope(
        canPop: !filterActive,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          if (productController.isFilterActive.value) {
            productController.clearProductFilters();
          }
        },
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              // ✅ تحديث بيانات المتجر والمنتجات عند السحب للأسفل
              storeController.fetchStoreData();
              await productController.fetchStoreAndProducts();
            },
            color: AppColors.primary,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Obx(() {
              if (storeController.isLoading.value ||
                  productController.isFiltering.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(), // ✅ مهم لتفعيل السحب
                child: Column(
                  children: [
                    // HEADER (الغلاف)
                    StoreHeader(),

                    // STORE INFO (بيانات المتجر واللوغو)
                    StoreInfo(),

                    const SizedBox(height: 20),

                    // ACTIONS (الأزرار والفلترة)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          // ADD PRODUCT
                          Expanded(
                            child: SizedBox(
                              height: 55,
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
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'add_new_product'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontFamilyFallback: ['Cairo'],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25),

                          // FILTER BUTTON
                          Container(
                            width: 100,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? Colors.white12 : Colors.grey.shade300,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => DetailedFilterPage());
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'filter'.tr,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Theme.of(context).textTheme.bodySmall?.color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Raleway',
                                        fontFamilyFallback: ['Cairo'],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.filter_alt_outlined,
                                      color: isDark ? Colors.white70 : Colors.grey,
                                      size: 25,
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
                      final products = productController.isFilterActive.value
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
                                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'NunitoSans',
                                    fontFamilyFallback: ['Tajawal'],
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
              );
            }),
          ),
        ),
      );
    });
  }
}