import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/dashboard/dashController.dart';
import 'package:owner_app/view/widgets/dash/action_card.dart';
import 'package:owner_app/view/widgets/dash/main_sales_card.dart';
import 'package:owner_app/view/widgets/dash/revenue_bar_chart.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).secondaryHeaderColor;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final secondaryTextColor =
        Theme.of(context).textTheme.bodySmall!.color ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: Text(
          '45'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: const ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: cardColor,

        onRefresh: () async {
          await controller.getDashboardData();
        },

        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(18),

          children: [
            Row(
              children: [
                const Expanded(
                  child: MainCard(),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ActionCard(
                    title: "29".tr,
                    value: controller.newOrders,
                    icon: Icons.shopping_cart_outlined,
                    cardColor: cardColor,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: controller.onNewOrdersPressed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    title: "30".tr,
                    value: controller.totalOrders,
                    icon: Icons.check_circle_outline,
                    cardColor: cardColor,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: controller.onTotalOrdersPressed,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ActionCard(
                    title: "31".tr,
                    value: controller.onTheWay,
                    icon: Icons.local_shipping_outlined,
                    cardColor: cardColor,
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: controller.onOnTheWayPressed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ActionCard(
                  title: "32".tr,
                  value: controller.reviews,
                  icon: Icons.star_border,
                  cardColor: cardColor,
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: controller.onReviewsPressed,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const RevenueChart(),
          ],
        ),
      ),
    );
  }
}