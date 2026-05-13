import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BottomNavigationContoller extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  //

  @override
  void onInit() {
    super.onInit();
    print("Page Controller initialized");

    // Yeh jab user ek page se dusre page per jata hai toh jo icon hai usko enable krdeta hai ky user yaha gaya hai.
    pageController.addListener(() {
      // pageController.page yeh decimal(0.0) hota hai .round() laga kr hum ishe integer krte haan.
      int page = pageController.page?.round() ?? 0;
      if (currentIndex.value != page) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          currentIndex.value = page; // ✅ Build ke baad update hoga
        });
      }
    });
  }

  void onChangedPage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    // pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
