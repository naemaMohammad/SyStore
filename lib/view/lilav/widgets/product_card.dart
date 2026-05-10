import 'package:flutter/material.dart';
import 'package:user_app/controller/lilav/favorite_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:get/get.dart';
import 'package:user_app/view/lilav/Sreens/product_details.dart';

class ProductCard extends StatelessWidget {
  // 1. المتغيرات المطلوبة لكل منتج
  final String title;
  final String description;
  final String price; // السعر المنسق للعرض (String)
  final double priceValue; // السعر الرقمي للفلترة (double)
  final String imagePath;
  final String colorCount;
  final String category; // الصنف للفلترة
  final String size; // المقاس للفلترة
  final Color productColor; // اللون للفلترة

   ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.priceValue,
    required this.category,
    required this.size,
    required this.productColor,
    this.colorCount = "1",
  });

  // 2. القائمة الثابتة للمنتجات (Static List)
  static List<ProductCard> allProducts = [
     ProductCard(
      title: "Black Jacket",
      description: "High quality winter jacket",
      price: "1,000",
      priceValue: 1000,
      imagePath: "assets/images/p1.jpg",
      category: "Jacket",
      size: "L",
      productColor: Colors.black,
    ),
     ProductCard(
      title: "White T-shirt",
      description: "Cotton 100% - Summer collection",
      price: "1,000",
      priceValue: 1000,
      imagePath: "assets/images/p2.jpg",
      category: "T-shirt",
      size: "M",
      productColor: Colors.white,
    ),
  ];
final FavoriteController favoriteController =
    Get.put(FavoriteController());
  // 3. تصميم الكرت (UI)
  // 3. تصميم الكرت (UI)
  @override
  Widget build(BuildContext context) {
    // نغلف الـ Container بـ GestureDetector لكي يعمل الـ onTap
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: this,
              shopLogo: 'assets/images/MIA.jpg',
            ), // نمرر المنتج الحالي
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.backgroundSecondaryDarkHome
              : AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.25)
                  : Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // القسم العلوي: الصورة
           Expanded(
  child: Stack(
    children: [

      ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),

      Positioned(
        top: 10,
        right: 10,
        child: _buildFavoriteButton(),
      ),

      Positioned(
        top: 10,
        left: 10,
        child: _buildRatingBadge(),
      ),
    ],
  ),
),

            // القسم السفلي: التفاصيل
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.heading(),
                      color: isDark ? AppColors.textDarkHome : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondaryDarkHome
                          : Colors.grey,
                      fontFamily: AppFonts.heading(),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price ${"currency".tr}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2E7D32),
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                      Text(
                        '${colorCount} ${"colors".tr}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.textSecondaryDarkHome
                              : Colors.grey,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFavoriteButton() {

  return Obx(() {

    bool isFav =
        favoriteController.isFavorite(this);

    return GestureDetector(
      onTap: () {
        favoriteController.toggleFavorite(this);
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFav
              ? Icons.favorite
              : Icons.favorite_border,
          color: isFav
              ? Colors.red
              : Colors.black,
          size: 20,
        ),
      ),
    );
  });
}
Widget _buildRatingBadge() {

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 14,
        ),
        SizedBox(width: 3),
        Text(
          "4.8",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
}
