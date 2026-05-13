import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navi_controller.dart';
import 'package:warehouse_management_system/features/custom_popup_menu/custom_popup_menu.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard.dart';
import 'package:warehouse_management_system/features/inventory/inventory.dart';
import 'package:warehouse_management_system/features/orders/orders.dart';
import 'package:warehouse_management_system/features/suppliers/suppliers.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late BottomNavigationContoller getXController;
  late List<Widget> _screens;

  final List<String> _screenTitles = [
    'Dashboard Overview',
    'Inventory',
    'Orders',
    'Suppliers',
    // 'Settings',
  ];
  @override
  void initState() {
    super.initState();
    getXController = Get.put(BottomNavigationContoller());
    _screens = [
      Dashboard(),
      Inventory(),
      Orders(), // Will make it one by one
      Suppliers(),
      // Settings(),
    ];
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.layoutDashboard),
      label: "Dashboard",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventory"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: "Suppliers"),
    // BottomNavigationBarItem(
    //   icon: Icon(LucideIcons.settings),
    //   label: "Settings",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparentColor,
        title: Obx(
          () => CustomText(
            text:
                _screenTitles[getXController
                    .currentIndex
                    .value], // Text change hoga swipe per
            color: AppColors.blackColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [CustomPopupMenu()], // Avatar har screen per available hoga
      ),
      body: PageView(
        controller: getXController.pageController,
        children: _screens,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: getXController.currentIndex.value,
          onTap: (index) {
            getXController.onChangedPage(index);
          },
          type: BottomNavigationBarType.fixed,
          // .r icons ke liye scale handle karta hai
          iconSize: 22.r,
          selectedItemColor: AppColors.blackColor,
          // .sp text scaling ke liye
          selectedFontSize: 11.sp,
          unselectedItemColor: AppColors.greyColor,
          unselectedFontSize: 11.sp,
          items: items,
        ),
      ),
    );
  }
}
