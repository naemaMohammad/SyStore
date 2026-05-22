import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/controller/lilav/store_controller.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';

class StoreInfo extends StatelessWidget {
  final controller = Get.find<StoreController>();

  StoreInfo({super.key});

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  
  final RxString tempLogoPath = ''.obs;

  Future<void> _pickLogoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      tempLogoPath.value = image.path; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final store = controller.store.value;

    nameController.text = store.name;
    descriptionController.text = store.description;
    phoneController.text = store.phone;
    
    if (tempLogoPath.value.isEmpty) {
      tempLogoPath.value = store.logo;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundSecondaryDarkHome : Colors.grey.shade300, 
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), 
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Obx(() {
                final isAsset = tempLogoPath.value.startsWith('assets/');
                return GestureDetector(
                  onTap: controller.isEditing.value ? _pickLogoFromGallery : null,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: controller.isEditing.value ? AppColors.primary : Colors.transparent,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: isAsset
                                ? AssetImage(tempLogoPath.value) as ImageProvider
                                : FileImage(File(tempLogoPath.value)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (controller.isEditing.value)
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.35),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 26),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(width: 16), 
              
            
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 35,
                          child: TextField(
                            controller: nameController,
                            style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: AppFonts.body()),
                            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.zero),
                          ),
                        );
                      }
                      return Text(
                        store.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.heading(),
                          color: isDark ? AppColors.textSecondaryDartkthemeHome : Colors.grey.shade900,
                        ),
                      );
                    }),
                    const SizedBox(height: 4),
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 30,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.zero),
                          ),
                        );
                      }
                      return Text(
                        store.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isDark ? AppColors.textDarkthemeHome : Colors.grey.shade900,
                          fontFamily: AppFonts.body(),
                        ),
                      );
                    }),
                    const SizedBox(height: 6),
                    Obx(() {
                      if (controller.isEditing.value) {
                        return SizedBox(
                          height: 50,
                          child: TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.zero),
                          ),
                        );
                      }
                      return Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 16, color:isDark ? AppColors.backgroundLight : AppColors.backgroundDark),
                          const SizedBox(width: 6),
                          Text(
                            store.phone,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.grey.shade900,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),

        
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (controller.isEditing.value) {
                  controller.store.update((val) {
                    if (val != null) val.logo = tempLogoPath.value;
                  });
                  controller.updateStoreInfo(
                    name: nameController.text,
                    description: descriptionController.text,
                    phone: phoneController.text,
                  );
                }
                controller.isEditing.value = !controller.isEditing.value;
              },
              child: Obx(() {
                return Icon(
                  controller.isEditing.value ? Icons.check : Icons.edit_outlined,
                  size: 22,
                  color: controller.isEditing.value ? Colors.green.shade600 : Colors.grey.shade500,
                );
              }),
            ),
          ),

        
          Positioned(
            bottom: 0,
            right: 0,
            child: Obx(() {
              final categories = ['women', 'men', 'girl', 'boy'];
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
                      final isSelected = controller.selectedCategories.contains(category);
                      return PopupMenuItem<String>(
                        value: category,
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(category, style: TextStyle(fontFamily: AppFonts.body())),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.selectedCategories.isEmpty ? 'Select Category' : controller.selectedCategories.join(" , "),
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontFamily: AppFonts.body()),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                    ],
                  ),
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('category', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                  const SizedBox(width: 2),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}