import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_dropdownmenu.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/product_features/inventory_controller.dart';

class UpdateProduct extends StatelessWidget {
  const UpdateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final getXcontroller = Get.find<AddProductController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
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
            itemLabel: (supplier) => supplier.name ?? "Unknown",
            onSelected: (supplier) => getXcontroller.selectSupplier(supplier),
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
            SizedBox(width: 10), // Add proper spacing
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
    );
  }
}