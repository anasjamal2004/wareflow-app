import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navi_controller.dart';
import 'package:warehouse_management_system/features/custom_popup_menu/custom_popup_menu.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard.dart';
import 'package:warehouse_management_system/features/inventory/screens/inventory.dart';
import 'package:warehouse_management_system/features/orders/screens/orders.dart';
import 'package:warehouse_management_system/features/suppliers/screens/suppliers.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Binding se controller mil jayega, put karne ki zaroorat nahi
    final BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );

    final List<String> screenTitles = [
      'Dashboard Overview',
      'Inventory',
      'Orders',
      'Suppliers',
    ];
    final List<Widget> screens = [
      Dashboard(),
      Inventory(),
      Orders(),
      Suppliers(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.current.appBar,
        title: Obx(
          () => CustomText(
            text: screenTitles[controller.currentIndex.value],
            color: AppTheme.current.textPrimary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [CustomPopupMenu()],
      ),
      body: PageView(controller: controller.pageController, children: screens),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.onChangedPage(index),
          type: BottomNavigationBarType.fixed,
          iconSize: 22.r,
          selectedItemColor: AppTheme.current.navSelected,
          unselectedItemColor: AppTheme.current.navUnselected,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.layoutDashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: "Inventory",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Suppliers",
            ),
          ],
        ),
      ),
    );
  }
}
