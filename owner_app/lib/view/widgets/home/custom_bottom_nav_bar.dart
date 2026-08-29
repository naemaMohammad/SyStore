import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

class CustomBottomNavBar extends StatelessWidget {
 CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // The currently selected tab index.
  final int currentIndex;

  // Called when a tab is tapped.
  final ValueChanged<int> onTap;

   final List<_NavItem> _items = [
    _NavItem(
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront,
      label: 'Store'.tr,
    ),
    _NavItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
      label: 'Products'.tr,
    ),
    _NavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long,
      label: 'Orders'.tr,
    ),
    _NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // 1. تحديد ما إذا كان التطبيق في الوضع الداكن أم الفاتح
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // لون خلفية الحاوية بناءً على الثيم
        color: isDark ? AppColors.backgroundSecondaryDarkHome : AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final bool isActive = index == currentIndex;
            return Expanded(
              child: _NavTile(
                item: item,
                isActive: isActive,
                isDark: isDark, // تمرير حالة الثيم للعنصر الفرعي
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // 2. تحديد لون الأيقونة والنص بناءً على التفعيل والوضع الداكن
    final Color activeColor = AppColors.primary;
    final Color inactiveColor = isDark
        ? AppColors.textDarkthemeHome 
        : AppColors.textSecondaryLight;

    final Color color = isActive ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontFamily: AppFonts.body(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}