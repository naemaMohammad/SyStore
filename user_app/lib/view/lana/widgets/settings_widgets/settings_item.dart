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
            const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(5.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color,
                  ),
                ),
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