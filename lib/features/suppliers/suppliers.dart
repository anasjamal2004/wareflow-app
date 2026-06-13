import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_dialog.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_floating_action_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/supplier_features/add_supplier.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';
import 'package:warehouse_management_system/features/suppliers/supplier_tile.dart';

class Suppliers extends StatelessWidget {
  final SupplierController getXController = Get.put(SupplierController());
  Suppliers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: RefreshIndicator(
          onRefresh: () async => await getXController.fetchSupplier(),
          color: AppTheme.current.loadingColor,
          child: Obx(() {
            // 1. Loading State
            if (getXController.isLoading.value) {
              return const Center(child: LoadingAnimation());
            }

            // 2. Empty State
            if (getXController.supplierList.isEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: constraints.maxHeight,
                      child: Center(
                        child: CustomText(
                          text: "No Suppliers Found",
                          color: AppTheme.greyColor,
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            // 3. Success State (Data List)
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: getXController.supplierList.length,
              itemBuilder: (context, index) {
                return SupplierTile(
                  supplier: getXController.supplierList[index],
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          getXController.clearFields();
          //
          CustomActionDialog.show(
            context: context,
            title: 'ADD NEW SUPPLIER',
            content: AddSupplier(),
            // 👉 Yahan Obx inject kar
            actionButton: Obx(
              () => CustomButton(
                text: "ADD",
                isLoading: getXController.isLoading.value, // Reactive state
                onPressed: () async {
                  if (getXController.isLoading.value) return;
                  await getXController.saveSupplier();
                },
              ),
            ),
          );
        },
        icon: Icons.person,
      ),
    );
  }
}
