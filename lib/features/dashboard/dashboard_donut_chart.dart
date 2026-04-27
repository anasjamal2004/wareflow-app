import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_controller.dart';

class DashboardDonutChart extends StatelessWidget {
  final DashboardController getXController = Get.put(DashboardController());

  DashboardDonutChart({super.key});

  // 1. Extended Professional Palette (20+ Colors)
static const List<Color> _colorPalette = [
  Color(0xFF0D47A1), // Marine Blue (Primary)
  Color(0xFFD32F2F), // Red (Alert/Critical)
  Color(0xFF388E3C), // Green (Success/Stable)
  Color(0xFFFBC02D), // Vivid Yellow (Warning/Caution)
  Color(0xFF7B1FA2), // Purple (Elegant)
  Color(0xFF0097A7), // Cyan (Fresh)
  Color(0xFFE64A19), // Deep Orange (Active)
  Color(0xFFC2185B), // Pink (Distinct)
  Color(0xFF1976D2), // Sky Blue (Calm)
  Color(0xFF689F38), // Light Green (Healthy)
  Color(0xFFFFA000), // Amber (Highlight)
  Color(0xFF512DA8), // Deep Purple (Alternative)
  Color(0xFF00796B), // Teal (Professional)
  Color(0xFFAFB42B), // Lime (Energy)
  Color(0xFF5D4037), // Brown (Earth)
  Color(0xFF455A64), // Blue Grey (Neutral)
  Color(0xFF303F9F), // Indigo (Deep)
  Color(0xFFE91E63), // Rose (Flashy)
  Color(0xFF00ACC1), // Bright Cyan (Electric)
  Color(0xFF827717), // Olive (Muted)
  Color(0xFF004D40), // Dark Teal (Strong)
];

  Color getDynamicColor(String categoryName) {
    // 1. Standardizing name (Lowercasing + Trimming)
    String normalizedName = categoryName.trim().toLowerCase();
    
    // 2. Hashcode calculation
    int hash = normalizedName.hashCode;
    
    // 3. Modulo operator (Ab list bari hai toh collisions boht kam hongi)
    int colorIndex = hash.abs() % _colorPalette.length;
    
    return _colorPalette[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 230.h,
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0.w, 0.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Inventory by Category",
            color: AppColors.blackColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1. Chart Section (Left)
                SizedBox(
                  height: 140.h,
                  width: 140.w,
                  child: Obx(() {
                    final isDataEmpty =
                        getXController.dountChartlist.isEmpty ||
                        getXController.dountChartValue.value == 0;

                    final sections = isDataEmpty
                        ? [
                            PieChartSectionData(
                              value: 1,
                              color: Colors.transparent,
                              radius: 18.r,
                              showTitle: false,
                            ),
                          ]
                        : getXController.dountChartlist.map((item) {
                            final total = getXController.dountChartValue.value;
                            final percentage = total > 0
                                ? (item.value / total) * 100
                                : 0.0;
                            return PieChartSectionData(
                              value: percentage,
                              color: getDynamicColor(
                                item.category,
                              ), // Fix: Dynamic color call
                              radius: 18.r,
                              showTitle: false,
                            );
                          }).toList();

                    return PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 50.r,
                        startDegreeOffset: -90, // Animation starts from top
                        sections: sections,
                      ),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeInOutQuart,
                    );
                  }),
                ),

                // 2. Legend Section (Right)
                Flexible(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getXController.dountChartlist.map((item) {
                          final total = getXController.dountChartValue.value;
                          final percentage = total > 0
                              ? (item.value / total) * 100
                              : 0.0;
                          return _buildLegendItem(
                            item.category,
                            percentage.toStringAsFixed(0),
                            getDynamicColor(
                              item.category,
                            ), // Fix: Dynamic color call
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.r,
            height: 15.r,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: CustomText(
              text: title,
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(width: 6.w),
          CustomText(
            text: '$value%',
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
