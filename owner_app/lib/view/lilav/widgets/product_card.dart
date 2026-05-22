import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/model/myProduct.dart';
import 'package:owner_app/view/lilav/screens/add_edit_product_page.dart';
import 'package:owner_app/view/lilav/widgets/app_dialogs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  final controller = Get.find<ProductController>();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final PageController cardPageController = PageController();
    final List<String> productImages = product.variants.isNotEmpty
        ? product.variants[0].images
        : [product.imagePath];
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundSecondaryDarkHome : Colors.white,

        borderRadius: BorderRadius.circular(15),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),

            blurRadius: 14,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),

                    child: PageView.builder(
                      controller: cardPageController,
                      itemCount: productImages.length,
                      itemBuilder: (context, index) {
                        final imagePath = productImages[index];
                        return imagePath.startsWith('assets/')
                            ? Image.asset(imagePath, fit: BoxFit.cover)
                            : Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              );
                      },
                    ),
                  ),
                ),
                if (productImages.length>1)
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                     controller: cardPageController,
                     count: productImages.length,
                     effect: ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                      activeDotColor: Colors.black,
                      dotColor: Colors.white.withOpacity(0.6)
                     ), 
                    
                      
                      ),
                  )
                
                
                ),

                // ACTION BUTTONS
                Positioned(
                  top: 10,
                  right: 10,

                  child: Row(
                    children: [
                      // EDIT
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AddProductPage(product: product));
                        },

                        child: Container(
                          padding: const EdgeInsets.all(6),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: const Icon(
                            Icons.edit_outlined,

                            size: 18,

                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      /// DELETE
                      GestureDetector(
                        onTap: () {
                          AppDialogs.confirm(
                            title:'delete_product'.tr,

                            description:
                               'coniform_delete'.tr,

                            confirmText: 'delete'.tr,

                            onConfirm: () {
                              controller.removeProduct(product);
                            },
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.all(6),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: const Icon(
                            Icons.delete_outline,

                            size: 18,

                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(top: 10, left: 10, child: _buildRatingBadge()),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  product.title,

                  style: TextStyle(
                    fontFamily: AppFonts.heading(),

                    fontWeight: FontWeight.bold,

                    color: isDark
                        ? AppColors.textDarkthemeHome
                        : AppColors.text,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  product.description,

                  style: TextStyle(
                    fontSize: 12,

                    color: Colors.grey,

                    fontFamily: AppFonts.heading(),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      '${product.price} SYP',

                      style: TextStyle(
                        fontSize: 14,

                        fontWeight: FontWeight.w900,

                        color: const Color(0xFF2E7D32),

                        fontFamily: AppFonts.body(),
                      ),
                    ),

                    Text(
                      ' color:  ${product.variants.length} ',

                      style: TextStyle(
                        fontSize: 12,

                        color: Colors.grey,

                        fontFamily: AppFonts.heading(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                _buildActivationSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivationSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          product.isActive ? 'is_active'.tr : 'disabled'.tr,

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.body(),
          ),
        ),

        Switch(
          value: product.isActive,

          activeColor: Colors.green,

          inactiveThumbColor: Colors.grey,

          onChanged: (_) {
            controller.toggleActivation(product);
          },
        ),
      ],
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize:
            MainAxisSize.min, 
        children: [
          Icon(Icons.star, color: Colors.amber, size: 14),
          SizedBox(width: 3),
          Text(
            "4.8",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
