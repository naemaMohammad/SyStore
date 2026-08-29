import 'package:flutter/material.dart';
import 'package:user_app/controller/cart/cart_controller.dart';
import 'package:user_app/controller/favorite/favorite_controller.dart';
import 'package:user_app/controller/product/product_detailed_controller.dart';
import 'package:user_app/controller/reports/report_controller.dart';

import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:get/get.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/model/product_detail_model.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/data/model/store_model.dart';
import 'package:user_app/view/screens/stores/store_page.dart';
import 'package:user_app/view/widgets/report_bottom/report_bottom_sheet.dart';


class ProductDetailsPage extends StatefulWidget {
  final ApiProductModel product;
  final StoreModel? store;
  const ProductDetailsPage({super.key, required this.product, this.store});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final ProductDetailsController controller;
  late final String _tag;

  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final CartController cartController = Get.find<CartController>();
  final ReportController reportController = Get.find<ReportController>();

  late final PageController _pageController;

  int? get _storeId {
    if (widget.product.storeId != null) {
      return widget.product.storeId;
    }
    if (widget.product.store?.id != null) {
      return widget.product.store!.id;
    }
    if (widget.store?.id != null) {
      return widget.store!.id;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    final id = widget.product.id;
    _tag = id?.toString() ?? 'product_${identityHashCode(widget.product)}';
    controller = Get.put(ProductDetailsController(), tag: _tag);
    if (id != null) {
      controller.clear();
      controller.loadProduct(id);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    Get.delete<ProductDetailsController>(tag: _tag);
    super.dispose();
  }

  void _jumpToColor(int colorId) {
    final images =
        controller.product.value?.images ?? const <ProductImageModel>[];
    final index = images.indexWhere((i) => i.colorId == colorId);
    if (index >= 0 && _pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<bool> _confirmClearCart(BuildContext context) async {
    final result = await Get.defaultDialog<bool>(
      title: 'cart_different_store_title'.tr,
      middleText: 'cart_clear_confirm'.tr,
      textConfirm: 'continue'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
      },
      onCancel: () {
        Get.back(result: false);
      },
    );
    return result ?? false;
  }

  Future<void> _addToCart(BuildContext context) async {
    final variantId = controller.selectedVariantId;
    if (variantId == null) {
      final incomplete = !controller.selectionComplete;
      Get.snackbar(
        incomplete ? 'select_variant'.tr : 'combo_unavailable'.tr,
        incomplete ? 'select_color_size_first'.tr : 'combo_unavailable_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final storeId = _storeId;
    if (storeId == null) {
      Get.snackbar(
        'Error',
        'Unable to identify store. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final result = await cartController.addVariantToCart(
      productVariantId: variantId,
      quantity: controller.quantity.value,
      confirmClear: () => _confirmClearCart(context),
      storeId: storeId,
    );

    if (result == AddToCartResult.added) {
      Get.snackbar(
        'cart_added'.tr,
        'cart_added_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      final storeData = widget.product.store ?? widget.store;

      if (storeData != null && mounted) {
        Get.off(() => StorePage(store: storeData));
      }
    } else if (result == AddToCartResult.declined) {
      Get.snackbar(
        'cart_unchanged'.tr,
        'cart_kept_previous'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _buyNow(BuildContext context) async {
    final variantId = controller.selectedVariantId;
    if (variantId == null) {
      final incomplete = !controller.selectionComplete;
      Get.snackbar(
        incomplete ? 'select_variant'.tr : 'combo_unavailable'.tr,
        incomplete ? 'select_color_size_first'.tr : 'combo_unavailable_msg'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final storeId = _storeId;
    if (storeId == null) {
      Get.snackbar(
        'Error',
        'Unable to identify store. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final result = await cartController.addVariantToCart(
      productVariantId: variantId,
      quantity: controller.quantity.value,
      confirmClear: () => _confirmClearCart(context),
      storeId: storeId,
    );

    if (result == AddToCartResult.added) {
      Get.toNamed(AppRoutes.cart);
    } else if (result == AddToCartResult.declined) {
      Get.snackbar(
        'cart_unchanged'.tr,
        'cart_kept_previous'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _reportProduct() async {
    final productId = widget.product.id;
    if (productId == null) return;
    await showReportBottomSheet(
      context: context,
      title: 'report_product_title'.tr,
      predefinedReasons: [
        'report_product_reason_1'.tr,
        'report_product_reason_2'.tr,
        'report_product_reason_3'.tr,
      ],
      onSubmit: (reason) async {
        final ok = await reportController.reportProduct(productId, reason);
        if (ok) {
          Get.snackbar(
            'report_submitted_title'.tr,
            'report_submitted_msg'.tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        return ok;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final storeData = widget.product.store ?? widget.store;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 480,
                  width: double.infinity,
                  child: Obx(() {
                    final images =
                        controller.product.value?.images ??
                        const <ProductImageModel>[];
                    if (controller.isLoading.value) {
                      return Container(
                        color: isDark ? Colors.black54 : Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    if (images.isEmpty) {
                      return Container(
                        color: isDark ? Colors.black54 : Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.black26,
                          ),
                        ),
                      );
                    }
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) => Container(
                        color: isDark ? Colors.black54 : Colors.grey.shade200,
                        child: Image.network(
                          images[index].url,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 40,
                                  color: Colors.black26,
                                ),
                              ),
                        ),
                      ),
                    );
                  }),
                ),

                // Store logo button
                Positioned(
                  top: 40,
                  left: 6,
                  child: GestureDetector(
                    onTap: () {
                      print('widget.store: ${widget.store?.storeName}');
                      print('widget.store logo: ${widget.store?.logoUrl}');
                      print(
                        'product.store: ${widget.product.store?.storeName}',
                      );
                      print(
                        'product.store logo: ${widget.product.store?.logoUrl}',
                      );
                      final storeData = widget.product.store ?? widget.store;
                      if (storeData != null) {
                        Get.to(() => StorePage(store: storeData));
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Colors.black, blurRadius: 1),
                        ],
                      ),
                      child: ClipOval(
                        child: (storeData?.logoUrl.isEmpty ?? true)
                            ? const Icon(
                                Icons.store,
                                size: 24,
                                color: Colors.black26,
                              )
                            : Image.network(
                                storeData!.logoUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.store,
                                      size: 24,
                                      color: Colors.black26,
                                    ),
                              ),
                      ),
                    ),
                  ),
                ),

                // Report button
                Positioned(
                  top: 100,
                  left: 6,
                  child: GestureDetector(
                    onTap: _reportProduct,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 1),
                        ],
                      ),
                      child: const Icon(
                        Icons.outlined_flag,
                        size: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 40,
                  right: 6,
                  child: Obx(() {
                    final id = product.id;
                    final isFav = id == null
                        ? false
                        : favoriteController.isFavorite(id);
                    return GestureDetector(
                      onTap: () {
                        if (id != null) {
                          favoriteController.toggleFavorite(
                            id,
                            product: product,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 97, 97, 97),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? AppColors.primary : Colors.black,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),

                // Cart icon
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            isDark
                                ? const Color(0xFF1E1E1E).withOpacity(0.5)
                                : Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? '',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontFamilyFallback: const ['Cairo'],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        "${product.priceValue} ${'currency'.tr}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: const ['Tajawal'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "description".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${'material'.tr}: ${product.material ?? ''}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                    ),
                  ),
                  const Divider(height: 30, color: Colors.grey),

                  Text(
                    "select_size".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      runSpacing: 15,
                      children: controller.availableSizes.map((entry) {
                        final size = entry.size;
                        final sizeId = entry.sizeId;
                        bool isSelected =
                            controller.selectedSizeId.value == sizeId;
                        return GestureDetector(
                          onTap: () {
                            controller.selectSize(sizeId);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark
                                        ? Theme.of(
                                            context,
                                          ).primaryColor.withOpacity(0.3)
                                        : Theme.of(
                                            context,
                                          ).primaryColor.withOpacity(0.1))
                                  : (isDark
                                        ? Theme.of(context).secondaryHeaderColor
                                        : Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : (isDark
                                          ? Colors.grey[700]!
                                          : Colors.grey.shade300),
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? (isDark
                                          ? Colors.white
                                          : const Color(0xFF532564))
                                    : (isDark ? Colors.white70 : Colors.black),
                                fontFamily: 'Raleway',
                                fontFamilyFallback: ['Cairo'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    "select_color".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 45,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Obx(
                        () => Row(
                          children: controller.availableColors.map((entry) {
                            final colorId = entry.colorId;
                            bool isSelected =
                                controller.selectedColorId.value == colorId;
                            return GestureDetector(
                              onTap: () {
                                controller.selectColor(colorId);
                                _jumpToColor(colorId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: entry.swatch,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF532564)
                                        : Colors.grey.shade300,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      ),
                                  ],
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Text(
                        "quantity".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => controller.decreaseQuantity(),
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${controller.quantity.value}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.increaseQuantity(),
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E)
              : Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 5,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            //Add to Cart Button
            Expanded(
              flex: 2,
              child: Obx(() {
                final enabled =
                    controller.canAddToCart && !cartController.adding.value;
                return ElevatedButton(
                  onPressed: enabled ? () => _addToCart(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF532564),
                    elevation: Theme.of(context).brightness == Brightness.dark
                        ? 0
                        : 2,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "add_to_cart".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 12),

            // Buy Now Button
            Expanded(
              flex: 1,
              child: Obx(() {
                final enabled =
                    controller.canAddToCart && !cartController.adding.value;
                return OutlinedButton(
                  onPressed: enabled ? () => _buyNow(context) : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,
                    side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : const Color(0xFF532564),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "buy_now".tr,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xFF532564),
                      fontSize: 18,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
