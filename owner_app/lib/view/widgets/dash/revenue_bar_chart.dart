import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/dashboard/dashController.dart';

class RevenueChart extends GetView<DashboardController> {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    final secondaryTextColor =
        Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() {
        // إيجاد أكبر قيمة موجودة بالمبيعات الأسبوعية
        final maxRevenue = controller.weeklyRevenue.isEmpty
            ? 0.0
            : controller.weeklyRevenue.reduce((a, b) => a > b ? a : b);

        // تحديد maxY بحيث يكون مناسب للـ interval = 50
        final double maxY = maxRevenue <= 0
            ? 300.0
            : (((maxRevenue / 50).ceil() * 50) + 50).toDouble();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "34".tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor,
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  maxY: maxY,

                  alignment: BarChartAlignment.spaceAround,

                  borderData: FlBorderData(show: false),

                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 50,

                    getDrawingHorizontalLine: (v) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),

                    getDrawingVerticalLine: (v) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 50,
                        reservedSize: 30,

                        getTitlesWidget: (v, meta) => Text(
                          v.toInt().toString(),
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (v, meta) {
                          final index = v.toInt();

                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              index < controller.weekDays.length
                                  ? controller.weekDays[index]
                                  : "",
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 12,
                                fontFamily: 'NunitoSans',
                                fontFamilyFallback: ['Tajawal'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  barGroups: List.generate(
                    controller.weeklyRevenue.length,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: controller.weeklyRevenue[i],
                          width: 15,
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
