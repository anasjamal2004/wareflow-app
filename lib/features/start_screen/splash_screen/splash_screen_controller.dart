import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warehouse_management_system/core/api/services/auth_services/auth_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  final AuthServices authServices = AuthServices();
  @override
  void onInit() {
    super.onInit();
    startingScreen();
  }

  Future<void> startingScreen() async {
    try {
      await authServices.pingServer();
    } catch (e) {
      print('Server might be down but it woke up: $e');
    } finally {
      String nextPage = GetAppStorage.checkUserLogin();
      if (Get.context != null) {
        Navigator.pushReplacementNamed(Get.context!, nextPage);
      }
    }
  }
}
