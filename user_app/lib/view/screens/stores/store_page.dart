import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart/cart_controller.dart';
import 'package:user_app/controller/reports/report_controller.dart';
import 'package:user_app/controller/store/store_controller.dart';

import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/model/store_model.dart';
import 'package:user_app/view/widgets/product/product_card.dart';
import 'package:user_app/view/widgets/report_bottom/report_bottom_sheet.dart';
import 'package:user_app/view/widgets/stores/store_filters.dart';


class StorePage extends StatefulWidget {
  final StoreModel store;

  const StorePage({super.key, required this.store});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final StoreController controller = Get.find<StoreController>();

  final CartController cartController = Get.find<CartController>();


  final ReportController reportController = Get.find<ReportController>();

 
  bool? _priceHighToLow;

 
  int? _categoryFilterId;

  @override
  void initState() {
    super.initState();
   
    controller.store.value = widget.store;

   
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadStoreProducts();
    });
  }

  void _loadStoreProducts() {
    final storeId = widget.store.id;
    if (storeId == null) return;
  
    controller.getStore(storeId);
  }

 
  List<dynamic> get _products {
    var products = controller.storeProducts;
    final categoryFilter = _categoryFilterId;
    if (categoryFilter != null) {
      products = products.where((p) => p.categoryId == categoryFilter).toList();
    }
    final sort = _priceHighToLow;
    if (sort == null) return products;
    return products.toList()..sort(
      (a, b) => sort
          ? b.priceValue.compareTo(a.priceValue)
          : a.priceValue.compareTo(b.priceValue),
    );
  }

 
  bool get _cartHasThisStoreItems {
    final storeId = widget.store.id;
    if (storeId == null) return false;
    final currentStoreId = cartController.currentCartStoreId.value;
    if (currentStoreId == null) return false;
    if (!cartController.cartHasItems) return false;
    return currentStoreId == storeId;
  }


  Future<void> _confirmLeaveStore() async {
    final result = await Get.defaultDialog<bool>(
      title: 'leave_store_title'.tr,
      middleText: 'leave_store_clears_cart'.tr,
      textConfirm: 'exit'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
      },
      onCancel: () {
        Get.back(result: false);
      },
    );

    if (result == true) {
      await cartController.clearCart();
      if (mounted) {
        Get.back();
      }
    }
  }

  Future<void> _reportStore() async {
    final storeId = widget.store.id;
    if (storeId == null) return;
    await showReportBottomSheet(
      context: context,
      title: 'report_store_title'.tr,
      predefinedReasons: [
        'report_store_reason_1'.tr,
        'report_store_reason_2'.tr,
        'report_store_reason_3'.tr,
      ],
      onSubmit: (reason) async {
        final ok = await reportController.reportStore(storeId, reason);
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: !_cartHasThisStoreItems,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmLeaveStore();
      },
      child: Scaffold(
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                
                  Obx(() {
                    final store = controller.store.value ?? widget.store;
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black54
                                : Colors.grey.shade200,
                            image: store.coverUrl.isEmpty
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(store.coverUrl),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: CircleAvatar(
                              backgroundColor: isDark
                                  ? Colors.black54
                                  : Colors.white54,
                              child: Icon(
                                Get.locale?.languageCode == 'ar'
                                    ? Icons.arrow_forward
                                    : Icons.arrow_back,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 20,
                          child: CircleAvatar(
                            backgroundColor: isDark
                                ? Colors.black54
                                : Colors.white54,
                            child: PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              onSelected: (value) {
                                if (value == 'report_store') _reportStore();
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'report_store',
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.outlined_flag,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 10),
                                      Text('report_store_menu'.tr),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -35,
                          left: 20,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.backgroundSecondaryDarkHome
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.backgroundDarkHome
                                    : Colors.white,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: store.logoUrl.isEmpty
                                  ? const Icon(
                                      Icons.store,
                                      size: 40,
                                      color: Colors.black26,
                                    )
                                  : Image.network(
                                      store.logoUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.store,
                                                size: 40,
                                                color: Colors.black26,
                                              ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Obx(() {
   final store = controller.store.value ?? widget.store;
  final rating = controller.storeRating.value;

  return Row(
    children: [
      Expanded(
        child: Text(
          store.storeName ?? '',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            color: isDark
                ? AppColors.textDarkHome
                : Colors.black,
          ),
        ),
      ),
      const SizedBox(width: 10),
      _buildStoreRatingBadge(rating),
    ],
  );
}),
                              SizedBox(height: 4),
                              Obx(
                                () => Text(
                                  (controller.store.value ?? widget.store)
                                          .description ??
                                      '',
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textSecondaryDarkHome
                                        : Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'NunitoSans',
                                    fontFamilyFallback: ['Tajawal'],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone_in_talk_rounded,
                                    size: 16,
                                    color: isDark
                                        ? AppColors.textSecondaryDarkHome
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Obx(
                                    () => Text(
                                      (controller.store.value ?? widget.store)
                                              .storePhone ??
                                          '',
                                      style: TextStyle(
                                        color: isDark
                                            ? AppColors.textSecondaryDarkHome
                                            : Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'NunitoSans',
                                        fontFamilyFallback: ['Tajawal'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  StoreFilters(
                    storeId: widget.store.id ?? 0,
                    onFilterApplied: (params) {
                      _loadStoreProducts();
                    },
                    onCategoryChanged: (int? categoryId) {
                     
                      setState(() => _categoryFilterId = categoryId);
                    },
                    onPriceSortChanged: (highToLow) {
                      setState(() => _priceHighToLow = highToLow);
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: Obx(() {
                final products = _products;
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(product: products[index],
                    store: controller.store.value ?? widget.store,);
                  }, childCount: products.length),
                );
              }),
            ),
          ],
        ),
         bottomNavigationBar: Obx(() {
      if (!_cartHasThisStoreItems) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.cart),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF532564),
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),  ),
            child: Text(
              'view_the_cart'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: AppFonts.heading(),
              ),
            ),
          ),
        ),
      );
    }),
      ),
    );
  }
  Widget _buildStoreRatingBadge(double rating) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 14),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Tajawal'],
          ),
        ),
      ],
    ),
  );
}
}
