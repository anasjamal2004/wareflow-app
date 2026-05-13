import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';
import 'package:warehouse_management_system/features/suppliers/supplier_tile.dart';

class Suppliers extends StatelessWidget {
  final SupplierController getXcontroller = Get.put(SupplierController());
  Suppliers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(kToolbarHeight),
      //   child: CustomAppBar(
      //     text: 'Suppliers',
      //     buttonText: 'Add Supplier',
      //     icon: Icons.people,
      //     onTap: () {
      //       // Get.toNamed(AppRoutes.addSupplierScreen);
      //     },
      //   ),
      // ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: true,
        top: false,
        child: RefreshIndicator(
          onRefresh: () async => await getXcontroller.fetchSupplier(),
          color: AppColors.blackColor,
          child: Obx(() {
            // 1. Loading State
            if (getXcontroller.isLoading.value) {
              return const Center(child: LoadingAnimation());
            }

            // 2. Empty State
            if (getXcontroller.supplierList.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text("No Suppliers Found"),
                    ),
                  ),
                ],
              );
            }

            // 3. Success State (Data List)
            // ✅ Fix: SingleChildScrollView hata diya, ListView akela kafi hai.
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: getXcontroller.supplierList.length,
              itemBuilder: (context, index) {
                return SupplierTile(
                  supplier: getXcontroller.supplierList[index],
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.people),
        onPressed: () {
          getXcontroller.clearFields();
          Get.toNamed(AppRoutes.addSupplierScreen);
        },
      ),
    );
  }
}
