import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart'; // 👈 ScreenUtil Import

class CustomToggleTab extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final IconData leftIcon;
  final IconData rightIcon;
  final int selectedIndex;
  final Function(int) onChanged;

  const CustomToggleTab({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftIcon,
    required this.rightIcon,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 55.h, // 👈 Height responsive
        padding: EdgeInsets.all(4.r), // 👈 Padding responsive radius ke sath
        decoration: BoxDecoration(
          color: AppTheme.current.card,
          borderRadius: BorderRadius.circular(16.r), // 👈 Radius responsive
          border: Border.all(
            color: AppTheme.current.border,
            width: 1.w,
          ), // 👈 Border thickness responsive
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTab(0, leftLabel, leftIcon),
            SizedBox(width: 3.w),
            _buildTab(1, rightLabel, rightIcon),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title, IconData icon) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.current.button
                : AppTheme.transparentColor,
            borderRadius: BorderRadius.circular(12.r), // 👈 Inner pill radius
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18.sp, // 👈 Icon size scaling with font size
                  color: isSelected
                      ? AppTheme.whiteColor
                      : AppTheme.current.icon,
                ),
                SizedBox(width: 8.w), // 👈 Gap between icon and text
                CustomText(
                  text: title,
                  fontSize: 14.sp,
                  color: isSelected
                      ? AppTheme.whiteColor
                      : AppTheme.current.textPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
