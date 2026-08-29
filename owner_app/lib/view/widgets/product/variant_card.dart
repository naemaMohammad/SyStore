import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/products/add_edit_product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/model/product_variant_model.dart';

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
      print('VARIANT CARD IMAGES: ${variant.images}');
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
                children: controller.availableColors.map((appColorModel) {
                  // الاعتماد على الموديل القادم من الكنترولر
                  bool isSelected = variant.color == appColorModel.color;

                  return GestureDetector(
                    onTap: () {
                      controller.selectVariantColor(
                        appColorModel,
                      ); // تمرير الموديل بالكامل ليتعرف الكنترولر على الـ ID
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1,
                          ),
                        ],
                        color: appColorModel.color, // عرض اللون من الموديل
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
              Text(
                'insert_images_of_this_color_only'.tr,
                style: TextStyle(
                  fontFamily: AppFonts.body(),
                  fontSize: 14,
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 10),

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
                                image:
                                    variant.images[imageIndex].startsWith(
                                      'http',
                                    )
                                    ? NetworkImage(variant.images[imageIndex])
                                          as ImageProvider //  إذا كان رابط من السيرفر
                                    : variant.images[imageIndex].startsWith(
                                        'assets/',
                                      )
                                    ? AssetImage(variant.images[imageIndex])
                                          as ImageProvider // إذا كان asset محلي
                                    : FileImage(
                                        File(variant.images[imageIndex]),
                                      ),
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
                ),
              ),

              const SizedBox(height: 20),

              /// STOCK الجدول
              _buildInventoryTable(
                isDark,
                variant,
              ), // تمرير الـ variant الحالي لعرض المخزون الخاص به

              const SizedBox(height: 30),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    final currentVar = controller.currentVariant.value!;

                    if (currentVar.color == null) {
                      Get.snackbar('please'.tr, 'choose_color_first'.tr);
                      return;
                    }
                    if (currentVar.images.isEmpty) {
                      Get.snackbar('please'.tr, 'upload_image_for_variant'.tr);
                      return;
                    }
                    if (currentVar.stock.isEmpty) {
                      Get.snackbar('please'.tr, 'enter_stock_quantity'.tr);
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

  // دالة بناء جدول المقاسات والكميات
  Widget _buildSideTable(
    List<String> sizes,
    bool isDark,
    ProductVariant variant,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
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
                      fontSize: 14,
                      fontFamily: AppFonts.body(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ...sizes.map((size) {
          //  جلب الكمية القادمة من الباك إند المخزنة داخل الـ variant للون والمقاس الحالي
          final int? currentQuantity = variant.stock.containsKey(size)
              ? variant.stock[size]
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: 45,
              child: TextField(
                // إذا كان المقاس قادم من الباك إند وكميته أكبر من 0 يظهر الرقم، غير ذلك يضل الحقل فاضي تماماً
                controller:
                    TextEditingController(
                        text: (currentQuantity != null && currentQuantity > 0)
                            ? currentQuantity.toString()
                            : '',
                      )
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                          offset:
                              ((currentQuantity != null && currentQuantity > 0)
                                      ? currentQuantity.toString()
                                      : '')
                                  .length,
                        ),
                      ),
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  // تحديث الـ stock في الكنترولر عند قيام المستخدم بالتعديل
                  controller.updateStock(size, value);
                },
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? AppColors.backgroundDarkHome
                      : Colors.white,
                  suffixIcon: Container(
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade200,
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

  Widget _buildInventoryTable(bool isDark, ProductVariant variant) {
    final availableSizes = controller.currentSizes.isNotEmpty
        ? controller.currentSizes.toList()
        : variant.stock.keys.toList();
    if (availableSizes.isEmpty) {
      return const Center(child: Text("لا توجد مقاسات متوفرة لهذا المنتج"));
    }

    final leftSizes = availableSizes
        .take((availableSizes.length / 2).ceil())
        .toList();

    final rightSizes = availableSizes
        .skip((availableSizes.length / 2).ceil())
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildSideTable(leftSizes, isDark, variant)),
        const SizedBox(width: 14),
        Expanded(child: _buildSideTable(rightSizes, isDark, variant)),
      ],
    );
  }
}
