import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_dropdownmenu.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/product_features/product_controller.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController getXcontroller =
        Get.find<AddProductController>();
    return PopScope(
      // Yeh is lia use kia hai jab user back button dabbae toh dropdrown unselected hojae.
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          getXcontroller.clearFields();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundColor,
            surfaceTintColor: AppColors.transparentColor,
            scrolledUnderElevation: 0,
            title: CustomText(
              text: 'Add New Product',
              color: AppColors.blackColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: getXcontroller.productNameController,
                  label: 'Product Name',
                  hintText: 'write product name',
                ),
                CustomTextField(
                  controller: getXcontroller.categoryController,
                  label: 'Category',
                  hintText: '',
                ),
                CustomTextField(
                  controller: getXcontroller.locationController,
                  label: 'Location',
                  hintText: '',
                ),
                Obx(
                  () => CustomDropdown<SupplierModel>(
                    hint: 'Select Supplier',
                    items: getXcontroller.suppliers,
                    selectedValue: getXcontroller.selectedSupplier.value,
                    isOpen: getXcontroller.isSupplierDropdownOpen.value,
                    itemLabel: (supplier) => supplier.name ?? "Unknown",
                    onSelected: (supplier) =>
                        getXcontroller.selectSupplier(supplier),
                    onToggle: () => getXcontroller.toggleSupplierDropdown(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: getXcontroller.quantityController,
                        keyboardType: TextInputType.number,
                        label: 'Current Quantity',
                        hintText: '',
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: getXcontroller.minStockController,
                        keyboardType: TextInputType.number,
                        label: 'Mini. Stock Alert',
                        hintText: '',
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: getXcontroller.priceController,
                  keyboardType: TextInputType.number,
                  label: 'Price',
                  hintText: '',
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: AppColors.backgroundColor),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Cancel",
                      color: AppColors.greyColor.withValues(alpha: 0.2),
                      textColor: AppColors.blackColor,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        text: "Add",
                        isLoading: getXcontroller.isLoading.value,
                        onPressed: () async {
                          if (getXcontroller.isLoading.value) return;
                          await getXcontroller.saveProduct();
                        },
                      ),
                    ),
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
