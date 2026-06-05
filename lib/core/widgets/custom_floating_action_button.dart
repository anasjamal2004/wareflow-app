import 'package:flutter/material.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_icon.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    required this.icon,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.blackColor,
      child: CustomIcon(
        icon: icon,
        color: iconColor ?? AppColors.whiteColor,
        size: iconSize,
      ),
    );
  }
}
