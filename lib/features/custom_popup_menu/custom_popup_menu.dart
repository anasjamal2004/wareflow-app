import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/constants/images/app_images.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navi_controller.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard_controller.dart';
import 'package:warehouse_management_system/features/start_screen/auth_screen/auth_controller/auth_controller.dart';
import 'package:warehouse_management_system/features/start_screen/select_warehouse/select_warehouse.dart';

class CustomPopupMenu extends StatelessWidget {
  final AuthController getXAuthController = Get.put(AuthController());
  final DashboardController getXController = Get.find<DashboardController>();
  CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      // 1. Menu ki styling (Corners round karne ke liye)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      offset: Offset(0, 60.h), // Menu thora neeche show hoga
      elevation: 8,

      // 2. Wo Avatar jis par click hoga
      icon: CircleAvatar(
        radius: 25.r,
        backgroundColor: AppColors.whiteColor,
        child: AppImages.appIcon,
      ),

      onSelected: (value) async {
        if (value == 1) {
          await Get.delete<BottomNavigationContoller>(force: true);
          await Get.delete<DashboardController>(force: true);
          GetAppStorage.deleteWarehouseData();
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight, // Professional animation
              child: SelectWarehouse(),
              duration: const Duration(milliseconds: 500),
            ),
          );
        } else if (value == 2) {
          print('Logout is tap');
          getXAuthController.logOut(context);
        }
      },

      itemBuilder: (context) => [
        // === Section 1: User Profile ===
        // PopupMenuItem(
        //   enabled: false, // Is par click nahi hona chahiye
        //   child: ListTile(
        //     contentPadding: EdgeInsets.zero,
        //     leading: CircleAvatar(child: Text("AK")),
        //     title: CustomText(
        //       text: "Ali Khan",
        //       fontWeight: FontWeight.bold,
        //       color: AppColors.blackColor,
        //       fontSize: 18.sp,
        //     ),
        //     subtitle: CustomText(
        //       text: "ali@warehouse.com",
        //       fontSize: 12.sp,
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),
        // const PopupMenuDivider(),

        // === Section 2: Active Warehouse ===
        PopupMenuItem(
          value: 1,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.factory_outlined, color: Colors.blue),
            ),
            title: CustomText(
              text: "Active Warehouse",
              fontSize: 11.sp,
              color: Colors.grey,
            ),
            subtitle: CustomText(
              text: getXController.warehouseName,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              fontSize: 18.sp,
            ),
          ),
        ),
        const PopupMenuDivider(),

        // === Section 3: Logout ===
        PopupMenuItem(
          value: 2,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.logout, color: Colors.red),
            ),
            title: CustomText(
              text: "Logout",
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
