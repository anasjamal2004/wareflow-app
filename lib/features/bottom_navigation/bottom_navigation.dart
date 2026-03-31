import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navi_controller.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard.dart';
import 'package:warehouse_management_system/features/inventory/inventory.dart';
import 'package:warehouse_management_system/features/orders/orders.dart';
import 'package:warehouse_management_system/features/settings/settings.dart';
import 'package:warehouse_management_system/features/suppliers/suppliers.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final BottomNavigationContoller getXController = Get.put(
    BottomNavigationContoller(),
  );

  final List<Widget> _screens = [
    Dashboard(),
    Inventory(),
    Orders(),
    Suppliers(),
    Settings(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventory"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: "Suppliers"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: getXController.pageController,
        onPageChanged: (index) {
          getXController.currentIndex.value = index;
        },
        children: _screens,
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: getXController.currentIndex.value,
            onTap: (index) {
              getXController.onChangedPage(index);
            },
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            selectedItemColor: AppColors.blackColor,
            selectedFontSize: 13,
            unselectedItemColor: AppColors.greyColor,
            unselectedFontSize: 13,
            items: items,
          ),
        ),
      ),
    );
  }
}
