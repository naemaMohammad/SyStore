import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/data/data_source/api_constants.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String size;
  final String color;
  final bool isSelected;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String imageUrl = ApiConstants.getFullImageUrl(image);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundSecondaryDarkHome : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : Border.all(
                color: isDark
                    ? Colors.white12
                    : Theme.of(context).dividerColor.withOpacity(0.3),
                width: 0.5,
              ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image.isEmpty || imageUrl.isEmpty
                ? Container(
                    width: 80,
                    height: 80,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Icon(
                      Icons.image,
                      color: isDark ? Colors.white54 : Colors.grey.shade400,
                      size: 30,
                    ),
                  )
                : Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    cacheWidth: 160,
                    cacheHeight: 160,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 80,
                        height: 80,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        child: Icon(
                          Icons.broken_image,
                          color: isDark ? Colors.white54 : Colors.grey.shade400,
                          size: 30,
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$price SYP",
                  style: TextStyle(
                    color: AppColors.price,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${'27'.tr} $size",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  "${'28'.tr} $color",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
