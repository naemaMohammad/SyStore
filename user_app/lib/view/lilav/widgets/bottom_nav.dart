import 'package:flutter/material.dart';
import 'package:user_app/core/theme/color.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  
 

  @override
  Widget build(BuildContext context) {

    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 60,
      decoration:  BoxDecoration(
        color: isDark
    ? AppColors.backgroundSecondaryDarkHome
    : AppColors.white,
        border: Border(
          top: BorderSide(
           color: isDark
      ? Colors.white12
      : AppColors.border,
          )
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            activeIcon: Icons.home,
            inactiveIcon: Icons.home_outlined,
          ),
          _buildNavItem(
            context: context,
            index: 1,
            activeIcon: Icons.favorite,
            inactiveIcon: Icons.favorite_border,
          ),
          _buildNavItem(
            context: context,
            index: 2,
            activeIcon: Icons.shopping_bag,
            inactiveIcon: Icons.shopping_bag_outlined,
          ),
          _buildNavItem(
            context: context,
            index: 3,
            activeIcon: Icons.person,
            inactiveIcon: Icons.person_outline,
          ),
        ],
      ),
    );
  }

 Widget _buildNavItem({
  required BuildContext context,
  required int index,
  required IconData activeIcon,
  required IconData inactiveIcon,
}) {
  final isSelected = currentIndex == index;

  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return GestureDetector(
    onTap: () => onTap(index),
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Icon(
        isSelected ? activeIcon : inactiveIcon,
        color: isSelected
            ? (isDark ? Colors.white : Colors.black)
            : const Color(0xFF532564),
        size: 28,
      ),
    ),
  );
}}