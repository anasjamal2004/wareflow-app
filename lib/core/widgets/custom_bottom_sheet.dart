import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_icon.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomActionSheet {
  static void show({
    required BuildContext context,
    required String title,
    required VoidCallback onUpdate,
    required VoidCallback onDelete,
    required RxBool isLoading,
  }) {
    Get.bottomSheet(
      ActionSheetContent(
        title: title,
        onUpdate: onUpdate,
        onDelete: onDelete,
        isLoading: isLoading,
      ),
      backgroundColor: AppColors.whiteColor,
      isScrollControlled: true,
      ignoreSafeArea: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
    );
  }
}

class ActionSheetContent extends StatelessWidget {
  final String title;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final RxBool isLoading;

  const ActionSheetContent({
    super.key,
    required this.title,
    required this.onUpdate,
    required this.onDelete,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // 🚀 LOGIC: SafeArea yahan wrap kiya hai. Yeh directly Android OS se tere
    // physical phone ke bottom nav bar ki height lay ga aur usko overlap hone se rokega.
    return SafeArea(
      bottom: true,
      top: false,
      child: Padding(
        // 🚀 LOGIC: Ab sirf internal spacing di hai, koi hardcoded bottom gap nahi.
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),
            CustomText(
              text: title,
              color: AppColors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            const Divider(),
            SizedBox(height: 5.h),
            ListTile(
              leading: Container(
                height: 40.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.greenColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const CustomIcon(
                  icon: LucideIcons.edit,
                  color: AppColors.greenColor,
                  size: 25,
                ),
              ),
              title: const CustomText(
                text: "Update",
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
              onTap: () {
                Get.back();
                onUpdate();
              },
            ),
            const Divider(),
            ListTile(
              leading: Container(
                height: 40.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.redColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const CustomIcon(
                  icon: Icons.delete_forever,
                  color: AppColors.redColor,
                  size: 30,
                ),
              ),
              title: const CustomText(
                text: "Delete",
                color: AppColors.redColor,
                fontWeight: FontWeight.w700,
              ),
              onTap: () {
                Get.back();
                _showConfirmDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        title: CustomText(
          text: "Confirm Delete",
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
          text: "Are you sure you want to delete $title?",
          color: AppColors.greyColor,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    color: Colors.grey[200],
                    textColor: AppColors.blackColor,
                    onPressed: isLoading.value ? () {} : () => Get.back(),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomButton(
                    text: "Delete",
                    color: AppColors.redColor,
                    isLoading: isLoading.value,
                    onPressed: isLoading.value ? () {} : onDelete,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
