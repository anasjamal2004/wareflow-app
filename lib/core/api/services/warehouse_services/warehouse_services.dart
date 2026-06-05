import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/model/warehouse_model/warehouse_list_model.dart';

class WarehouseService {
  final Dio _dio = ApiClient().dio;

  // --- 1. GET: All Warehouses ---
  Future<List<WarehouseListModel>?> getWarehouses() async {
    try {
      Response response = await _dio.get(ApiEndpoints.warehouse);

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((item) => WarehouseListModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
      // return [];
    }
  }

  // --- 2. POST: Create New Warehouse ---
  Future<bool> createWarehouse(String token, String warehouseName) async {
    try {
      //
      Response response = await _dio.post(
        ApiEndpoints.warehouse,
        data: {"name": warehouseName},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Warehouse Created Successfully!");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print("POST Warehouse Error: ${e.response?.data}");
      rethrow;
    }
  }
}
