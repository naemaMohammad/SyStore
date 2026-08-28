import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/stores/store_controller.dart';
import 'package:owner_app/data/data_source/api_constants.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreController>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          final localCover = controller.tempCoverPath.value;
          final serverCover =
              controller.storeModel.value?.store?.coverImage ?? '';

          ImageProvider imageProvider;
          if (localCover.isNotEmpty) {
            imageProvider = FileImage(File(localCover));
          } else if (serverCover.isNotEmpty) {
            imageProvider = NetworkImage(
              ApiConstants.getFullImageUrl(serverCover),
            );
          } else {
            imageProvider = const AssetImage('assets/images/store_cover.jpg');
          }

          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
            child: controller.isEditing.value
                ? Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: InkWell(
                        onTap: () =>
                            controller.pickImageFromGallery(isLogo: false),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 36,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'change_cover'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NunitoSans',
                                fontFamilyFallback: ['Tajawal'],
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                  ),
                                ],
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
      ],
    );
  }
}
