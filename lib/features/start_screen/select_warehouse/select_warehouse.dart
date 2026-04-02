import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/start_screen/select_warehouse/select_warehouse_controller.dart';

class SelectWarehouse extends StatefulWidget {
  const SelectWarehouse({super.key});

  @override
  State<SelectWarehouse> createState() => _SelectWarehouseState();
}

class _SelectWarehouseState extends State<SelectWarehouse> {
  final SelectWarehouseController getXController = Get.put(
    SelectWarehouseController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: AppColors.transparentColor,
          elevation: 0,
          title: CustomText(
            text: 'Select a Warehouse',
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            // TextButton.icon(
            //   onPressed: () => Get.back(),
            //   icon: const Icon(Icons.logout, size: 18, color: Colors.grey),
            //   label: CustomText(
            //     text: "Logout",
            //     color: Colors.grey,
            //     fontSize: 14,
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: createWarehouseWidget(() {
                showCreateWarehouseDialog();
              }),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: wareshousesContainer(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  //---------------------------------------------------------------//
  Widget createWarehouseWidget(GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 30,
            foregroundColor: AppColors.greyColor,
            child: Icon(Icons.add),
          ),
          CustomText(
            text: 'Create New',
            color: AppColors.greyColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  void showCreateWarehouseDialog() {
    showDialog(
      context: context,
      barrierDismissible: !getXController.isLoading.value,
      builder: (context) {
        return Dialog(
          // Side rounding yahan se control hogi
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Dialog sirf content jitna bada hoga
              children: [
                const CustomText(
                  text: "Create New Warehouse",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
                const SizedBox(height: 10),

                // Tumhara Custom TextField
                CustomTextField(
                  controller: getXController.warehouseNameController,
                  label: "Warehouse Name",
                  hintText: "Enter warehouse name (e.g. Karachi Hub)",
                ),

                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: CustomButton(
                        text: "Cancel",
                        color: Colors.grey[300],
                        textColor: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Create Button
                    Expanded(
                      child: Obx(
                        () => CustomButton(
                          text: "Create",
                          isLoading: getXController.isLoading.value,
                          onPressed: () {
                            getXController.createWarehouse();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Actuall WareHouse Data which are showing in the container.
  Widget wareshousesContainer() {
    return Obx(
      () => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: getXController.warehouses.length,
        itemBuilder: (context, index) {
          final warehouse = getXController.warehouses[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: InkWell(
              // Data is Navigating: Warehouse id and Warehouse name to -> Navigation Screen
              onTap: () {
                GetAppStorage.getWarehouseID_Data(warehouse.id);
                Navigator.pushNamed(context, AppRoutes.bottomNavigationScreen);
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: warehouse.name.toString(),
                        color: AppColors.blackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: 'Joined: ${warehouse.createdAt.toString()}',
                        color: AppColors.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
