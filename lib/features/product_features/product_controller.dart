import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/api/api_client/api_error_handler.dart';
import 'package:warehouse_management_system/core/api/services/inventory_services/inventory_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_getx_message.dart';
import 'package:warehouse_management_system/features/supplier_features/supplier_controller.dart';

class AddProductController extends GetxController {
  //
  // 1. Existing Controller ko find karna (Single Source of Truth)
  final SupplierController _supplierCtrl = Get.put(SupplierController());

  // 2. Dropdown UI States
  var isSupplierDropdownOpen = false.obs; // Dropdown khulne/band hone ka state
  var selectedSupplier =
      Rxn<SupplierModel>(); // Selected item (Shuru mein null)

  // 3. Getter for Suppliers List (SupplierController se data lena)
  List<SupplierModel> get suppliers => _supplierCtrl.supplierList;

  // 4. Methods to control UI
  void toggleSupplierDropdown() {
    isSupplierDropdownOpen.value = !isSupplierDropdownOpen.value;
  }

  void selectSupplier(SupplierModel supplier) {
    selectedSupplier.value = supplier;
    isSupplierDropdownOpen.value = false; // Select hote hi band kardo
  }

  //
  String get warehouseID => GetAppStorage.readWarehouseID_Data().toString();
  RxList<InventoryModel> inventoryList = <InventoryModel>[].obs;
  // List<InventoryModel> foundProducts = <InventoryModel>[].obs;
  //
  int? Productid;
  var isLoading = false.obs;
  //
  final searchController = TextEditingController();
  final productNameController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final minStockController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  //

  @override
  void onInit() {
    super.onInit();
    // assignAll -> Data Copy Method
    // productList.assignAll(DummyData().dummyInventory);
    // foundProducts.assignAll(productList);
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    isLoading.value = true; // ✅ UI ko batao ke data aa raha hai

    try {
      // ✅ LOGIC FIX: Safe parsing. Agar null ya galat string hui toh crash nahi hoga, 0 return karega.
      String rawWarehouseId = warehouseID;
      int parsedWarehouseId = int.tryParse(rawWarehouseId) ?? 0;

      var result = await InventoryServices().getInventory(
        warehouseID: parsedWarehouseId,
      );

      // ✅ LOGIC FIX: Never use '!'. Always check for null.
      if (result != null) {
        inventoryList.value = result;
      } else {
        // Agar API ne kuch nahi bheja toh list khali karo taake kachra show na ho
        inventoryList.clear();
        print("API returned null for suppliers.");
      }
    } catch (e) {
      // ✅ LOGIC FIX: Catch the silent crashes!
      ApiError.handler(e);
      print("🚨 Silent Crash Caught in fetchSupplier: $e");
    } finally {
      isLoading.value = false; // ✅ Har haal mein loading band karo
    }
  }

  Future<bool> saveProduct() async {
    if (productNameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        quantityController.text.trim().isEmpty ||
        minStockController.text.trim().isEmpty ||
        categoryController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        selectedSupplier.value == null) {
      GetXMessage.onError(message: 'Kindly Fill all the Fields');
      return false;
    }

    isLoading.value = true;

    try {
      InventoryModel newInventoryData = InventoryModel(
        // id: DateTime.now().millisecondsSinceEpoch,
        sku: "Auto Generated",
        name: productNameController.text.trim(),
        category: categoryController.text.trim(),
        quantity: num.tryParse(quantityController.text.trim())?.toInt() ?? 0,
        price: num.tryParse(priceController.text.trim())?.toInt() ?? 0,
        minStock: num.tryParse(minStockController.text.trim())?.toInt() ?? 0,
        location: locationController.text.trim(),
        supplierId: selectedSupplier.value!.id,
      );

      await InventoryServices().postInventory(
        warehouseID: int.parse(warehouseID),
        inventoryData: newInventoryData,
      );

      await fetchInventory();
      // inventoryList.add(newInventoryData);
      // inventoryList.refresh();
      await Future.delayed(Duration(seconds: 1));
      clearFields();
      Get.back();
      GetXMessage.onSuccess(message: 'New Product Add Successfully');
      return true;
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void initialData(InventoryModel product) {
    //
    Productid = product.id;
    productNameController.text = product.name.toString();
    categoryController.text = product.category.toString();
    locationController.text = product.location.toString();
    minStockController.text = product.minStock.toString();
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();

    // Supplierid ko match krky nikalna
    if (product.supplierId != null) {
      // Supplier list mein dhoondo jahan ID match karti ho
      selectedSupplier.value = _supplierCtrl.supplierList.firstWhere(
        (s) => s.id == product.supplierId,
      );
    }
  }

  Future<bool> updateProduct() async {
    if (productNameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        quantityController.text.trim().isEmpty ||
        minStockController.text.trim().isEmpty ||
        categoryController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        selectedSupplier.value == null) {
      GetXMessage.onError(message: 'Kindly Fill all the Fields');
      return false;
    }

    isLoading.value = true;

    try {
      InventoryModel updateInventoryData = InventoryModel(
        id: Productid,
        name: productNameController.text.trim(),
        category: categoryController.text.trim(),
        quantity: num.tryParse(quantityController.text.trim())?.toInt() ?? 0,
        price: num.tryParse(priceController.text.trim())?.toInt() ?? 0,
        minStock: num.tryParse(minStockController.text.trim())?.toInt() ?? 0,
        location: locationController.text.trim(),
        supplierId: selectedSupplier.value!.id,
      );
      // inventoryList.add(updateInventoryData);
      await InventoryServices().putInventory(
        warehouseID: int.parse(warehouseID),
        inventoryData: updateInventoryData,
        inventoryId: Productid!,
      );
      int index = inventoryList.indexWhere((item) => item.id == Productid);

      // index != -1 means if the index is found => (1 != 1) true is not equal to false
      if (index != -1) {
        inventoryList[index] = updateInventoryData;

        // productList.assignAll(productList.toList());
        // foundProducts.assignAll(productList);
        // inventoryList.refresh();
        await Future.delayed(Duration(seconds: 1));
        clearFields();
        Get.back();
        GetXMessage.onSuccess(message: 'Product Updated Successfully');
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

  Future<bool> deleteProduct(int productid) async {
    isLoading.value = true;
    try {
      await InventoryServices().deleteInventory(
        inventoryId: productid,
        warehouseID: int.parse(warehouseID),
      );
      inventoryList.removeWhere((item) => item.id == productid);
      // foundProducts.assignAll(productList);
      await Future.delayed(Duration(seconds: 1));
      // Get.back();
      GetXMessage.onSuccess(message: 'Product Deleted Successfully');
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
    productNameController.clear();
    searchController.clear();
    priceController.clear();
    locationController.clear();
    minStockController.clear();
    quantityController.clear();
    categoryController.clear();
    selectedSupplier.value = null;
    isSupplierDropdownOpen.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    locationController.dispose();
    quantityController.dispose();
    locationController.dispose();
    minStockController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
