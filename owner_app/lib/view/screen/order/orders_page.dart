import 'package:flutter/material.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';


class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 56,
            color: AppColors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            'Orders — Coming soon',
            style: TextStyle(
              color: AppColors.textSecondaryLight,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.body(),
            ),
          ),
        ],
      ),
    );
  }
}
