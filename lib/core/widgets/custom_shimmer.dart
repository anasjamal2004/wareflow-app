import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';

class CustomShimmer {
  // Yeh generic box hai jo shimmer effect deta hai
  static Widget rectangular({
    required double height,
    double width = double.infinity,
    double borderRadius = 16.0,
  }) {
    return Shimmer.fromColors(
      baseColor: AppTheme.current.card,
      highlightColor: AppTheme.current.border,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppTheme.current.card,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }

  // Yeh tera poora Dashboard ka Skeleton hai.
  // Isme uper wale 4 boxes bhi hain, aur neeche wale dono charts ke containers bhi.
  static Widget dashboardSkeleton() {
    return Column(
      children: [
        // Top 2 metrics
        Row(
          children: [
            Expanded(child: rectangular(height: 110.h)),
            SizedBox(width: 12.w),
            Expanded(child: rectangular(height: 110.h)),
          ],
        ),
        SizedBox(height: 12.h),
        // Bottom 2 metrics
        Row(
          children: [
            Expanded(child: rectangular(height: 110.h)),
            SizedBox(width: 12.w),
            Expanded(child: rectangular(height: 110.h)),
          ],
        ),
        SizedBox(height: 15.h),

        // 1. LINE CHART SHIMMER CONTAINER (Exact 250.h match kiya tere LineChart se)
        rectangular(height: 250.h),

        SizedBox(height: 15.h),

        // 2. DONUT CHART SHIMMER CONTAINER (Exact 230.h match kiya tere DonutChart se)
        // BorderRadius 20.r diya kyunke tere original dount chart widget mein 20.r hai
        rectangular(height: 230.h, borderRadius: 20.0),

        SizedBox(height: 5.h),
      ],
    );
  }
}
