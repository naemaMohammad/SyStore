import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/stores/store_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/data_source/api_constants.dart';

class StoreInfo extends StatelessWidget {
  final controller = Get.find<StoreController>();
  final String baseUrl = ApiConstants.baseUrl.replaceAll('api/', '');

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();

  StoreInfo({super.key}) {
    final store = controller.storeModel.value;
    nameController.text = store?.store?.storeName ?? '';
    descriptionController.text = store?.store?.description ?? '';
    phoneController.text = store?.store?.storePhone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundSecondaryDarkHome
            : Colors.grey.shade300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. الجزء العلوي: اللوجو + النصوص + زر التعديل والحفظ
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم عرض واختيار صورة اللوجو
              Obx(() {
                final localLogo = controller.tempLogoPath.value;
                final serverLogo =
                    controller.storeModel.value?.store?.logoImage ?? '';

                ImageProvider imageProvider;
                if (localLogo.isNotEmpty) {
                  imageProvider = FileImage(File(localLogo));
                } else if (serverLogo.isNotEmpty) {
                  imageProvider = NetworkImage(
                    ApiConstants.getFullImageUrl(serverLogo),
                  );
                } else {
                  imageProvider = const AssetImage('assets/images/logo.png');
                }

                return GestureDetector(
                  onTap: controller.isEditing.value
                      ? () => controller.pickImageFromGallery(isLogo: true)
                      : null,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: controller.isEditing.value
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (controller.isEditing.value)
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.35),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(width: 12),

              // تفاصيل المتجر (الاسم، الوصف، الهاتف)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // اسم المتجر
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 35,
                          child: TextField(
                            controller: nameController,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      }
                      return Text(
                        controller.storeModel.value?.store?.storeName ?? '',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.heading(),
                          color: isDark
                              ? AppColors.textSecondaryDartkthemeHome
                              : Colors.grey.shade900,
                        ),
                      );
                    }),
                    const SizedBox(height: 4),

                    // وصف المتجر
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 30,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      }
                      return Text(
                        controller.storeModel.value?.store?.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.textDarkthemeHome
                              : Colors.grey.shade900,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                        ),
                      );
                    }),
                    const SizedBox(height: 6),

                    // رقم الهاتف
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 35,
                          child: TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 15,
                            color: isDark
                                ? AppColors.backgroundLight
                                : AppColors.backgroundDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.storeModel.value?.store?.storePhone ??
                                '',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.grey.shade900,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              // زر التعديل والحفظ (يأخذ مكانه تلقائياً في نهاية الـ Row حسب لغة الجهاز)
              GestureDetector(
                onTap: () async {
                  if (controller.isEditing.value) {
                    await controller.updateStoreInfoApi(
                      name: nameController.text.trim(),
                      description: descriptionController.text.trim(),
                      phone: phoneController.text.trim(),
                    );
                  } else {
                    controller.isEditing.value = true;
                  }
                },
                child: Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      controller.isEditing.value
                          ? Icons.check
                          : Icons.edit_outlined,
                      size: 22,
                      color: controller.isEditing.value
                          ? Colors.green.shade600
                          : Colors.grey.shade600,
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 2. قائمة اختيار الأصناف (Categories) مقطوعة في أسفل الكرت وبشكل متوافق
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Obx(() {
              final categories = ['men', 'women', 'boys', 'girls'];
              if (controller.isEditing.value) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (controller.selectedCategories.contains(value)) {
                      controller.selectedCategories.remove(value);
                    } else {
                      controller.selectedCategories.add(value);
                    }
                  },
                  itemBuilder: (context) {
                    return categories.map((category) {
                      final isSelected = controller.selectedCategories.contains(
                        category,
                      );
                      return PopupMenuItem<String>(
                        value: category,
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category,
                              style: TextStyle(fontFamily: AppFonts.body()),
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.selectedCategories.isEmpty
                            ? 'select_category'.tr
                            : controller.selectedCategories.join(" , "),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: isDark ? Colors.white70 : Colors.grey.shade900,
                      ),
                    ],
                  ),
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'category'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                      color: isDark ? Colors.white70 : Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: isDark ? Colors.white70 : Colors.grey.shade900,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
