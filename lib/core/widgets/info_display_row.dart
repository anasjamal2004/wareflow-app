import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class InfoDisplayRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoDisplayRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ), // Responsive vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: label,
                // Logic Flaw: Yahan 'alpha: 2' likha hai, neeche explain kiya hai.
                color: AppColors.greyColor.withValues(alpha: 0.5),
                fontSize: 16.sp, // Responsive font
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: value,
                color: AppColors.blackColor,
                fontSize: 16.sp, // Responsive font
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.greyColor.withValues(alpha: 0.2),
          thickness: 1.h, // Responsive thickness
        ),
      ],
    );
  }
}
