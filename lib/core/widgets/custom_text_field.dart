import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_icon.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final GestureTapCallback? onPressed;
  final bool readOnly;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.obscureText,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.onPressed,
    this.readOnly = false,
    this.onChanged,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        readOnly: readOnly,
        obscureText: obscureText ?? false,
        enableInteractiveSelection: !readOnly,
        focusNode: readOnly ? FocusNode(canRequestFocus: false) : null,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          filled: true,
          fillColor: AppTheme.greyColor,
          //
          suffixIcon: CustomIcon(
            icon: suffixIcon,
            size: suffixIconSize,
            color: suffixIconColor,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
