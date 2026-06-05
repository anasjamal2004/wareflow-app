import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/constants/images/app_images.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final String buttonText;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? textColor;
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
    this.textColor,
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
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.transparentColor,
                child: AppImages.appIcon,
              ),
              // SizedBox(width: 3.w),
              CustomText(
                text: text,
                color: AppColors.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomNavButton(
            height: 40.h,
            width: 120.w,
            fontSize: 13.sp,
            text: buttonText,
            onTap: onTap,
            icon: icon,
            textColor: textColor,
            iconColor: iconColor ?? AppColors.whiteColor,
            containerColor: containerColor ?? AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
