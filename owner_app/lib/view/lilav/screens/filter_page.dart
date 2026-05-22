import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:owner_app/controller/lilav/filter_controller.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';

class DetailedFilterPage extends StatelessWidget {
 final FilterController controller =
    Get.put(FilterController());

DetailedFilterPage({super.key});


  static List<Color> availableColors = [
    const Color(0xFFF0F0F0),
    const Color(0xFFFFFFFF),
    const Color(0xFF000000),
    const Color(0xFF8B1A1A),
    const Color(0xFFFF3131),
    const Color(0xFFFFABAB),
    const Color(0xFF5D4037),
    const Color(0xFFFFF59D),
    const Color(0xFFE67E22),
    const Color(0xFFD7CCC8),
    const Color(0xFF81D4FA),
    const Color(0xFF1A237E),
    const Color(0xFFA5D6A7),
    const Color(0xFF00897B),
    const Color(0xFFE1BEE7),
    const Color(0xFF8E24AA),
    const Color(0xFFD81B60),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () {
            final productController = Get.find<ProductController>();

            productController.isFiltering.value = false;

            productController.filteredProducts.clear();

            Get.back();
          },
        ),
        title: Text(
          'filter'.tr,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('category'.tr),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    [
                          'tshirt'.tr,
                          'jacket'.tr,
                          'hoodie'.tr,
                          'dress'.tr,
                          'skirt'.tr,
                          'sweater'.tr,
                          'set'.tr,
                          'abaya'.tr,
                        ]
                        .map(
                          (cat) => _buildChoiceChip(
                            cat,
                            controller.selectedCategory.value == cat,
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 25),

            _buildSectionTitle('size'.tr),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Obx(
                  () => Row(
                    children: [ 'adult'.tr, 'kids'.tr]
                        .map(
                          (ageGroup) => Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: _buildSizeBox(
                              ageGroup,
                              controller.selectedAgeGroup.value ==
                                  ageGroup, 
                              width: 70,
                              isAgeGroupBox: true, 
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                
                Obx(
                  () => controller.selectedAgeGroup.value.isEmpty
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 20),
                ),

                
                Obx(() {
                  if (controller.selectedAgeGroup.value.isEmpty)
                    return const SizedBox.shrink();

                  List<String> currentSizes =
                      controller.selectedAgeGroup.value == 'Kids'
                      ? ['2Y', '4Y', '6Y', '8Y', '10Y', 'Free']
                      : ['S', 'M', 'L', 'XL', 'XXL', 'Free'];

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: currentSizes
                        .map(
                          (size) => _buildSizeBox(
                            size,
                            controller.selectedSize.value == size,
                            width: 48,
                            isAgeGroupBox: false, 
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
            const SizedBox(height: 25),
            _buildSectionTitle('price'.tr),
            const SizedBox(height: 12),

            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _priceBadge(
                        "Min: ${controller.priceRange.value.start.round()}\$",
                      ),
                      _priceBadge(
                        "Max: ${controller.priceRange.value.end.round()}\$",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 10,
                      ),
                      rangeValueIndicatorShape:
                          const PaddleRangeSliderValueIndicatorShape(),
                      activeTrackColor: const Color(0xFF4A2B66),
                      inactiveTrackColor: Colors.grey.shade200,
                      thumbColor: const Color(0xFF4A2B66),
                    ),
                    child: RangeSlider(
                      values: controller.priceRange.value,
                      min: 0,
                      max: 1000,
                      divisions: 20,
                      labels: RangeLabels(
                        controller.priceRange.value.start.round().toString(),
                        controller.priceRange.value.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        controller.updatePriceRange(values);
                      },
                    ),
                  ),
                ],
              );
            }),

            
            const SizedBox(height: 25),
            _buildSectionTitle('color'.tr),
            const SizedBox(height: 12),
            _buildColorPalette(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildSectionTitle(String title) {
    BuildContext context = Get.context!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.heading(),
        color: isDark ? AppColors.textDarkthemeHome : Colors.black,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected) {
    BuildContext context = Get.context!;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => controller.changeCategory(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A2B66).withOpacity(0.1)
              : isDark
              ? AppColors.backgroundSecondaryDarkHome
              : Colors.white,
          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: isSelected
                ? const Color(0xFF532564)
                : (isDark ? Colors.grey[700]! : Colors.grey.shade300),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.heading(),
            color: isSelected
                ? const Color(0xFF4A2B66)
                : isDark
                ? AppColors.textDarkthemeHome
                : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _priceBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppFonts.body(),
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _buildSizeBox(
    String text,
    bool isSelected, {
    double width = 48,
    bool isAgeGroupBox = false,
  }) {
    BuildContext context = Get.context!;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (isAgeGroupBox) {
          controller.changeAgeGroup(text);
        } else {
          controller.changeSize(text);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A2B66).withOpacity(0.1)
              : isDark
              ? AppColors.backgroundSecondaryDarkHome
              : Colors.white,
          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: isSelected
                ? const Color(0xFF532564)
                : (isDark ? Colors.grey[700]! : Colors.grey.shade300),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.heading(),
            color: isSelected
                ? const Color(0xFF4A2B66)
                : isDark
                ? AppColors.textDarkthemeHome
                : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildColorPalette() {
    return Obx(
      () => Wrap(
        spacing: 12,
        runSpacing: 15,
        children: DetailedFilterPage.availableColors.map((color) {
          bool isChosen = controller.selectedColor.value == color;
          return GestureDetector(
            onTap: () => controller.changeColor(color),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                ),
                if (isChosen)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A2B66),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomButtons() {
    BuildContext context = Get.context!;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                controller.clearFilters();

                final productController = Get.find<ProductController>();

                productController.isFiltering.value = false;

                productController.filteredProducts.clear();
                 Get.back();
              
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
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
                "clear".tr,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : const Color(0xFF532564),
                  fontSize: 18,
                  fontFamily: AppFonts.heading(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                final productController = Get.find<ProductController>();

                var filtered = productController.products.where((product) {
                  //Type
                  bool matchesCategory =
                      controller.selectedCategory.value.isEmpty ||
                      product.productType.toLowerCase().trim() ==
                          controller.selectedCategory.value
                              .toLowerCase()
                              .trim();

                  // SIZE
                  bool matchesSize =
                      controller.selectedSize.value.isEmpty ||
                      product.variants.any(
                        (variant) => variant.stock.keys.contains(
                          controller.selectedSize.value,
                        ),
                      );

                  // PRICE
                  bool matchesPrice =
                      product.price >= controller.priceRange.value.start &&
                      product.price <= controller.priceRange.value.end;

                  //COLOR
                  bool matchesColor =
                      controller.selectedColor.value == null ||
                      product.variants.any(
                        (variant) =>
                            variant.color != null &&
                            variant.color!.value ==
                                controller.selectedColor.value!.value,
                      );

                  return matchesCategory &&
                      matchesSize &&
                      matchesPrice &&
                      matchesColor;
                }).toList();

                productController.filteredProducts.value = filtered;

                productController.isFiltering.value = true;

                Get.back();
              },

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
                "apply".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: AppFonts.heading(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
