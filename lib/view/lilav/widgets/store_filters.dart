import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/view/lilav/Sreens/detailed_filter_page.dart';
import 'package:user_app/view/lilav/widgets/product_card.dart'; // مهم جداً

class StoreFilters extends StatefulWidget {
  final Function(String?) onCategoryChanged;
  // تعديل الباراميتر هنا ليستقبل القائمة المفلترة الجاهزة
  final Function(List<ProductCard>) onFilterApplied; 
  final Function(bool) onPriceSortChanged;

  const StoreFilters({
    super.key,
    required this.onCategoryChanged,
    required this.onPriceSortChanged,
    required this.onFilterApplied,
  });

  @override
  State<StoreFilters> createState() => _StoreFiltersState();
}

class _StoreFiltersState extends State<StoreFilters> {
  String selectedCategory = 'category_label'.tr; // القيمة الافتراضية (كل الأقسام)

  @override
  Widget build(BuildContext context) {

  

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 1. Category Dropdown
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() => selectedCategory = value);
              widget.onCategoryChanged(value == 'all'.tr ? null : value);
            },
            itemBuilder: (context) => ['all'.tr, 'Women'.tr, 'Men'.tr, 'Girl'.tr, 'Boy'.tr]
                .map((cat) => PopupMenuItem(value: cat, child: Text(cat)))
                .toList(),
            child: _Chip(label: selectedCategory, icon: Icons.arrow_drop_down_outlined),
          ),
          
          const SizedBox(width: 8),

          // 2. Price Sorting
          PopupMenuButton<bool>(
            onSelected: (bool isHighToLow) {
              widget.onPriceSortChanged(isHighToLow);
            },
            itemBuilder: (context) => [
               PopupMenuItem(value: true, child: Text('High_to_Low'.tr)),
               PopupMenuItem(value: false, child: Text('Low_to_High'.tr)),
            ],
            child:  _Chip(label: 'price'.tr, icon: Icons.swap_vert),
          ),

          const SizedBox(width: 8),

          // 3. Filter (الذهاب لصفحة الفلترة التفصيلية)
          GestureDetector(
            onTap: () async {
              // ننتظر النتيجة التي هي عبارة عن List<ProductCard>
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedFilterPage(
                    initialCategory: "All", 
                    initialPrice: 1000,
                  ),
                ),
              );

              // التحقق من أن النتيجة هي قائمة منتجات
              if (result != null && result is List<ProductCard>) {
                // نمرر القائمة الجاهزة لصفحة المتجر لتحديث الواجهة
                widget.onFilterApplied(result);
              }
            },
            child:  _Chip(label: 'Filter'.tr, icon: Icons.tune),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Chip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {

      final bool isDark =
    Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
       color: isDark
    ? AppColors.backgroundSecondaryDarkHome
    : Colors.white, // تأكدي من تعريف AppColors أو استخدمي Colors.white
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
  color: isDark
      ? Colors.white12
      : Colors.grey.shade300,
),),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(
            fontSize: 14,
             color: isDark
        ? AppColors.textDarkHome
        : Colors.black,
  ),
),
           SizedBox(width: 4),
          Icon(icon, size: 20,color: isDark
    ? AppColors.textSecondaryDarkHome
    : Colors.black54),
        ],
      ),
    );
  }
}