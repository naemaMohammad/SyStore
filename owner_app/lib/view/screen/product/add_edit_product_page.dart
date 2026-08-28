import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/products/add_edit_product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';

import 'package:owner_app/data/model/CategoryModel.dart';
import 'package:owner_app/data/model/ProductModel.dart';
import 'package:owner_app/data/model/product_variant_model.dart';
import 'package:owner_app/view/widgets/dialogs/app_dialogs.dart';
import 'package:owner_app/view/widgets/product/variant_card.dart';


class AddProductPage extends StatelessWidget {
  final Product? product;
  final AddProductController controller = Get.put(AddProductController());

  AddProductPage({super.key, this.product}) {
    if (product != null) {
      controller.setProductForEdit(product!);
    } else {
      controller.clearData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'add_product'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.white12 : Colors.grey.shade300,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // ✅ المحتوى القابل للتمرير
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    hint: 'product_name'.tr,
                    textController: controller.nameController,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          hint: 'price'.tr,
                          textController: controller.priceController,
                          isDark: isDark,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: _buildCategorySelector(isDark)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          hint: 'material'.tr,
                          textController: controller.materialController,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _buildProductTypeDropdown(isDark)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    hint: 'description'.tr,
                    textController: controller.descriptionController,
                    isDark: isDark,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addVariant();
                        final index = controller.variants.length - 1;
                        Get.dialog(
                          Dialog(
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.82,
                              child: VariantCard(index: index),
                            ),
                          ),
                          barrierDismissible: false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'add_color'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Obx(() {
                    return Column(
                      children: List.generate(controller.variants.length, (
                        index,
                      ) {
                        final savedVariant = controller.variants[index];
                        return GestureDetector(
                          onTap: () {
                            controller.editingVariantIndex = index;
                            controller.currentVariant.value = ProductVariant(
                              color: savedVariant.color,
                              colorId: savedVariant.colorId,
                              images: List.from(savedVariant.images),
                              stock: Map.from(savedVariant.stock),
                            );
                            controller.isCreatingVariant.value = true;
                            Get.dialog(
                              Dialog(
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 40,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.82,
                                  child: VariantCard(index: index),
                                ),
                              ),
                              barrierDismissible: false,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.backgroundSecondaryDarkHome
                                    : Colors.white,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: savedVariant.color,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.white24
                                              : Colors.black.withOpacity(0.15),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.08,
                                            ),
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'color_choosen'.tr,
                                      style: TextStyle(
                                        fontFamily: AppFonts.body(),
                                        color: isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.variants.removeAt(index);
                                    controller.isCreatingVariant.value = false;
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  // ✅ مسافة إضافية في الأسفل عشان الزر ما يغطي المحتوى
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // ✅ الزر الثابت في الأسفل
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.value) return;
                  final validationMessage = controller.validateProduct();
                  if (validationMessage != null) {
                    AppDialogs.error(title: validationMessage);
                    return;
                  }
                  bool success = false;
                  if (product == null) {
                    success = await controller.saveProductToApi(
                      isEditMode: false,
                    );
                    if (success) {
                      AppDialogs.success(
                        title: 'added_successfully'.tr,
                        onOk: () => Get.back(),
                      );
                    } else {
                      AppDialogs.error(title: 'failed_to_add_product'.tr);
                    }
                  } else {
                    success = await controller.saveProductToApi(
                      isEditMode: true,
                      editProductId: product!.id,
                    );
                    if (success) {
                      AppDialogs.success(
                        title: 'update_successfuly'.tr,
                        onOk: () => Get.back(),
                      );
                    } else {
                      AppDialogs.error(title: 'failed_to_update_product'.tr);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return Text(
                    product == null ? 'add'.tr : 'update'.tr,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: AppFonts.heading(),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController textController,
    required bool isDark,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TextField(
          controller: textController,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Tajawal'],
            color: isDark ? AppColors.textDark : AppColors.textLight,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontFamily: 'NunitoSans',
              fontFamilyFallback: ['Tajawal'],
              fontSize: 15,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector(bool isDark) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.backgroundSecondaryDarkHome : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade300,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<CategoryModel>(
            value: controller.selectedCategory.value,
            hint: Text(
              'category'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: Colors.grey,
              ),
            ),
            dropdownColor: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : Colors.white,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: controller.categories.map((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(
                  category.name.tr,
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    fontSize: 15,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.selectCategory(value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductTypeDropdown(bool isDark) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.backgroundSecondaryDarkHome : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade300,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SubCategoryModel>(
            value: controller.selectedProductType.value,
            hint: Text(
              'type'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: Colors.grey,
              ),
            ),
            dropdownColor: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : Colors.white,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: controller.productTypes.map((type) {
              return DropdownMenuItem<SubCategoryModel>(
                value: type,
                child: Text(
                  type.name.tr,
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    fontSize: 15,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.selectProductType(value);
              }
            },
          ),
        ),
      ),
    );
  }
}
