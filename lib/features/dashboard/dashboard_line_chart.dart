import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_controller.dart';

class DashboardLineChart extends StatelessWidget {
  final DashboardController getXController = Get.put(DashboardController());

  DashboardLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 5.h),
            child: CustomText(
              text: "Revenue Trend",
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 15.w, bottom: 5.h),
              child: Obx(() {
                // FIX: Loader nikal diya taake chart tree mein hamesha rahay
                final bool isEmpty =
                    getXController.chartValues.isEmpty ||
                    getXController.chartLabels.isEmpty;

                // Max Y calculation with safety
                double maxVal = isEmpty
                    ? 100
                    : getXController.chartValues
                          .reduce((a, b) => a > b ? a : b)
                          .toDouble();
                if (maxVal == 0) maxVal = 100; // Safety for 0 values
                double dynamicMaxY = maxVal + (maxVal * 0.2);
                double dynamicInterval = dynamicMaxY / 5;

                return LineChart(
                  LineChartData(
                    minX: 0,
                    // Empty state mein dummy range (0-4) dikhayega
                    maxX: isEmpty
                        ? 4
                        : (getXController.chartLabels.length - 1).toDouble(),
                    minY: 0,
                    maxY: dynamicMaxY,
                    lineTouchData: LineTouchData(
                      enabled: !isEmpty, // Empty state mein touch off
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (touchedSpot) => AppColors.blackColor,
                        tooltipBorderRadius: BorderRadius.circular(8.r),
                        getTooltipItems: (spots) {
                          return spots.map((spot) {
                            return LineTooltipItem(
                              'Rs. ${spot.y.toInt()}',
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: dynamicInterval > 0
                          ? dynamicInterval
                          : 20,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.1),
                        strokeWidth: 1.r,
                        dashArray: [5, 5],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: dynamicInterval > 0 ? dynamicInterval : 20,
                          reservedSize: 32.w,
                          getTitlesWidget: (value, meta) {
                            String textValue = value >= 1000
                                ? '${(value / 1000).toStringAsFixed(1)}k'
                                : value.toInt().toString();
                            return SideTitleWidget(
                              meta: meta,
                              space: 5.w,
                              child: CustomText(
                                text: textValue,
                                fontSize: 9.sp,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            if (isEmpty)
                              return const SizedBox(); // Empty state mein labels nahi
                            var months = getXController.chartLabels;
                            if (value.toInt() >= 0 &&
                                value.toInt() < months.length) {
                              return SideTitleWidget(
                                meta: meta,
                                space: 8.h,
                                child: CustomText(
                                  text: months[value.toInt()],
                                  fontSize: 8.sp,
                                  color: Colors.grey,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        // FIX: Agar empty hai toh 0 ki flat line, warna actual spots
                        spots: isEmpty
                            ? [
                                const FlSpot(0, 0),
                                const FlSpot(1, 0),
                                const FlSpot(2, 0),
                                const FlSpot(3, 0),
                                const FlSpot(4, 0),
                              ]
                            : getXController.chartValues.asMap().entries.map((
                                entry,
                              ) {
                                return FlSpot(
                                  entry.key.toDouble(),
                                  entry.value.toDouble(),
                                );
                              }).toList(),
                        isCurved: true,
                        curveSmoothness: 0.35,
                        color: const Color(0xFF1A1C1E),
                        barWidth: 3.r,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: !isEmpty, // Empty state mein dots hide karo
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                                radius: 2.5.r,
                                color: const Color(0xFF1A1C1E),
                                strokeWidth: 1.r,
                                strokeColor: Colors.white,
                              ),
                        ),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOutExpo,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
