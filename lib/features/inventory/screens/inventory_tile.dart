import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_dialog.dart';
import 'package:warehouse_management_system/core/widgets/custom_bottom_sheet.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/inventory/features/inventory_controller.dart';
import 'package:warehouse_management_system/features/inventory/features/update_product.dart';

class InventoryTile extends StatelessWidget {
  final InventoryModel product;
  const InventoryTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final AddProductController getXController =
        Get.find<AddProductController>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ), // Screen width ke hisab se constant padding
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ActionSheetContent(
              isLoading: getXController.isLoading,
              title: product.name!,
              onUpdate: () {
                getXController.initialData(product);
                //

                CustomActionDialog.show(
                  context: context,
                  title: 'UPDATE PRODUCT',
                  content: UpdateProduct(),
                  // 👉 Yahan Obx inject kar
                  actionButton: Obx(
                    () => CustomButton(
                      text: "UPDATE",
                      isLoading:
                          getXController.isLoading.value, // Reactive state
                      onPressed: () async {
                        if (getXController.isLoading.value) return;
                        await getXController.updateProduct();
                      },
                    ),
                  ),
                );
              },
              onDelete: () => getXController.deleteProduct(product.id!),
            ),
          );
        },
        // onTap: () {
        //   Navigator.pushNamed(
        //     context,
        //     AppRoutes.showInventoryScreen,
        //     arguments: product,
        //   );
        // },
        child: Container(
          // margin: EdgeInsets.only(bottom: 6.h), // Spacing between tiles
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ), // Internal padding for content
          decoration: BoxDecoration(
            color: AppTheme.current.card,
            borderRadius: BorderRadius.circular(15.r), // Smooth corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // === Image Picker: Add in Future (Commented remains unchanged) ===
              /*
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.blackColor,
                  size: 30.r,
                ),
              ),
              SizedBox(width: 15.w),
              */
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
                            color: AppTheme.current.textPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          text: 'Qty: ${product.quantity}',
                          color: AppTheme.current.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),
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
                                color: AppTheme.current.textSecondary,
                                fontSize: 13.sp,
                              ),
                              // SizedBox(height: 2.h),
                              CustomText(
                                text:
                                    'Category: ${product.category ?? 'Unknown'}',
                                color: AppTheme.current.textSecondary,
                                fontSize: 13.sp,
                              ),
                              CustomText(
                                text: 'Loc: ${product.location ?? 'Unknown'}',
                                color: AppTheme.current.textSecondary,
                                fontSize: 13.sp,
                              ),

                              // CustomText(
                              //   text: 'Price: ${product.price!.toInt()}',
                              //   color: AppColors.greyColor,
                              //   fontSize: 13.sp,
                              // ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.greenColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomText(
                                text: 'In Stock',
                                color: AppTheme.greenColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            CustomText(
                              text: 'Price: ${product.price!.toInt()}',
                              color: AppTheme.current.textSecondary,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
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
