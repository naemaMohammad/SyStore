import 'package:flutter/material.dart';

class LangButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const LangButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context)
                  .secondaryHeaderColor,

          borderRadius: BorderRadius.circular(12),
        ),

        child: Text(
          title,

          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color,

            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}