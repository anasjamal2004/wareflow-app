import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // 👉 Clean Import
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_container.dart';
import 'package:warehouse_management_system/core/widgets/custom_dropdownmenu.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/create_order/order_item_widget.dart';
import 'package:warehouse_management_system/features/orders/order_controller.dart';
import 'package:warehouse_management_system/features/product_features/inventory_controller.dart';

// 👉 Naam change kiya kyunke ab yeh screen nahi, dialog ka content hai
class CreateOrder extends StatelessWidget {
  const CreateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController getXController = Get.find<OrderController>();
    final AddProductController getXInventoryController =
        Get.find<AddProductController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => CustomDropdown<String>(
            hint: 'Order Type',
            items: getXController.orderTypes,
            selectedValue: getXController.selectedOrderType.value,
            itemLabel: (item) => item,
            onSelected: (value) => getXController.updateOrderType(value),
          ),
        ),
        Obx(
          () => CustomDropdown<SupplierModel>(
            hint: 'Select Supplier',
            items: getXInventoryController.suppliers,
            selectedValue: getXInventoryController.selectedSupplier.value,
            itemLabel: (supplier) => supplier.name ?? "Unknown",
            onSelected: (supplier) =>
                getXInventoryController.selectSupplier(supplier),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'LINE ITEMS*',
                color: AppTheme.current.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              CustomButton(
                height: 35.h,
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
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getXController.cartItems.length,
            itemBuilder: (context, index) {
              return OrderItemWidget(index: index, controller: getXController);
            },
          ),
        ),
        CustomTextField(
          controller: getXController.descController,
          keyboardType: TextInputType.text,
          label:
              'Internal Notes', // 👉 Spelling fix ki hai (Internel -> Internal)
          hintText: 'Shipping Instruction or Comments',
          maxLines:
              3, // 👉 Dialog mein space kam hoti hai, 5 ki jagah 3 kar diya
        ),
        SizedBox(height: 5.h),

        Obx(() {
          final totalPrice = getXController.totalOrderValue;
          return CustomContainer(
            widget: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              child: CustomText(
                text: 'TOTAL PRICE: ${totalPrice.toString()}',
                color: AppTheme.current.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }),
      ],
    );
  }
}
