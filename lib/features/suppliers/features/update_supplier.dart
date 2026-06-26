import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/suppliers/features/supplier_controller.dart';

class UpdateSupplier extends StatelessWidget {
  // Logic Reminder: Agar Suppliers list se aa rahe ho, toh yahan Get.find use karo
  final SupplierController getXcontroller = Get.put(SupplierController());
  UpdateSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.current.appBar,
          surfaceTintColor: AppTheme.transparentColor,
          scrolledUnderElevation: 0,
          title: CustomText(
            text: 'Update Supplier',
            color: AppTheme.current.textPrimary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: getXcontroller.companyNameController,
              label: 'Company Name',
              hintText: '',
            ),
            CustomTextField(
              controller: getXcontroller.emailController,
              label: 'Email',
              hintText: '',
            ),
            CustomTextField(
              controller: getXcontroller.phoneController,
              keyboardType: TextInputType.number,
              label: 'Phone Number',
              hintText: '',
            ),
            CustomTextField(
              controller: getXcontroller.addressController,
              label: 'Full Address',
              hintText: '',
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ), // Responsive padding
          decoration: BoxDecoration(color: AppTheme.current.card),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    color: AppTheme.greyColor,
                    textColor: AppTheme.current.textPrimary,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 12.w), // Responsive gap
                Expanded(
                  child: Obx(
                    () => CustomButton(
                      text: "Update", // Fixed: "Add" se "Update" kar diya
                      isLoading: getXcontroller.isLoading.value,
                      onPressed: () async {
                        if (getXcontroller.isLoading.value) return;
                        await getXcontroller.updateSupplier();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
