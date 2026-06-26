import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';

class CustomActionDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget
  actionButton; // 👉 Sirf widget pass kar. Dialog ko nahi pata yeh Obx hai ya simple button.

  const CustomActionDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actionButton,
  });

  static void show({
    required BuildContext context,
    required String title,
    required Widget content,
    required Widget actionButton, // 👉 Updated parameter
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: title,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomActionDialog(
          title: title,
          content: content,
          actionButton: actionButton,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // 👉 Sirf SlideTransition rakha hai, Fade uda diya.
        return SlideTransition(
          position: Tween<Offset>(
            // Agar tu chahta hai ke dialog bilkul screen ke end (bottom edge) se
            // nikal kar aaye, toh (0, 0.4) ki jagah (0, 1.0) kar dena.
            begin: const Offset(0, 0.4),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child:
              child, // 👉 FadeTransition ki jagah direct child (tera dialog) laga diya
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.current.card,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title.toUpperCase(),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.current.textPrimary,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(20.r),
                  child: Icon(Icons.close, color: AppTheme.current.icon),
                ),
              ],
            ),

            Divider(color: AppTheme.current.border, height: 15.h),

            // --- 2. DYNAMIC CONTENT ---
            Flexible(child: SingleChildScrollView(child: content)),

            SizedBox(height: 10.h),

            // --- 3. BOTTOM BUTTONS ---
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "CANCEL",
                    color: AppTheme.current.border,
                    textColor: AppTheme.current.textPrimary,
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(width: 8.w),
                // 👉 Yahan tera bheja hua actionButton (Obx) render hoga
                Expanded(child: actionButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
