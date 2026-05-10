import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart'; // تأكدي من المسار
import 'package:user_app/view/lilav/widgets/store_card.dart'; // تأكدي من المسار

class CategoryPage extends StatelessWidget {
  final String title;

  const CategoryPage({super.key, required this.title});
 
  @override
  Widget build(BuildContext context) {

    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    // 1. تصفية المتاجر: نجلب فقط المتاجر التي تنتمي لهذا القسم
    // استخدمنا toLowerCase() لضمان المقارنة الصحيحة بغض النظر عن حالة الأحرف
    final filteredStores = StoreModel.allStores.where((store) {

      return store.category.toLowerCase() == title.toLowerCase();

    }).toList();

    return Scaffold(
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // استخدم لون الخلفية من الثيم
      appBar:AppBar(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
onPressed: () {
  Get.back();
},
        ),
        title:  Text(
          title,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium?.color,
                // استخدم لون النص من الثيم
             fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
           
          ),
        ), bottom: PreferredSize(
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
      body: filteredStores.isEmpty
          ? _buildEmptyState(context) // إذا لم توجد متاجر في هذا القسم
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredStores.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,           // كرتين في كل صف
                crossAxisSpacing: 15,        // مسافة أفقية
                mainAxisSpacing: 15,         // مسافة رأسية
                childAspectRatio: 0.8,       // تناسب الطول والعرض للكرت
              ),
              itemBuilder: (context, index) {
                // 2. عرض الكارد الخاص بالمتجر المفلتر
                return StoreCard(selectedStore: filteredStores[index]);
              },
            ),
    );
  }

  // واجهة تظهر في حال كان القسم فارغاً
  Widget _buildEmptyState(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory_outlined,
           size: 80,      color: isDark
                ? AppColors.textSecondaryDarkHome
                : Colors.grey[300],),
          const SizedBox(height: 16),
          Text(
            "no_stores".tr,
            style: TextStyle(
              color: isDark
                ? AppColors.textDarkHome
                : Colors.grey[600], 
              fontSize: 16,fontFamily: AppFonts.heading(), 
              fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}