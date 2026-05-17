import 'package:flutter/material.dart';

class SettingsIconBox extends StatelessWidget {
  final IconData icon;

  const SettingsIconBox({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),

      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,

        borderRadius:
            BorderRadius.circular(8),
      ),

      child: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}