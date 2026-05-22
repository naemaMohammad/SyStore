import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/lilav/add_edit_product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';

class VariantCard extends StatelessWidget {
  final int index;
  VariantCard({super.key, required this.index});

  final controller = Get.find<AddProductController>();

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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      if (controller.currentVariant.value == null) {
        return const SizedBox.shrink();
      }
      final variant = controller.currentVariant.value!;

      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),

          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : Colors.white,

            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color: isDark ? Colors.white12 : Colors.grey.shade300,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                   'choose_a_color'.tr,

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      controller.removeVariant(index);

                      Get.back();
                    },

                    child: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// COLORS
              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: availableColors.map((color) {
                  bool isSelected = variant.color == color;

                  return GestureDetector(
                    onTap: () {
                      controller.selectVariantColor(color);
                    },

                    child: Container(
                      width: 34,
                      height: 34,

                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(1),
                            blurRadius: 1,
                          ),
                        ],
                        color: color,
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,

                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),
              Container(
                child: Text(
                  'insert_images_of_this_color_only'.tr,
                  style: TextStyle(
                    fontFamily: AppFonts.body(),
                    fontSize: 14,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ),
              SizedBox(height: 10),

              /// IMAGES
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(variant.images.length, (imageIndex) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),

                          width: 120,
                          height: 120,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            image: DecorationImage(
                              image: variant.images[imageIndex].startsWith('assets/')
                                ? AssetImage(variant.images[imageIndex]) as ImageProvider
                                :FileImage(File(variant.images[imageIndex])),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          top: -3,
                          right: 8,

                          child: GestureDetector(
                            onTap: () {
                              controller.removeVariantImage(imageIndex);
                            },

                            child: Container(
                              padding: const EdgeInsets.all(4),

                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  GestureDetector(
                    onTap: () async {
                      await controller.addVariantImage();
                    },

                    child: Container(
                      width: 120,
                      height: 120,

                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.backgroundDarkHome
                            : Colors.grey.shade100,

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Icon(Icons.add_a_photo_outlined, size: 30),
                    ),
                  ),
                ],
              ),),

              const SizedBox(height: 20),

              /// STOCK
              _buildInventoryTable(isDark),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                height: 40,

                child: ElevatedButton(
                  onPressed: () {
                    final variant = controller.variants[index];

                    if (variant.color == null ||
                        variant.images.isEmpty ||
                        variant.stock.isEmpty) {
                      Get.snackbar("please", "Complete entering  data first");

                      return;
                    }
                  controller.saveCurrentVariant();

                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: Text(
                    'save_color'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSideTable(List<String> sizes, bool isDark) {
    return Column(
      children: [
        // Header 
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ), 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200, 
              borderRadius: BorderRadius.circular(8), 
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2, 
                  child: Text(
                    'quantity'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: AppFonts.body(),
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    'size'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.body(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        
        ...sizes.map((size) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8), 
            child: SizedBox(
              height: 45, 
              child: TextField(
                keyboardType: TextInputType.number,
                textAlignVertical:
                    TextAlignVertical.center, 
                onChanged: (value) {
                  controller.updateStock(size, value);
                },
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? AppColors.backgroundDarkHome
                      : Colors
                            .white, 
                  
                  suffixIcon: Container(
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ), 
                      ),
                    ),
                    child: Text(
                      size,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInventoryTable(bool isDark) {
    final leftSizes = controller.currentSizes
        .take((controller.currentSizes.length / 2).ceil())
        .toList();

    final rightSizes = controller.currentSizes
        .skip((controller.currentSizes.length / 2).ceil())
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(child: _buildSideTable(leftSizes, isDark)),

        const SizedBox(width: 14),

        Expanded(child: _buildSideTable(rightSizes, isDark)),
      ],
    );
  }
}
