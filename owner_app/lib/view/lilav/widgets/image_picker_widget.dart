import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:owner_app/controller/lilav/store_controller.dart';

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
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
           image: AssetImage(
  controller.store.value.coverImage,
), 
            fit: BoxFit.cover,
            
          ),
        ),
      ),
      
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
