import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BottomNavigationContoller extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  //

  @override
  void onInit() {
    super.onInit();
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
