import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_dropdownmenu.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/create_order/order_item_widget.dart';
import 'package:warehouse_management_system/features/orders/order_controller.dart';
import 'package:warehouse_management_system/features/product_features/inventory_controller.dart';

class CreateOrder extends StatelessWidget {
  final OrderController getXController = Get.find<OrderController>();
  final AddProductController getXInventoryController =
      Get.find<AddProductController>();

  CreateOrder({super.key});

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
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: AppColors.transparentColor,
          scrolledUnderElevation: 0,
          title: CustomText(
            text: 'Create Order',
            color: AppColors.blackColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => CustomDropdown<String>(
                  hint: 'Order Type',
                  items: getXController.orderTypes,
                  selectedValue: getXController.selectedOrderType.value,
                  itemLabel: (item) => item,
                  onSelected: (value) {
                    getXController.updateOrderType(value);
                  },
                  // onToggle: () => getXController.toggleDropDown(),
                  // isOpen: getXController.isDropDownOpen.value,
                ),
              ),

              Obx(
                () => CustomDropdown<SupplierModel>(
                  hint: 'Select Supplier',
                  items: getXInventoryController.suppliers,
                  selectedValue: getXInventoryController.selectedSupplier.value,
                  // isOpen: getXInventoryController.isSupplierDropdownOpen.value,
                  itemLabel: (supplier) => supplier.name ?? "Unknown",
                  onSelected: (supplier) =>
                      getXInventoryController.selectSupplier(supplier),
                  // onToggle: () =>
                  //     getXInventoryController.toggleSupplierDropdown(),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'LINE ITEMS',
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomButton(
                      height: 40.h,
                      width: 130.w,
                      text: 'Add Items',
                      onPressed: () => getXController.addRow(),
                    ),
                  ],
                ),
              ),

              // OrderItemWidget Cart
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getXController.cartItems.length,
                  itemBuilder: (context, index) {
                    return OrderItemWidget(
                      index: index,
                      controller: getXController,
                    );
                  },
                ),
              ),

              CustomTextField(
                controller: getXController.descController,
                keyboardType: TextInputType.text,
                label: 'Internel Notes',
                hintText: 'Shipping Instruction or Comments',
                maxLines: 5,
              ),

              Obx(() {
                final totalPrice = getXController.totalOrderValue;
                return IgnorePointer(
                  child: CustomTextField(
                    readOnly: true,
                    key: ValueKey('totalPrice_$totalPrice'),
                    controller: TextEditingController(
                      text: totalPrice.toString(),
                    ),
                    label: '',
                    hintText: '',
                  ),
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                      getXController.clearFields();
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(
                    () => CustomButton(
                      text: "Add",
                      isLoading: getXController.isLoading.value,
                      onPressed: () async {
                        if (getXController.isLoading.value) return;
                        await getXController.submitOrder();
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
