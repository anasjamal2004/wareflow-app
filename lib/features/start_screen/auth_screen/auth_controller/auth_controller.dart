import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:warehouse_management_system/core/api/services/auth_services/auth_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/widgets/custom_getx_message.dart';
import 'package:warehouse_management_system/features/start_screen/auth_screen/login_screen/login_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  String? loginUserToken;

  //sign in controller
  final signinNameController = TextEditingController();
  final signinEmailController = TextEditingController();
  final signinPasswordController = TextEditingController();

  // login Controller
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // 2. Toggle func for password viewing on textfield
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<bool> login() async {
    loginUserToken = null;

    if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      GetXMessage.onError(message: 'Kindly fill the fields correctly');
      return false;
    }

    isLoading.value = true;

    try {
      String email = loginEmailController.text.trim();
      String password = loginPasswordController.text.trim();
      String? token = await AuthServices().loginUser(email, password);
      if (token != null) {
        loginUserToken = token;
        GetXMessage.onSuccess(message: 'SuccessFully Login');
        GetAppStorage.getData(loginUserToken);
        clearFields();
        return true;
      }
      return false;
    } catch (e) {
      print('Something Went Wrong: $e');
      GetXMessage.onError(message: e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // WareFlow SignUp Logic
  Future<bool> signUp() async {
    // 1. Reset State (Sabse pehle kachra saaf karo)

    // 2. Client-side Validation
    if (signinNameController.text.isEmpty ||
        signinEmailController.text.isEmpty ||
        signinPasswordController.text.isEmpty) {
      GetXMessage.onError(message: 'Kindly fill up all the fields');
      return false;
    }

    isLoading.value = true;

    try {
      // 3. Data Preparation
      String name = signinNameController.text.trim();
      String email = signinEmailController.text.trim();
      String password = signinPasswordController.text.trim();

      // 4. API Call (Tumhari Service class ke through)
      // Note: SignupService mein tumhara Ngrok wala URL use hoga
      bool isSuccess = await AuthServices().signUpUser(name, email, password);

      if (isSuccess != false) {
        // Token save kiya
        GetXMessage.onSuccess(message: 'Account Created! Welcome to WareFlow.');
        clearFields();
        return true;
      }
      return false;
    } catch (e) {
      print('Something Went Wrong: $e');
      GetXMessage.onError(message: e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout Func

  Future<bool> logOut(BuildContext context) async {
    try {
      isLoading.value = true;
      // await Future.delayed(Duration(seconds: 2)); //fake delay
      //

      // 1. Storage saaf karo (Token gaya)
      GetAppStorage.clearAll();

      // 2. Controllers pehle delete karo (Background activity khatam)
      // Is se dashboard ya reports ke controllers foran mar jayenge
      Get.deleteAll(force: true);

      // 3. Navigation sab se aakhir mein
      if (!context.mounted) return false; // Safety check for context
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
        ),
        (route) => false, // Stack poora clear!
      );

      GetXMessage.onSuccess(message: 'Successfully Logout');
      return true;
    } catch (e) {
      GetXMessage.onError(message: 'Something Went Wrong: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    signinNameController.clear();
    signinEmailController.clear();
    signinPasswordController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  @override
  void onClose() {
    signinNameController.dispose();
    signinEmailController.dispose();
    signinPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.onClose();
  }
}
