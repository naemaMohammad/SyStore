import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final IconData icon;

  final bool isSelected;

  final VoidCallback onTap;

  const ThemeButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        width: 42,
        height: 42,

        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context)
                  .secondaryHeaderColor,

          borderRadius:
              BorderRadius.circular(12),
        ),

        child: Icon(
          icon,
          color: isSelected
              ? Colors.white
              : Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color,
        ),
      ),
    );
  }
}