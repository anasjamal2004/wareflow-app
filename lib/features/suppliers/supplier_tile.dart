import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_dialog.dart';
import 'package:warehouse_management_system/core/widgets/custom_bottom_sheet.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/product_features/update_product.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';

class SupplierTile extends StatelessWidget {
  final SupplierModel
  supplier; // Supplier.dart se data milraha hai single supplier ka
  const SupplierTile({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    final SupplierController getXController = Get.find<SupplierController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ActionSheetContent(
              isLoading: getXController.isLoading,
              title: supplier.name!,
              onUpdate: () {
                getXController.initialData(supplier);
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
                        await getXController.updateSupplier();
                      },
                    ),
                  ),
                );
              },
              onDelete: () => getXController.deleteSupplier(supplier.id!),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. Top Header Row ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Icon Container
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(
                      Icons.business,
                      color: Colors.black87,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Name and Status Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: supplier.name ?? 'Company Name NA',
                          color: AppColors
                              .blackColor, // Make sure this is a dark blue/black in your AppColors
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 6.h),
                        // Active Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              20.r,
                            ), // Fully rounded like image
                          ),
                          child: CustomText(
                            text: supplier.status.toString(),
                            color: Colors.teal.shade700,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // === 2. Middle Contact Info Column ===
              _buildInfoRow(
                Icons.email_outlined,
                supplier.email ?? 'No Email',
                false,
              ),
              SizedBox(height: 10.h),
              _buildInfoRow(
                Icons.phone_outlined,
                supplier.phone.toString(),
                true,
              ), // Phone is bold in image
              SizedBox(height: 10.h),
              _buildInfoRow(
                Icons.location_on_outlined,
                supplier.address ?? 'Nothing',
                false,
              ),

              SizedBox(height: 16.h),
              Divider(color: AppColors.blackColor, height: 1, thickness: 1),
              SizedBox(height: 16.h),

              // === 3. Bottom Footer Row (Rating & UID) ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16.r),
                        SizedBox(width: 4.w),
                        CustomText(
                          text:
                              '3.0', // Replace with supplier.rating if dynamic
                          color: Colors.orange.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                  // UID Text
                  CustomText(
                    text: 'UID: ${supplier.id ?? 'N/A'}',
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ HELPER: Boolean flag added for bold text requirement in the image (Phone number)
  Widget _buildInfoRow(IconData icon, String text, bool isBold) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: Colors.grey.shade400),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomText(
            text: text,
            color: isBold ? Colors.black87 : Colors.grey.shade700,
            fontSize: 13.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
