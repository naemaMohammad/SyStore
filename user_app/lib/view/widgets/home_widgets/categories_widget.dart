import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/screens/stores/all_stores_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Map<String, String>> categories = [
      {"name": "Girl", "image": "assets/images/Girl.png"},
      {"name": "Boy", "image": "assets/images/Boy.png"},
      {"name": "Men", "image": "assets/images/Men.png"},
      {"name": "Women" , "image": "assets/images/Women.png"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "categories".tr,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.heading(),
            color: isDark
                ? AppColors.textSecondaryDarkHome
                : const Color(0xFF202020),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryItem(
                name: category["name"]!,
                image: category["image"]!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String name;
  final String image;

  const CategoryItem({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),

      onTap: () {
       Get.to(() => AllStoresScreen(initialCategory: widget.name));
      },

      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Column(
          children: [
            Container(
              width: 82,
              height: 72,
              decoration: BoxDecoration(
                color: isDark
                ? const Color.fromARGB(255, 138, 138, 139)
                : const Color(0xFFDEDEDE),
                 shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: isDark
                         ? Colors.black.withOpacity(0.03)
                         : Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Transform.scale(
                  scale: 0.9,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.name.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.heading(),
                color: isDark
              ? AppColors.textDarkHome
              : Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}