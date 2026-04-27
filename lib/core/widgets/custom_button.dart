import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

// AppBar may text ky sath wala button
class CustomNavButton extends StatelessWidget {
  final String text; // String? se String kar diya kyunke text zaroori hai
  final IconData icon; // Icon bhi dynamic rakho
  final VoidCallback
  onTap; // GestureTapCallback ki jagah VoidCallback zyada common hai
  final Color? containerColor;

  const CustomNavButton({
    required this.text,
    required this.onTap,
    required this.icon, // Ab ye reusable hai
    super.key,
    required Color iconColor,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r), // Inkwell effect ke liye
      child: Container(
        height: 40.h, // ScreenUtil use karo responsiveness ke liye
        width: 120.w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        // ListTile hatao, Row lagao
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Vertical center
          children: [
            Icon(LucideIcons.logOut, color: AppColors.whiteColor, size: 18.sp),
            SizedBox(width: 7.w), // Icon aur Text ke beech gap
            CustomText(
              text: text,
              color: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

// Single Button
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final Color? loadingColor;
  final Color? textColor;
  final double? height;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.loadingColor,
    this.height,
    this.width,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? LoadingAnimation(loadingColor: loadingColor)
            : CustomText(
                text: text,
                color: textColor ?? AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
      ),
    );
  }
}
