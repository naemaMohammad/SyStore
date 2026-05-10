import 'package:flutter/material.dart';
import 'package:user_app/controller/lilav/product_detailed_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:get/get.dart';
import 'package:user_app/view/lilav/Sreens/detailed_filter_page.dart';
import 'package:user_app/controller/lilav/favorite_controller.dart';
import '../widgets/product_card.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductCard product;
  final String shopLogo;
  final ProductDetailsController controller = Get.put(
    ProductDetailsController(),
  );

  final FavoriteController favoriteController = Get.put(FavoriteController());

  ProductDetailsPage({
    super.key,
    required this.product,
    required this.shopLogo,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Theme.of(
              context,
            ).scaffoldBackgroundColor, // استخدم لون الخلفية من الثيم
      // ألغينا الـ AppBar التقليدي لنرسم فوق الصورة
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- قسم الصورة مع العناصر العائمة (Stack) ---
            Stack(
              children: [
                // صورة المنتج الرئيسية
                Container(
                  height: 480, // زيادة الارتفاع ليتناسب مع الفيجما
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(product.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // زر الإغلاق (X) في أعلى اليسار
                // Positioned(
                //   top: 50,
                //   left: 20,
                //   child: GestureDetector(
                //     onTap: () => Navigator.pop(context),
                //     child: Container(
                //       padding: const EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.8),
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(
                //         Icons.close,
                //         color: Colors.black,
                //         size: 20,
                //       ),
                //     ),
                //   ),
                // ),
                // لوغو المحل (الدائرة الوردية) في أعلى اليسار تحت زر الإغلاق أو بجانبه
                Positioned(
                  top: 40, // وضعناه تحت زر الإغلاق كما يظهر في توزيع الفيجما
                  left: 6,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 1),
                      ],
                      image: DecorationImage(
                        // هنا يجلب اللوغو الخاص بالمحل الممرر للصفحة
                        image: AssetImage(shopLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // زر المفضلة (القلب) في أعلى اليمين فوق الصورة
                Positioned(
                  top: 40,
                  right: 6,
                  child: Obx(() {
                    bool isFav = favoriteController.isFavorite(product);

                    return GestureDetector(
                      onTap: () {
                        favoriteController.toggleFavorite(product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 97, 97, 97),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? AppColors.primary : Colors.black,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),
                Positioned.fill(
                  child:IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          isDark
                              ? const Color(0xFF1E1E1E).withOpacity(0.5)
                              : Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم والسعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                      Text(
                        "${product.price} \$",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.price,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // الوصف
                  Text(
                    "description".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "material_cotton".tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                  const Divider(height: 30),

                  // اختيار المقاس (تفاعلي الآن)
                  Text(
                    "select_size".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Row(
                      children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                        bool isSelected = controller.selectedSize.value == size;
                        return GestureDetector(
                          onTap: () {
                            controller.changeSize(size);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark
                                        ? const Color(
                                            0xFF532564,
                                          ).withOpacity(0.3)
                                        : const Color(0xFFF3E5F5))
                                  : (isDark ? Colors.grey[850] : Colors.white),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF532564)
                                    : (isDark
                                          ? Colors.grey[700]!
                                          : Colors.grey.shade300),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? (isDark
                                          ? Colors.white
                                          : const Color(0xFF532564))
                                    : (isDark ? Colors.white70 : Colors.black),
                                fontFamily: AppFonts.heading(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // اختيار الألوان (تفاعلي الآن)
                  Text(
                    "select_color".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.heading(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 45,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Obx(
                        () => Row(
                          children: DetailedFilterPage.availableColors.map((
                            color,
                          ) {
                            bool isSelected =
                                controller.selectedColor.value == color;
                            return GestureDetector(
                              onTap: () {
                                controller.changeColor(color);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF532564)
                                        : Colors.grey.shade300,
                                    width: isSelected ? 3 : 1,
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      ),
                                  ],
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // قسم الكمية
                  Row(
                    children: [
                      Text(
                        "quantity".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                          fontFamily: AppFonts.heading(),
                        ),
                      ),

                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => controller.decreaseQuantity(),
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${controller.quantity.value}", // عرض الكمية من الكنترولر
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.increaseQuantity(),
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF532564),
                  elevation: Theme.of(context).brightness == Brightness.dark
                      ? 0
                      : 2,

                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "add_to_cart".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: AppFonts.heading(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : Colors.white,
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : const Color(0xFF532564),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "buy_now".tr,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color(0xFF532564),
                    fontSize: 18,
                    fontFamily: AppFonts.heading(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
