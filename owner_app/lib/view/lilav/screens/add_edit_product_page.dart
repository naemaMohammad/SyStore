import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:owner_app/controller/lilav/add_edit_product_controller.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/model/myProduct.dart';
import 'package:owner_app/data/model/product_variant_model.dart';
import 'package:owner_app/view/lilav/widgets/app_dialogs.dart';
import 'package:owner_app/view/lilav/widgets/variant_card.dart';

class AddProductPage extends StatelessWidget {
  final ProductModel? product;
  AddProductPage({super.key, this.product});

  final AddProductController controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (product != null) {
      controller.nameController.text = product!.title;

      controller.priceController.text = product!.price.toString();

      controller.descriptionController.text = product!.description;

      controller.materialController.text = product!.material;

      controller.selectedCategory.value = product!.category;

      controller.selectedProductType.value = product!.productType;

      controller.variants.value = product!.variants;
    }
    return Scaffold(
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
          onPressed: () {
            Get.back();
          },
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
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),

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
            SizedBox(height: 25),
            Obx(() {
              return Column(
                children: List.generate(controller.variants.length, (index) {
                  final savedVariant = controller.variants[index];

                  return GestureDetector(
                    onTap: () {
                      controller.currentVariant.value = ProductVariant(
                        color: savedVariant.color,
                        images: List.from(savedVariant.images),
                        stock: Map.from(savedVariant.stock),
                      );

                      controller.isCreatingVariant.value = true;
                    },

                    child: Container(
                      margin: const EdgeInsets.only(top: 10),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(14),

                        border: Border.all(color: Colors.grey.shade300),
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
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text('color_choosen'.tr,style: TextStyle(fontFamily: AppFonts.body()),),
                            ],
                          ),

                          GestureDetector(
                            onTap: () {
                              controller.variants.removeAt(index);
                              controller.isCreatingVariant.value = false;
                            },

                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),

            const SizedBox(height: 300),
            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                onPressed: () async {
                  if (product == null) {
                   await controller.addNewProduct();

                    AppDialogs.success(title: 'added_successfully'.tr);
                  } else {
                    final updatedProduct = ProductModel(
                      id: product!.id,

                      title: controller.nameController.text,

                      description: controller.descriptionController.text,

                      price: double.parse(controller.priceController.text),

                      category: controller.selectedCategory.value,

                      material: controller.materialController.text,

                      productType: controller.selectedProductType.value,

                      variants: controller.variants,

                      imagePath:
                          controller.variants.isNotEmpty &&
                              controller.variants.first.images.isNotEmpty
                          ? controller.variants.first.images.first
                          : product!.imagePath,

                      isActive: product!.isActive,

                      sizes: product!.sizes,

                      storeId: product!.storeId,
                    );

                    final productController = Get.find<ProductController>();

                    productController.updateProduct(updatedProduct);

                    AppDialogs.success(title: 'update_successfuly'.tr,);

                    await Future.delayed(const Duration(seconds: 1));

                    Get.back();
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                    product == null ? 'add'.tr :'update'.tr,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: AppFonts.heading(),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
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
            fontFamily: AppFonts.body(),
            color: isDark ? AppColors.textDark : AppColors.textLight,
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: TextStyle(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              fontFamily: AppFonts.body(),
              fontSize: 14,
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
          child: DropdownButton<String>(
            value: controller.selectedCategory.value.isEmpty
                ? null
                : controller.selectedCategory.value,

            hint: Text(
              'category'.tr,
              style: TextStyle(fontFamily: AppFonts.body(), color: Colors.grey),
            ),

            dropdownColor: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : Colors.white,

            isExpanded: true,

            icon: const Icon(Icons.keyboard_arrow_down),

            items: controller.categories.map((category) {
              return DropdownMenuItem(
                value: category,

                child: Text(
                  category.tr,
                  style: TextStyle(fontFamily: AppFonts.body(), fontSize: 14),
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
          child: DropdownButton<String>(
            value: controller.selectedProductType.value.isEmpty
                ? null
                : controller.selectedProductType.value,

            hint: Text(
              'type'.tr,
              style: TextStyle(fontFamily: AppFonts.body(), color: Colors.grey),
            ),

            isExpanded: true,

            items: controller.productTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type.tr,
                  style: TextStyle(fontFamily: AppFonts.body(), fontSize: 14),
                ),
              );
            }).toList(),

            onChanged: (value) {
              if (value != null) {
                controller.selectedProductType.value = value;
              }
            },
          ),
        ),
      ),
    );
  }
}
