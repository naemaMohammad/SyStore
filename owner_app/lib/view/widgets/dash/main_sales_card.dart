import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/dashboard/dashController.dart';

class MainCard extends GetView<DashboardController> {
  const MainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "33".tr,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    controller.totalSales.value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
