import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/controller/filter/filter_controller.dart';
import 'package:user_app/core/constants/filter_catalog.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/screens/filter/product_results_page.dart';

class DetailedFilterPage extends StatelessWidget {
  final String initialCategory;
  final double initialPrice;


  final int storeId;

  final FilterController controller = Get.find<FilterController>();
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

  DetailedFilterPage({
    super.key,
    required this.initialCategory,
    required this.initialPrice,
    required this.storeId,
  }) {
    controller.initialize(category: initialCategory, price: initialPrice);
  }

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
            Get.back();
          },
        ),
        title: Text(
          'Filter'.tr,
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
                children: kCategories.map((c) {
                  final label = c.name.tr;
                  final selected =
                      controller.selectedParentCategoryId.value == c.id;
                  return GestureDetector(
                    onTap: () => controller.changeParentCategory(label, c.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF4A2B66).withOpacity(0.1)
                            : isDark
                            ? AppColors.backgroundSecondaryDarkHome
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF532564)
                              : (isDark
                                    ? Colors.grey[700]!
                                    : Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontFamily: AppFonts.heading(),
                          color: selected
                              ? const Color(0xFF4A2B66)
                              : isDark
                              ? AppColors.textDarkHome
                              : Colors.black54,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),

            // _buildSectionTitle('sub_category'.tr),
            // const SizedBox(height: 12),
            // Obx(
            //   () => Wrap(
            //     spacing: 10,
            //     runSpacing: 10,
            //     children: kSubCategoryChipKeys
            //         .map((key) => key.tr)
            //         .map(
            //           (cat) => _buildChoiceChip(
            //             cat,
            //             controller.selectedSubCategory.value == cat,
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),
            // const SizedBox(height: 25),

            _buildSectionTitle('size'.tr),
            const SizedBox(height: 12),
           
            Obx(() {
              final currentSizes = sizeLabelsFor(
                controller.selectedParentCategoryId.value,
              );
              if (currentSizes.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'select_category_first'.tr,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                      fontFamily: AppFonts.body(),
                    ),
                  ),
                );
              }
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
                        "Min: ${controller.priceRange.value.start.round()} SYP",
                      ),
                      _priceBadge(
                        "Max: ${controller.priceRange.value.end.round()} SYP",
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
                      max: 10000,
                      divisions: 200,
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
        color: isDark ? AppColors.textDarkHome : Colors.black,
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected) {
    BuildContext context = Get.context!;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => controller.changeSubCategory(label),
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
                ? AppColors.textDarkHome
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
      onTap: () => controller.changeSize(text),
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
                ? AppColors.textDarkHome
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
              onPressed: () => controller.clearFilters(),
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
             
                final Map<String, dynamic> params = controller.buildParams(
                  storeId: storeId,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductResultsPage(
                      filterParams: params,
                      title: 'Filter',
                    ),
                  ),
                );
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
