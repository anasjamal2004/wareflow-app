import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/start_screen/auth_screen/auth_controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  final AuthController getXcontroller = Get.put(
    AuthController(),
    permanent: true,
  );
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          bottom: true,
          top: false,
          child: Center(
            child: SingleChildScrollView(
              // SingleChildScrollView keyboard overflow se bachata hai
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  // Height ko 430 se badal kar responsive kiya
                  padding: EdgeInsets.symmetric(
                    vertical: 30.h,
                    horizontal: 15.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10.r,
                        spreadRadius: 2.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Container content ke mutabiq adjust hoga
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'WAREFLOW',
                        color: AppColors.blackColor,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Welcome back',
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        controller: widget.getXcontroller.loginEmailController,
                        label: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: Icons.email_outlined,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller:
                              widget.getXcontroller.loginPasswordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText:
                              widget.getXcontroller.isPasswordHidden.value,
                          suffixIcon:
                              widget.getXcontroller.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onPressed: () {
                            widget.getXcontroller.togglePasswordVisibility();
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Obx(
                        () => CustomButton(
                          width: double
                              .infinity, // Button ko container ki full width di hai
                          text: 'Login',
                          isLoading: widget.getXcontroller.isLoading.value,
                          onPressed: () async {
                            await widget.getXcontroller.login();
                            if (!mounted) return;
                            if (widget.getXcontroller.loginUserToken != null) {
                              Get.offAllNamed(
                                AppRoutes.selectWarehouseScreen,
                                arguments: widget.getXcontroller.loginUserToken,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don't have an account? ",
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.getXcontroller.clearFields();
                              Get.toNamed(AppRoutes.signUpScreen);
                            },
                            child: CustomText(
                              text: 'Sign up',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
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
        ),
      ),
    );
  }
}
