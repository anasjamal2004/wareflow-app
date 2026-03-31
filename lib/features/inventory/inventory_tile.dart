import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_sheet.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/product_features/product_controller.dart';

class InventoryTile extends StatelessWidget {
  final InventoryModel product;
  const InventoryTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final AddProductController getXController = Get.put(AddProductController());
    final double screenSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize * 0.027),
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ActionSheetContent(
              isLoading: getXController.isLoading,
              title: product.name!,
              onUpdate: () {
                getXController.initialData(product);

                Navigator.pushNamed(
                  context,
                  AppRoutes.updateProductScreen,
                  arguments: product,
                );
              },
              onDelete: () => getXController.deleteProduct(product.id!),
            ),
          );
        },
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.showInventoryScreen,
            arguments: product,
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: screenSize * 0.022),
          padding: EdgeInsets.all(screenSize * 0.044),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(screenSize * 0.041),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // === Image Picker: Add in Future ===
              // Container(
              //   width: screenSize * 0.166,
              //   height: screenSize * 0.166,
              //   decoration: BoxDecoration(
              //     color: AppColors.greyColor,
              //     borderRadius: BorderRadius.circular(screenSize * 0.033),
              //   ),
              //   child: Icon(
              //     Icons.inventory_2_outlined,
              //     color: AppColors.blackColor,
              //     size: screenSize * 0.077,
              //   ),
              // ),
              // SizedBox(width: screenSize * 0.041),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: product.name ?? 'NA',
                            color: AppColors.blackColor,
                            fontSize: screenSize * 0.044,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenSize * 0.027),
                        CustomText(
                          text: 'Qty: ${product.quantity}',
                          color: AppColors.blackColor,
                          fontSize: screenSize * 0.038,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

                    SizedBox(height: screenSize * 0.022),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'SKU: ${product.sku ?? 'NA'}',
                                color: AppColors.greyColor,
                                fontSize: screenSize * 0.037,
                              ),
                              SizedBox(height: screenSize * 0.005),
                              CustomText(
                                text: 'Loc: ${product.location ?? 'Unknown'}',
                                color: AppColors.greyColor,
                                fontSize: screenSize * 0.037,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize * 0.038,
                            vertical: screenSize * 0.016,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greenColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              screenSize * 0.022,
                            ),
                          ),
                          child: CustomText(
                            text: 'In Stock',
                            color: AppColors.greenColor,
                            fontSize: screenSize * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
