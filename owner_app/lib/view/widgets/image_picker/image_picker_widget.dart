import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:owner_app/controller/stores/store_controller.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final controller =
    Get.find<StoreController>();
    
    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;
  return Stack(
    clipBehavior: Clip.none,
    children: [
      //  Cover Image
     Obx(() {
  // 1. فحص ما إذا كانت البيانات لم تصل بعد من السيرفر، نعرض مؤشر تحميل خفيف
  if (controller.storeModel.value == null || controller.storeModel.value!.store?.coverImage == null) {
    return const SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // 2. إذا وصلت البيانات، نقوم برسم الـ Container وعرض الصورة من الباك إند بأمان 100%
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(controller.storeModel.value!.store!.coverImage!),
        fit: BoxFit.cover,
      ),
    ),
  );
}),
      
   //  back botton
      Positioned(
        top: 10,
        left: 10,
        child: CircleAvatar(
         backgroundColor: isDark
    ? Colors.black.withOpacity(0.5)
    : Colors.white.withOpacity(0.7),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark
                     ? Colors.white
                        : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ],
  );
}
  }
