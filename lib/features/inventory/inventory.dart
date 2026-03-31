import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_app_bar.dart';
import 'package:warehouse_management_system/core/widgets/custom_search_bar.dart';
import 'package:warehouse_management_system/features/product_features/product_controller.dart';
import 'package:warehouse_management_system/features/inventory/inventory_tile.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final AddProductController getXcontroller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            text: 'Inventory',
            buttonText: '+ Add Product',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.addProductScreen);
            },
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            CustomSearchBar(
              controller: getXcontroller.searchController,
              onChanged: (value) {
                getXcontroller.searchProduct(value);
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: getXcontroller.foundProducts.length,
                  itemBuilder: (context, index) {
                    return InventoryTile(
                      product: getXcontroller.foundProducts[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
