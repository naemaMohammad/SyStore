import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user_app/controller/lilav/store_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import '../widgets/store_filters.dart';
import '../widgets/product_card.dart';

class StorePage extends StatefulWidget {
  final StoreModel store;

  const StorePage({super.key, required this.store});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // القائمة التي سيتم عرضها في الواجهة (تبدأ بنسخة من القائمة الثابتة)
  final StoreController controller = Get.put(StoreController());
  @override
void initState() {
  super.initState();

  controller.initializeProducts(ProductCard.allProducts);
}

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.store.coverImage),
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
                            Icons.arrow_back,
                            color: isDark ? Colors.white : Colors.black,
                          ),
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
                          image: DecorationImage(
                            image: AssetImage(widget.store.image),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                            Text(
                              widget.store.name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.heading(),
                                color: isDark
                                    ? AppColors.textDarkHome
                                    : Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              widget.store.description,
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDarkHome
                                    : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_in_talk_rounded,
                                  size: 14,
                                  color: isDark
                                      ? AppColors.textSecondaryDarkHome
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.store.phoneNumber,
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textSecondaryDarkHome
                                        : Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.backgroundSecondaryDarkHome
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark
                                ? Colors.white12
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.store.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // تمرير الوظائف للـ StoreFilters
                StoreFilters(
                  onFilterApplied: (results) {
                    // استلام القائمة الجاهزة

                    // تحديث القائمة المعروضة مباشرة بالنتائج التي وصلت من صفحة الفلترة
                    controller.applyFilters(results);
                  },
                  onCategoryChanged: controller.filterByCategory,
                  onPriceSortChanged: controller.sortByPrice,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver:Obx(() => SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                // عرض المنتج مباشرة من القائمة المفلترة
                return controller.filteredProducts[index];
              }, childCount: controller.filteredProducts.length),
            ),
          ),),
        ],
      ),
    );
  }
}
