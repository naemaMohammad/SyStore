import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final String title;

  final Widget? trailingWidget;

  final VoidCallback? onTap;

  const SettingsListItem({
    super.key,
    required this.title,
    this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical: 14,
        ),

        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
              ),
            ),

            if (trailingWidget != null)
              trailingWidget!,
          ],
        ),
      ),
    );
  }
}