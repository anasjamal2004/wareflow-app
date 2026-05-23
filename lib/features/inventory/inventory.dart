import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_search_bar.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/product_features/inventory_controller.dart';
import 'package:warehouse_management_system/features/inventory/inventory_tile.dart';

class Inventory extends StatefulWidget {
  // Get.find tab use karein agar controller splash ya dashboard par put ho chuka hai
  final AddProductController getXcontroller = Get.put(AddProductController());
  Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60.h),
        //   child: CustomAppBar(
        //     text: 'Inventory',
        //     buttonText: '+ Add Product',
        //     onTap: () =>
        //         Navigator.pushNamed(context, AppRoutes.addProductScreen),
        //   ),
        // ),
        body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              // Search Bar area responsive padding ke sath
              CustomSearchBar(
                controller: widget.getXcontroller.searchController,
                onChanged: (value) => null,
              ),

              SizedBox(height: 5.h),

              // Main Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      await widget.getXcontroller.fetchInventory(),
                  color: AppColors.blackColor,
                  child: Obx(() {
                    // 1. Loading State (Agar backend se data aa raha hai)
                    if (widget.getXcontroller.isLoading.value) {
                      return const Center(child: LoadingAnimation());
                    }

                    // 2. Empty State (Agar search result khali ho)
                    if (widget.getXcontroller.inventoryList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 50.r,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10.h),
                            CustomText(
                              text: "No products found",
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      );
                    }

                    // 3. Data List
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: 20.h,
                      ), // End par thora gap
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: widget.getXcontroller.inventoryList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          child: InventoryTile(
                            product: widget.getXcontroller.inventoryList[index],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.inventory),
          onPressed: () {
            widget.getXcontroller.clearFields();
            Get.toNamed(AppRoutes.addProductScreen);
          },
        ),
      ),
    );
  }
}
