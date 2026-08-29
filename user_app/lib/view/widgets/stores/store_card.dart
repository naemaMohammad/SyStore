import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/model/store_model.dart';
import 'package:user_app/view/screens/stores/store_page.dart';

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
    behavior: HitTestBehavior.opaque,
    onTap: () {
     
        Get.to(() => StorePage(store: selectedStore));
      },
      child: Container(
        width: 155.5,
        height: 180,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2C2C2C)
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

              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                 color: isDark ? Colors.grey[300] : Colors.white,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          selectedStore.logoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.store, size: 40, color: Colors.black26),
                        ),
                      ),
                     Positioned(
  top: 8,
  right: 8,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.75),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          ((selectedStore.ratingValue ).toDouble())
              .toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Tajawal'],
          ),
        ),
      ],
    ),
  ),
),
                    ],
                  ),
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      selectedStore.storeName ?? '',
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
                      "${'category_label'.tr} : ${_getFormattedCategories(selectedStore.categories)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.heading(),
                        color: isDark
                            ? Colors.white54 
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
  String _getFormattedCategories(List<StoreCategoryModel>? categories) {
  if (categories == null || categories.isEmpty) return '';
  return categories
      .map((cat) => cat.type ?? '')
      .where((type) => type.isNotEmpty)
      .join(', '); 
}
}