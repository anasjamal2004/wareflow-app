import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ScreenUtil Import
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_sheet.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';

class SupplierTile extends StatelessWidget {
  final SupplierModel supplier;
  const SupplierTile({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    // Logic Audit: Get.put ko Tile ke andar rakhna memory leakage kar sakta hai
    // agar list bari ho. Filhal as per your request, code change nahi kar raha.
    final SupplierController getXcontroller = Get.put(SupplierController());

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ), // Responsive horizontal padding
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ActionSheetContent(
              isLoading: getXcontroller.isLoading,
              title: supplier.name!,
              onUpdate: () {
                getXcontroller.initialData(supplier);
                Navigator.pushNamed(
                  context,
                  AppRoutes.updateSupplierScreen,
                  arguments: supplier,
                );
              },
              onDelete: () => getXcontroller.deleteSupplier(supplier.id!),
            ),
          );
        },
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.showSupplierScreen,
            arguments: supplier,
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 15.h), // Responsive margin
          padding: EdgeInsets.all(16.w), // Responsive padding
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15.r), // Responsive radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. Header Row (Name & Status) ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      text: supplier.name ?? 'Company Name NA',
                      color: AppColors.blackColor,
                      fontSize: 18.sp, // Responsive font
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: 'active',
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // === 2. Contact Name ===
              CustomText(
                text: supplier.contactName ?? 'Contact Name NA',
                color: AppColors.greyColor,
                fontSize: 14.sp,
              ),

              Divider(color: Colors.grey.withValues(alpha: 0.2), height: 24.h),

              // === 3. Contact Info (Email, Phone, Address) ===
              _buildInfoRow(Icons.email_outlined, supplier.email ?? 'No Email'),
              SizedBox(height: 8.h),
              _buildInfoRow(Icons.phone_outlined, supplier.phone.toString()),
              SizedBox(height: 8.h),
              _buildInfoRow(
                Icons.location_on_outlined,
                supplier.address.toString(),
              ),

              Divider(color: Colors.grey.withValues(alpha: 0.2), height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn('Products', '15'),
                  _buildStatColumn('Orders', '48'),
                  _buildRatingColumn('Rating', '4.8'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for info rows
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: Colors.grey.shade600),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomText(
            text: text,
            color: Colors.grey.shade600,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  // Helper function for Products & Orders stats
  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label, color: Colors.grey.shade500, fontSize: 11.sp),
        SizedBox(height: 4.h),
        CustomText(
          text: value,
          color: AppColors.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  // Helper function for Rating
  Widget _buildRatingColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(text: label, color: Colors.grey.shade500, fontSize: 11.sp),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16.r),
            SizedBox(width: 4.w),
            CustomText(
              text: value,
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
