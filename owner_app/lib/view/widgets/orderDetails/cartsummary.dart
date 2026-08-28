import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/core/theme/color.dart';

class CartSummary extends StatelessWidget {
  final String subtotal;
  final String deliveryFee;
  final String total;

  const CartSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundSecondaryDarkHome : AppColors.white,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row(context, "4".tr, "$subtotal SYP", isDark),
          const SizedBox(height: 8),
          _row(context, "3".tr, "$deliveryFee SYP", isDark),
          Divider(
            height: 20,
            color: isDark ? Colors.white12 : Colors.grey.shade300,
          ),
          _row(context, "2".tr, "$total SYP", isDark, isBold: true),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String title,
    String value,
    bool isDark, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title :",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: isBold ? 'Raleway' : 'NunitoSans',
            fontFamilyFallback: isBold ? ['Cairo'] : ['Tajawal'],
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: isBold ? 'Raleway' : 'NunitoSans',
            fontFamilyFallback: isBold ? ['Cairo'] : ['Tajawal'],
            color: isBold
                ? AppColors.price
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
