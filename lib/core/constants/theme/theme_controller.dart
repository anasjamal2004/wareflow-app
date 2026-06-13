import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage(); // Starting may null
  final _key = 'isDarkMode'; // GetStorage ki key

  bool get currentMode => _box.read(_key) ?? false;

  ThemeMode get themeMode {
    // Ager ko CurrentMode false hai toh light mode warna dark mode
    if (currentMode == true) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  void toggleTheme() {
    // Ager ko app phele se light mode per hai toh: Current mode = false -> Light Mode
    // User Toggle -> Current mode = false: light mode -> true: dark mode
    if (currentMode == false) {
      _box.write(_key, true);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      _box.write(_key, false);
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
