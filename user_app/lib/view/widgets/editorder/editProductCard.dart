import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EditProductCard extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final String size;
  final String color;

  const EditProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ✅ الصورة
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: Icon(
                  Icons.image_not_supported,
                  color: isDark ? Colors.white54 : Colors.black26,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم المنتج
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${'30'.tr}: $price ${'currency'.tr}",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),

                Text(
                  "${"31".tr}: $size",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),

                
                Text(
                  "${"32".tr}: $color",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
