import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/model/orders_model/orders_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomOrderCard extends StatelessWidget {
  final OrderModel order;
  final Function(String?)? onStatusChanged;
  static const List<String> statusOptions = [
    'pending',
    'processing',
    'completed',
    'cancel',
  ];
  const CustomOrderCard({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.greenColor;
      case 'processing':
        return AppColors.blueColor;
      case 'cancel':
        return AppColors.redColor;
      default:
        return Colors.orange; // 'pending' ya kisi aur ke liye
    }
  }

  @override
  Widget build(BuildContext context) {
    // API se aane wala status pakro (Lowercase safety ke sath)
    String currentStatus = order.status?.toLowerCase() ?? 'pending';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 0.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: order.orderNumber.toString(), // Static Number
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A2E),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12.sp,
                        color: AppColors.greyColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: order.orderDate.toString().split(
                          'T',
                        )[0], // Static Date
                        fontSize: 11.sp,
                        color: AppColors.greyColor,
                      ),
                    ],
                  ),
                ],
              ),
              // Status Dropdown
              _buildStaticDropdown(currentStatus),
            ],
          ),

          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          SizedBox(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Order value",
                    fontSize: 11.sp,
                    color: AppColors.greyColor,
                  ),
                  CustomText(
                    text: order.totalValue.toString(), // Static Price
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomText(
                  text: "Items: ${order.items?.length ?? 0}", // Static Items
                  fontSize: 12.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaticDropdown(String currentStatus) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: _getStatusColor(
          currentStatus,
        ).withOpacity(0.1), // Static color for 'Pending'
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: _getStatusColor(currentStatus).withOpacity(0.5),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          // ager list may status nhi hai toh by default pending show krdo
          value: statusOptions.contains(currentStatus)
              ? currentStatus
              : 'pending',
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 16.sp,
            color: _getStatusColor(currentStatus),
          ),
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: _getStatusColor(currentStatus),
          ),
          onChanged: (String? newValue) {
            if (newValue != null && onStatusChanged != null) {
              onStatusChanged!(newValue); // Controller ko signal bhejo
            }
          },
          items: statusOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toUpperCase(), // Dikhane mein professional lagega
                style: const TextStyle(color: Colors.black87),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
