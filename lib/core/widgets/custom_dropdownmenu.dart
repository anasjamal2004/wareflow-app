import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
// Import your CustomText and AppColors here
// import 'package:your_project/widgets/custom_text.dart';
// import 'package:your_project/constants/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? selectedValue;
  final bool isOpen;
  final String Function(T) itemLabel;
  final Function(T) onSelected;
  final VoidCallback onToggle;
  final IconData leadingIcon;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.itemLabel,
    required this.onSelected,
    required this.onToggle,
    this.isOpen = false,
    this.selectedValue,
    this.leadingIcon = Icons.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isOpen ? AppColors.blackColor : AppColors.lightGrey,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(leadingIcon, size: 20.r, color: AppColors.greyColor),
                      SizedBox(width: 12.w),
                      // ✅ Integrated your CustomText here
                      CustomText(
                        text: selectedValue != null
                            // ignore: null_check_on_nullable_type_parameter
                            ? itemLabel(selectedValue!)
                            : hint,
                        color: selectedValue != null
                            ? AppColors.blackColor
                            : AppColors.greyColor,
                        fontSize: 16.sp,
                        fontWeight: selectedValue != null
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ],
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ),
          ),

          // Dropdown List Items
          if (isOpen)
            Container(
              margin: EdgeInsets.only(top: 5.h),
              constraints: BoxConstraints(maxHeight: 200.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    onTap: () => onSelected(item),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      // ✅ Integrated your CustomText in the list too
                      child: CustomText(
                        text: itemLabel(item),
                        color: AppColors.blackColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: selectedValue == item
                        ? const Icon(
                            Icons.check,
                            color: AppColors.greenColor,
                            size: 18,
                          )
                        : null,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
