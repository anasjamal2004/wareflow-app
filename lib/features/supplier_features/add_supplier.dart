import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';

class AddSupplier extends StatelessWidget {
  const AddSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller initialize ho raha hai jaisa tumne likha tha
    final SupplierController getXcontroller = Get.put(SupplierController());

    // 🚨 LOGIC: Sirf Column bacha hai jisme form fields hain. 
    // Scaffold, AppBar, BottomNavigationBar sab remove kar diye kyunki
    // CustomActionDialog already wo sab handle kar raha hai.
    return Column(
      mainAxisSize: MainAxisSize.min, // Dialog ko jitni height chahiye utni lega
      children: [
        CustomTextField(
          controller: getXcontroller.companyNameController,
          label: 'Company Name',
          hintText: '',
        ),
        CustomTextField(
          controller: getXcontroller.emailController,
          label: 'Email',
          hintText: '',
        ),
        CustomTextField(
          controller: getXcontroller.phoneController,
          keyboardType: TextInputType.number,
          label: 'Phone Number',
          hintText: '',
        ),
        CustomTextField(
          controller: getXcontroller.addressController,
          label: 'Full Address',
          hintText: '',
        ),
      ],
    );
  }
}