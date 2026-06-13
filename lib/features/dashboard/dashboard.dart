import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_shimmer.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_controller.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_donut_chart.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_line_chart.dart';

class Dashboard extends StatelessWidget {
  final DashboardController getXController = Get.put(DashboardController());
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: AppColors.backgroundColor,
      //   surfaceTintColor: AppColors.transparentColor,
      //   title: CustomText(
      //     text: 'Dashboard Overview',
      //     color: AppColors.blackColor,
      //     fontSize: 24.sp,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   actions: [CustomPopupMenu()], // Custom Menu hai.
      // ),
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: RefreshIndicator(
            onRefresh: () async {
              await getXController.dashboardData();
            },
            color: AppTheme.current.loadingColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(() {
                if (getXController.isLoading.value == true) {
                  return CustomShimmer.dashboardSkeleton();
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: customContainer(
                            headingText: 'Total Revenue',
                            data: '\$${getXController.totalRevenueData}',
                            icon: LucideIcons.trendingUp,
                          ),
                        ),

                        SizedBox(width: 12.w), // Beech ka gap responsive kiya
                        Expanded(
                          child: customContainer(
                            headingText: 'Inventory Value',
                            data: '\$${getXController.inventoryValueData}',
                            icon: LucideIcons.package,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: customContainer(
                            headingText: 'Completed Orders',
                            data: getXController.completedOrdersData.toString(),
                            icon: Icons.done_all_rounded,
                          ),
                        ),

                        SizedBox(width: 12.w),
                        Expanded(
                          child: customContainer(
                            headingText: 'Active Suppliers',
                            data: getXController.activeSupplierData.toString(),
                            icon: LucideIcons.users,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    DashboardLineChart(),
                    SizedBox(height: 15.h),
                    DashboardDonutChart(),
                    //
                    SizedBox(height: 5.h),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainer({
    required String headingText,
    required String data,
    required IconData icon,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 110.h, // Height thori optimize ki taake text overflow na kare
      decoration: BoxDecoration(
        color: AppTheme.current.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  // Taake text icon ke upar na charhay
                  child: CustomText(
                    text: headingText,
                    color: AppTheme.current.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
                Container(
                  height: 27.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: AppTheme.current.card,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: AppTheme.current.icon, size: 20.r),
                ),
              ],
            ),
          ),
          const Spacer(), // Content ko balance karne ke liye
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
            child: FittedBox(
              // Agar value bari ho jaye toh text size khud chota ho jaye
              fit: BoxFit.scaleDown,
              child: CustomText(
                text: data,
                color: AppTheme.current.textPrimary,
                fontSize: 30.sp, // Thora sa base size kam kiya
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
