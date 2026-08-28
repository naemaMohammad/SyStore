import 'package:flutter/material.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/data/data_source/api_constants.dart';

class Cardreviews extends StatelessWidget {
  final String image;
  final String orderId;
  final String customerName;
  final String phone;
  final double rating;
  final bool isSelected;

  const Cardreviews({
    super.key,
    required this.image,
    required this.orderId,
    required this.customerName,
    required this.phone,
    required this.rating,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String imageUrl = ApiConstants.getFullImageUrl(image);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundSecondaryDarkHome : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : isDark
              ? Colors.white12
              : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image.isEmpty
                ? Container(
                    width: 80,
                    height: 80,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Icon(
                      Icons.image,
                      color: isDark ? Colors.white54 : Colors.grey.shade400,
                    ),
                  )
                : Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    cacheWidth: 160,
                    cacheHeight: 160,
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
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderId,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontFamilyFallback: ['Cairo'],
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        customerName,
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        phone,
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
