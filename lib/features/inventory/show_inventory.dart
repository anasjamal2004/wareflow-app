import 'package:flutter/material.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/info_display_row.dart';

class ShowInventory extends StatelessWidget {
  const ShowInventory({super.key});

  @override
  Widget build(BuildContext context) {
    // Reciving data from Inventory_tile screen
    final product =
        ModalRoute.of(context)!.settings.arguments as InventoryModel;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparentColor,
        title: CustomText(
          text: 'Inventory Detail',
          color: AppColors.blackColor,
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 60,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Column(
                children: [
                  CustomText(
                    text: product.name ?? "No Name",
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    text: "SKU: ${product.sku ?? 'N/A'}",
                    color: Colors.grey[600]!,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            InfoDisplayRow(
              label: "Category",
              value: product.category ?? "General",
            ),
            InfoDisplayRow(label: "Price", value: "Rs. ${product.price ?? 0}"),
            InfoDisplayRow(
              label: "Stock Quantity",
              value: "${product.quantity ?? 0}",
            ),
            InfoDisplayRow(
              label: "Minimum Stock",
              value: "${product.minStock ?? 0}",
            ),
            InfoDisplayRow(
              label: "Location",
              value: product.location ?? "Not Set",
            ),
            InfoDisplayRow(
              label: "Warehouse ID",
              value: "#${product.warehouseId ?? 0}",
            ),
            InfoDisplayRow(
              label: "Supplier ID",
              value: "#${product.supplierId ?? 0}",
            ),
          ],
        ),
      ),
    );
  }
}
