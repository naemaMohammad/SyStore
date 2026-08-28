import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:owner_app/controller/products/add_edit_product_controller.dart';
import 'package:owner_app/controller/products/product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/model/ProductModel.dart';
import 'package:owner_app/view/screen/product/add_edit_product_page.dart';
import 'package:owner_app/view/widgets/dialogs/app_dialogs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  final controller = Get.find<ProductController>();

  ProductCard({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final PageController cardPageController = PageController();

    final List<String> productImages = product.image != null
        ? [product.image!]
        : [];

    
    print("DEBUG ProductCard: name=${product.name} | "
        "variants=${product.productVariants} | "
        "images=${product.productImages} | "
        "colorsCount=${_colorsCount()} | "
        "stateProduct=${product.stateProduct}");

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
          // 1. قسم الصورة العلوي
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    child: productImages.isEmpty
                        ? const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        : PageView.builder(
                            controller: cardPageController,
                            itemCount: productImages.length,
                            itemBuilder: (context, index) {
                              final imagePath = productImages[index];

                              // حل مشكلة الانهيار: تحويل المسارات المحلية إلى روابط شبكة عند القراءة من السيرفر
                              if (imagePath.startsWith('http') ||
                                  imagePath.startsWith('Uploads/')) {
                                return Image.network(
                                  ApiConstants.getFullImageUrl(imagePath),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                      ),
                                );
                              } else if (imagePath.startsWith('assets/')) {
                                return Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                );
                              }
                            },
                          ),
                  ),
                ),
                if (productImages.length > 1)
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
                          dotColor: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),

                // ACTION BUTTONS (تعديل وحذف)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final addProductController = Get.put(
                            AddProductController(),
                          );

                          // إظهار مؤشر تحميل صغير
                          Get.dialog(
                            const Center(child: CircularProgressIndicator()),
                            barrierDismissible: false,
                          );

                          try {
                            //  طلب تفاصيل المنتج كاملة بالـ ID باستخدام الدالة المتوفرة في الكنترولر
                            Product? completeProduct =
                                await addProductController.fetchProductDetails(
                                  product.id!,
                                );

                            //  إغلاق مؤشر التحميل بعد وصول البيانات
                            Get.back();

                            if (completeProduct != null) {
                              completeProduct.categoryId = product.categoryId;
                              completeProduct.subCategoryId =
                                  product.subCategoryId;
                              //  تمرير البيانات وتفكيكها محلياً للواجهة
                              addProductController.setProductForEdit(
                                completeProduct,
                              );

                              //  الانتقال لصفحة التعديل
                              Get.to(
                                () => AddProductPage(product: completeProduct),
                              );
                            } else {
                              Get.snackbar(
                                "خطأ",
                                "لم يتم العثور على تفاصيل المنتج",
                              );
                            }
                          } catch (e) {
                            Get.back(); 
                            Get.snackbar(
                              "خطأ",
                              "فشل جلب تفاصيل المنتج كاملة من السيرفر",
                            );
                            print("Error fetching product details: $e");
                          }
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
                      GestureDetector(
                        onTap: () {
                          AppDialogs.confirm(
                            title: 'delete_product'.tr,
                            description: 'coniform_delete'.tr,
                            confirmText: 'delete'.tr,
                            onConfirm: () {
                              controller.removeProduct(product.id!);
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

          // 2. قسم البيانات السفلي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  product.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontFamily: AppFonts.heading(),
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${product.price ?? '0'} SYP',
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis, 
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2E7D32),
                          fontFamily: AppFonts.body(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: Obx(
                        () => Text(
                          '${_colorsCount()} colors'.tr,
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, 
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontFamily: AppFonts.heading(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _buildActivationSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivationSwitch() {
    
    return Obx(() {
      
      final liveProduct = controller.products.firstWhere(
        (p) => p.id == product.id,
        orElse: () => product,
      );
      final dynamic state = liveProduct.stateProduct;
      final bool isActive =
          state == 1 || state == "1" || state == true;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isActive ? 'is_active'.tr : 'disabled'.tr,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.body(),
            ),
          ),
          SizedBox(
            height: 30, 
            child: Switch(
              value: isActive,
              activeThumbColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              onChanged: (newValue) async {
                if (product.id == null) {
                  Get.snackbar("تنبيه", "معرف المنتج غير موجود");
                  return;
                }
                //  استدعاء الـ API لتبديل حالة الظهور (show/hide)
                await controller.toggleProductStatus(product.id!);
              },
            ),
          ),
        ],
      );
    });
  }

  
  int _colorsCount() {
    
    final live = controller.products.firstWhere(
      (p) => p.id == product.id,
      orElse: () => product,
    );

  
    if (live.colorsCount != null) {
      return live.colorsCount!;
    }

    
    final Set<String> colorIds = {};

    void collectFromMap(Map m) {
      for (final key in const ['color_id', 'colorId', 'color']) {
        final id = m[key];
        if (id != null) colorIds.add('$id');
      }
    }

    void scanList(List list) {
      for (final item in list) {
        if (item is Map) {
          collectFromMap(item);
        
          for (final value in item.values) {
            if (value is List) scanList(value);
          }
        }
      }
    }

    final lists = <List>[
      live.productVariants ?? const [],
      live.productImages ?? const [],
    ];

    for (final list in lists) {
      scanList(list);
    }

    return colorIds.length;
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 3),
          Text(
            product.rating != null ? product.rating.toString() : "0",
            style: const TextStyle(
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
