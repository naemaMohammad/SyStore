import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/controller/lilav/store_controller.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  
  Future<void> _changeCoverImage(StoreController controller) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      controller.store.update((val) {
        if (val != null) val.coverImage = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreController>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          final coverPath = controller.store.value.coverImage;
          
          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: coverPath.startsWith('assets/')
                    ? AssetImage(coverPath) as ImageProvider
                    : FileImage(File(coverPath)),
                fit: BoxFit.cover,
              ),
            ),
            child: controller.isEditing.value
                ? Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: InkWell(
                        onTap: () => _changeCoverImage(controller),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt, color: Colors.white, size: 36),
                            const SizedBox(height: 8),
                            Text(
                              "Change Cover",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 4)],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          );
        }),

        Positioned(
          top: 10,
          left: 10,
          child: CircleAvatar(
            backgroundColor: isDark
                ? Colors.black.withOpacity(0.5)
                : Colors.white.withOpacity(0.7),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}