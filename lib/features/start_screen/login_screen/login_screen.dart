import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/start_screen/getX_controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController getXcontroller = Get.put(AuthController());

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
                    text: 'Welcome back',
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: getXcontroller.emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: getXcontroller.passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => CustomButton(
                      width: 270,
                      text: 'Login',
                      isLoading: getXcontroller.isLoading.value,
                      onPressed: () async {
                        await getXcontroller.login();

                        if (!mounted) return;
                        if (getXcontroller.loginUserToken != null) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.selectWarehouseScreen,
                            arguments: getXcontroller.loginUserToken,
                          );
                        } else {
                          Get.snackbar(
                            "Error",
                            "Login failed. Token not received.",
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Don't have an account? ",
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.signUpScreen,
                        ),
                        child: const CustomText(
                          text: 'Sign up',
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
