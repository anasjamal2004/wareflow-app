import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';

class InventoryServices {
  final Dio _dio = ApiClient().dio;

  Future<List<InventoryModel>?> getInventory({required int warehouseID}) async {
    try {
      Response response = await _dio.get(
        ApiEndpoints.inventory,
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      List data = response.data;
      return data.map((item) => InventoryModel.fromJson(item)).toList();
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<InventoryModel> postInventory({
    required int warehouseID,
    required InventoryModel inventoryData,
  }) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.inventory,
        data: inventoryData.toJson(), // data server may jaega
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      print("KACHRA CHECK: ${inventoryData.toJson()}");
      var data = response.data;
      return InventoryModel.fromJson(data);
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<InventoryModel> putInventory({
    required int warehouseID,
    required InventoryModel inventoryData,
    required int inventoryId,
  }) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.suppliers}$inventoryId',
        data: inventoryData.toJson(), // data server may jaega
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      var data = response.data;
      return InventoryModel.fromJson(data);
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<bool> deleteInventory({
    required int inventoryId,
    required int warehouseID,
  }) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.inventory}$inventoryId',
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      return true;
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }
}
