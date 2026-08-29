import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/screens/filter/detailed_filter_page.dart';

class StoreFilters extends StatefulWidget {
  final Function(int? categoryId) onCategoryChanged;
  final Function(Map<String, dynamic>) onFilterApplied;
  final Function(bool) onPriceSortChanged;


  final int storeId;

  const StoreFilters({
    super.key,
    required this.storeId,
    required this.onCategoryChanged,
    required this.onPriceSortChanged,
    required this.onFilterApplied,
  });

  @override
  State<StoreFilters> createState() => _StoreFiltersState();
}

class _StoreFiltersState extends State<StoreFilters> {
  String selectedCategoryLabel = 'category_label'.tr;

  final List<Map<String, dynamic>> categoriesList = [
    {'id': null, 'label': 'all'.tr},
    {'id': 1, 'label': 'Men'.tr},
    {'id': 2, 'label': 'Women'.tr},
    {'id': 3, 'label': 'Boy'.tr},
    {'id': 4, 'label': 'Girl'.tr},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 1. Category Dropdown
          PopupMenuButton<Map<String, dynamic>>(
            onSelected: (Map<String, dynamic> item) {
              setState(() {
                selectedCategoryLabel = item['label'];
              });
              widget.onCategoryChanged(item['id'] as int?);
            },
            itemBuilder: (context) => categoriesList
                .map(
                  (cat) => PopupMenuItem<Map<String, dynamic>>(
                    value: cat,
                    child: Text(
                      cat['label'],
                      style: TextStyle(
                        fontFamily: AppFonts.body(),
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                )
                .toList(),
            child: _Chip(
              label: selectedCategoryLabel,
              icon: Icons.arrow_drop_down_outlined,
            ),
          ),

          const SizedBox(width: 8),

          // 2. Price Sorting
          PopupMenuButton<bool>(
            onSelected: (bool isHighToLow) {
              widget.onPriceSortChanged(isHighToLow);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: true,
                child: Text(
                  'High_to_Low'.tr,
                  style: TextStyle(fontFamily: AppFonts.body()),
                ),
              ),
              PopupMenuItem(
                value: false,
                child: Text(
                  'Low_to_High'.tr,
                  style: TextStyle(fontFamily: AppFonts.body()),
                ),
              ),
            ],
            child: _Chip(label: 'price'.tr, icon: Icons.swap_vert),
          ),

          const SizedBox(width: 8),

          // 3. Filter
          GestureDetector(
            onTap: () async {
            
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedFilterPage(
                    storeId: widget.storeId,
                    initialCategory: "All",
                    initialPrice: 1000,
                  ),
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                widget.onFilterApplied(result);
              }
            },
            child: _Chip(label: 'Filter'.tr, icon: Icons.tune),
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundSecondaryDarkHome
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.body(),
              fontSize: 14,
              color: isDark ? AppColors.textDarkHome : Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            icon,
            size: 20,
            color: isDark
                ? AppColors.textSecondaryDarkHome
                : Colors.black54,
          ),
        ],
      ),
    );
  }
}