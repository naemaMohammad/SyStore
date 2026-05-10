import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/Sreens/all_stores_screen.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import 'package:user_app/view/lilav/widgets/store_card.dart';


class StoresSection extends StatelessWidget {
  const StoresSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        // 1. الهيدر (العنوان + زر العرض)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
          "all_stores".tr,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.heading(),
            color: isDark
    ? AppColors.textDarkHome
    : Colors.black
          ),
        ),
           TextButton(
  onPressed: () {
    // 👈 الكود المسؤول عن الانتقال للصفحة الجديدة
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  AllStoresScreen(),
      ),
    );
  },
  style: TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
  child:  Text(
    "see_all".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.heading(),
                  color: Color.fromARGB(255, 122, 45, 150), // يمكنك تغييره للون الـ Primary حسب رغبتك
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 15),
        
        // 2. القائمة الأفقية للمتاجر
        SizedBox(
          height: 180, // الارتفاع الكلي للكارد
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none, // مهم جداً لكي لا يتم قص الظل (Shadow)
            itemCount: StoreModel.allStores.length,
            itemBuilder: (context, index) {
              return StoreCard(selectedStore: StoreModel.allStores[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15);
            },
          ),
        ),
      ],
    );
  }
}