import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import 'package:user_app/view/lilav/Sreens/store_page.dart';

class StoreCard extends StatelessWidget {
  final StoreModel selectedStore;

  const StoreCard({
    super.key,
    required this.selectedStore, 
  });

  @override
  Widget build(BuildContext context) {

     final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
    onTap: () {
        Get.to(() => StorePage(store: selectedStore)); // استخدام GetX للتنقل أسهل
      },
      child: Container(
        width: 155.5,
        height: 180,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2C2C2C) // لون رمادي غامق جداً يعطي عمقاً فوق الخلفية الأساسية
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.03)
                  : Colors.black.withOpacity(0.08),

              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // القسم العلوي (الصورة)
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                 color: isDark && selectedStore.bgColor == Colors.white
                      ? Colors.grey[300] // تفتيح بسيط لتمييز اللوجو
                      : selectedStore.bgColor, // جلب اللون من الموديل
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          selectedStore.image, // جلب المسار من الموديل
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.store, size: 40, color: Colors.black26),
                        ),
                      ),
                      // أيقونة التقييم
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(

                            color: isDark
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.9),

                            borderRadius: BorderRadius.circular(8),
                            border: isDark 
                                ? Border.all(color: Colors.white10, width: 0.5) 
                                : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedStore.rating.toString(), // تحويل التقييم لنص
                                style: TextStyle(
                                   color: isDark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10,
                                   fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.star, color: Colors.amber, size: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // القسم السفلي (النصوص)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      selectedStore.name, // جلب الاسم من الموديل
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFonts.heading(),
                        color: isDark
                            ? Colors.white.withOpacity(0.9)
                            : const Color(0xFF202020),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${'category_label'.tr} : ${selectedStore.category.tr}", // جلب الفئة من الموديل
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.heading(),
                        color: isDark
                            ? Colors.white54 // لون رمادي فاتح للنصوص الثانوية
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}