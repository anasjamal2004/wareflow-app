import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final String buttonText;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? containerColor;
  final VoidCallback onTap;
  const CustomAppBar({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.containerColor,
    this.iconSize,
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
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          CustomNavButton(
            text: buttonText,
            onTap: onTap,
            icon: LucideIcons.logOut,
            iconColor: AppColors.backgroundColor,
            containerColor: containerColor ?? AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
