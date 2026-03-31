import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:warehouse_management_system/core/api/services/auth_services/auth_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String? loginUserToken;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> login() async {
    loginUserToken = null;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Kindly fill them correctly');
      return false;
    }

    isLoading.value = true;

    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String? token = await AuthServices().loginUser(email, password);
      if (token != null) {
        Get.snackbar('Success', 'Token: $token');
        loginUserToken = token;
        GetAppStorage.getData(loginUserToken);
        clearFields();
        return true;
      } else {
        Get.snackbar('Fail', 'Please Sign Up first');
        return false;
      }
    } catch (e) {
      print('Something Went Wrong: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // WareFlow SignUp Logic
  Future<bool> signUp() async {
    // 1. Reset State (Sabse pehle kachra saaf karo)

    // 2. Client-side Validation
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Sari fields fill karo, khali chorna unprofessional hai!',
      );
      return false;
    }

    isLoading.value = true;

    try {
      // 3. Data Preparation
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // 4. API Call (Tumhari Service class ke through)
      // Note: SignupService mein tumhara Ngrok wala URL use hoga
      bool isSuccess = await AuthServices().signUpUser(name, email, password);

      if (isSuccess != false) {
        // Token save kiya
        Get.snackbar('Success', 'Account Created! Welcome to WareFlow.');
        clearFields();
        return true;
      } else {
        Get.snackbar('Fail', 'Email already exists.');
        return false;
      }
    } catch (e) {
      print('SignUp Error: $e');
      Get.snackbar('Error', 'Internet check karo ya Docker restart karo.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
