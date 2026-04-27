import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import lazmi hai
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/info_display_row.dart';

class ShowSupplier extends StatelessWidget {
  const ShowSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    final supplier =
        ModalRoute.of(context)!.settings.arguments as SupplierModel;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparentColor,
        title: CustomText(
          text: 'Supplier Detail',
          color: AppColors.blackColor,
          fontSize: 27.sp, // Responsive Font
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w), // Responsive Padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Icon Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 60.h,
              ), // Responsive Height
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15.r), // Responsive Radius
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.business_center_outlined,
                    size: 60.r, // Responsive Icon Size
                    color: AppColors.blueColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h), // Responsive Gap
            // Name and Contact Header
            Center(
              child: Column(
                children: [
                  CustomText(
                    text: supplier.name ?? "No Name",
                    color: AppColors.blackColor,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    text: "Contact: ${supplier.contactName ?? 'N/A'}",
                    color: Colors.grey[600]!,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Supplier Information Rows
            InfoDisplayRow(label: "Status", value: supplier.status ?? "N/A"),
            InfoDisplayRow(
              label: "Rating",
              value: "${supplier.rating ?? 0} Stars",
            ),
            InfoDisplayRow(
              label: "Email",
              value: supplier.email ?? "Not Provided",
            ),
            InfoDisplayRow(
              label: "Phone",
              value: supplier.phone != null ? supplier.phone.toString() : "N/A",
            ),
            InfoDisplayRow(
              label: "Address",
              value: supplier.address ?? "No Address Set",
            ),

            InfoDisplayRow(label: "System ID", value: "#${supplier.id ?? 0}"),
            InfoDisplayRow(
              label: "Warehouse ID",
              value: "#${supplier.warehouseId ?? 0}",
            ),
          ],
        ),
      ),
    );
  }
}
