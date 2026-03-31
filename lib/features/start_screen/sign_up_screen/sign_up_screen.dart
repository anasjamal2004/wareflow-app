import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/start_screen/getX_controller/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController getXcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'WareFlow',
                    color: AppColors.blackColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text: 'Create an account',
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: getXcontroller.nameController,
                    label: 'Name',
                    hintText: 'Enter your full name',
                  ),
                  CustomTextField(
                    controller: getXcontroller.emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: getXcontroller.passwordController,
                    label: 'Password',
                    hintText: 'Create a password',
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => CustomButton(
                      text: 'Register',
                      isLoading: getXcontroller.isLoading.value,
                      onPressed: () async {
                        bool isSuccess = await getXcontroller.signUp();
                        if (!mounted) return;
                        if (isSuccess != false) {
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        } else {
                          Get.snackbar("Error", "SignUp failed.");
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Already have an account? ",
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CustomText(
                          text: 'Sign in',
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
