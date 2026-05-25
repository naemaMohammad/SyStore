import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;

  const SettingsCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color:
            Theme.of(context)
                .secondaryHeaderColor
                .withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}