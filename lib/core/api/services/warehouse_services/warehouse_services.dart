import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/model/create_warehouse_model/create_warehouse_model.dart';

class WarehouseService {
  final Dio _dio = ApiClient().dio;

  // --- 1. GET: Fetch All Warehouses ---
  Future<List<GetWarehouseModel>?> getWarehouses(String token) async {
    try {
      Response response = await _dio.get(
        ApiEndpoints.warehouse,
        options: Options(
          headers: {
            // YE LINE SABSE ZARORI HAI
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((item) => GetWarehouseModel.fromJson(item)).toList();
      }
    } on DioException catch (e) {
      print("GET Warehouses Error: ${e.response?.data}");
    }
    return null;
  }

  // --- 2. POST: Create New Warehouse ---
  Future<bool> createWarehouse(String token, String warehouseName) async {
    try {
      String currentTime = DateTime.now().toIso8601String().split('T')[0];
      Response response = await _dio.post(
        ApiEndpoints.warehouse,
        data: {"name": warehouseName, "id": 0, "created_at": currentTime},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Warehouse Created Successfully!");
        return true;
      }
    } on DioException catch (e) {
      print("POST Warehouse Error: ${e.response?.data}");
    }
    return false;
  }
}
