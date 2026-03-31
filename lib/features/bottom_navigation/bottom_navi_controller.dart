import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class BottomNavigationContoller extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  //
  late int warehouseId;
  late String warehouseName;

  @override
  void onInit() {
    super.onInit();
    final args =
        ModalRoute.of(Get.context!)?.settings.arguments
            as Map<String, dynamic>?;

    if (args != null) {
      warehouseId = args['warehouse_id'];
      warehouseName = args['warehouse_name'];
      print("Warehouse ID Captured: $warehouseId");
    } else {
      print("No arguments found!");
    }
    pageController = PageController(initialPage: currentIndex.value);
  }

  void onChangedPage(int index) {
    currentIndex.value = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
