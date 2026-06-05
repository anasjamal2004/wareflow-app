import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/api/api_client/api_error_handler.dart';
import 'package:warehouse_management_system/core/api/services/supplier_services/supplier_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_getx_message.dart';

class SupplierController extends GetxController {
  String get warehouseID => GetAppStorage.readWarehouseID_Data().toString();
  //
  RxList<SupplierModel> supplierList = <SupplierModel>[].obs; // Main List
  // RxList<SupplierModel> foundSupplier =
  //     <SupplierModel>[].obs; // Search Func list use in future.
  int? supplierid;
  var isLoading = false.obs;
  // final searchController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  //

  @override
  void onInit() {
    super.onInit();
    // assignAll -> Data Copy Method
    // supplierList.assignAll(DummyData().dummySuppliers);
    // foundSupplier.assignAll(supplierList);
    fetchSupplier();
  }

  // Data Fetch hoga supplier ka.
  Future<void> fetchSupplier() async {
    isLoading.value = true; // ✅ UI ko batao ke data aa raha hai

    try {
      // Agar null ya galat string hui toh crash nahi hoga, 0 return karega.
      String rawWarehouseId = warehouseID;
      int parsedWarehouseId = int.tryParse(rawWarehouseId) ?? 0;

      var result = await SupplierServices().getSuppliers(parsedWarehouseId);

      if (result != null) {
        supplierList.value = result;
      } else {
        // Agar API ne kuch nahi bheja toh list khali karo taake kachra show na ho
        supplierList.clear();
        print("API returned null for suppliers.");
      }
    } catch (e) {
      ApiError.handler(e);
      print("Silent Crash Caught in fetchSupplier: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveSupplier() async {
    if (companyNameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      GetXMessage.onError(message: 'Kindly Fill the Field');
      return false;
    }

    isLoading.value = true;

    try {
      SupplierModel newSupplierModel = SupplierModel(
        // id: DateTime.now().millisecondsSinceEpoch,
        name: companyNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        status: "active",
        rating: 3.0,
      );
      SupplierModel savedSupplier = await SupplierServices().postSupplier(
        supplierData: newSupplierModel,
        warehouseID: int.parse(warehouseID),
      );
      supplierList.add(savedSupplier);
      // supplierList.refresh();
      // foundProducts.assignAll(productList); // search func ager future may use krna hoo.
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      clearFields();
      GetXMessage.onSuccess(message: 'Supplier is save successfully');
      return true;
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // woh data jo update ky textfield may save hoga.
  void initialData(SupplierModel supplier) {
    supplierid = supplier.id; // server se id milegi.
    companyNameController.text = supplier.name.toString();
    emailController.text = supplier.email.toString();
    addressController.text = supplier.address.toString();
    phoneController.text = supplier.phone.toString();
  }

  Future<bool> updateSupplier() async {
    if (companyNameController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      GetXMessage.onError(message: 'Kindly Fill the Field');
      return false;
    }

    isLoading.value = true;

    try {
      SupplierModel updateSupplierData = SupplierModel(
        name: companyNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        status: "active",
        rating: 3.0,
      );

      SupplierModel updatedSupplier = await SupplierServices().putSupplier(
        warehouseID: int.parse(warehouseID),
        supplierData: updateSupplierData,
        supplierId: supplierid!,
      );

      int index = supplierList.indexWhere((sup) => sup.id == supplierid);

      // index != -1 means if the index is found => (1 != 1) true is not equal to false
      if (index != -1) {
        supplierList[index] = updatedSupplier;
        // Yeh List ko Refresh karega
        // supplierList.refresh();
        // foundProducts.assignAll(productList);
        await Future.delayed(Duration(seconds: 1));
        Get.back();
        clearFields();
        GetXMessage.onSuccess(message: 'Supplier updated successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteSupplier(int supplierid) async {
    isLoading.value = true;
    try {
      await SupplierServices().deleteSupplier(
        supplierId: supplierid,
        warehouseID: int.parse(warehouseID),
      );
      supplierList.removeWhere((item) => item.id == supplierid);
      // foundProducts.assignAll(productList);
      await Future.delayed(Duration(seconds: 1));
      // Get.back();
      GetXMessage.onSuccess(message: 'Supplier is Successfully Deleted');
      return true;
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // void searchProduct(String searchItem) {
  //   String searchKey = searchItem.toLowerCase().trim();

  //   if (searchKey.isEmpty) {
  //     foundProducts.assignAll(productList);
  //   } else {
  //     var filteredList = productList.where((item) {
  //       return item.name!.toLowerCase().contains(searchKey) ||
  //           item.sku!.toLowerCase().contains(searchKey);
  //     }).toList();
  //     foundProducts.assignAll(filteredList);
  //   }
  // }

  void clearFields() {
    companyNameController.clear();
    addressController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void onClose() {
    // companyNameController.dispose();
    // emailController.dispose();
    // addressController.dispose();
    // phoneController.dispose();
    super.onClose();
  }
}
