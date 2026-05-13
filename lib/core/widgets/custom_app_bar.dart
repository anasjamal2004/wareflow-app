import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final String buttonText;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? containerColor;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  const CustomAppBar({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
    required this.icon,
    this.iconColor,
    this.containerColor,
    this.iconSize,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
            color: AppColors.blackColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
          CustomNavButton(
            height: 40.h,
            width: 120.w,
            fontSize: 13.sp,
            text: buttonText,
            onTap: onTap,
            icon: icon,
            iconColor: iconColor ?? AppColors.whiteColor,
            containerColor: containerColor ?? AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
