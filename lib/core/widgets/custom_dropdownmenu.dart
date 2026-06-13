import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemLabel;
  final Function(T) onSelected;
  final IconData leadingIcon;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.itemLabel,
    required this.onSelected,
    this.selectedValue,
    this.leadingIcon = Icons.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,

          // 1. New Version Method: Button Customization
          buttonStyleData: ButtonStyleData(
            // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppTheme.current.card,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppTheme.greyColor, width: 1.5),
            ),
          ),

          // 2. New Version Method: Floating Menu Customization
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250.h,
            decoration: BoxDecoration(
              color: AppTheme.current.card,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            offset: const Offset(
              0,
              -5,
            ), // Menu ko button ke upar fit karne ke liye
          ),

          // 3. FIX: New version mein height parameter MenuItemStyleData se drop ho chuka hai
          // Ab height har individual item ke wrapper widget se handle hoti hai
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),

          // 4. HINT PLACEHOLDER
          hint: Row(
            children: [
              Icon(leadingIcon, size: 20.r, color: AppTheme.greyColor),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomText(
                  text: hint,
                  color: AppTheme.greyColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),

          // 5. FIX: Mapping using 'DropdownItem' (Not DropdownMenuItem)
          items: items.map((T item) {
            return DropdownItem<T>(
              value: item,
              // Item ki height fix karne ke liye Container/SizedBox lagaya
              child: Container(
                height: 45.h,
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: itemLabel(item),
                  color: AppTheme.current.textPrimary,
                ),
              ),
            );
          }).toList(),

          // 6. FIX: Selected Value aur Callback logic mapping
          valueListenable: ValueNotifier<T?>(selectedValue),
          onChanged: (T? value) {
            if (value != null) {
              onSelected(value);
            }
          },

          // 7. ARROW ICONS
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.greyColor,
              size: 24.r,
            ),
            openMenuIcon: Icon(
              Icons.keyboard_arrow_up,
              color: AppTheme.greyColor,
              size: 24.r,
            ),
          ),
        ),
      ),
    );
  }
}
