import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/model/supplier_model/supplier_model.dart';

class SupplierServices {
  final Dio _dio = ApiClient().dio;

  Future<List<SupplierModel>?> getSuppliers(
    int warehouseID,
  ) async {
    try {
      Response response = await _dio.get(
        ApiEndpoints.suppliers,
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      List data = response.data;
      return data.map((item) => SupplierModel.fromJson(item)).toList();
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<SupplierModel> postSupplier({
    required int warehouseID,
    required SupplierModel supplierData,
  }) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.suppliers,
        data: supplierData.toJson(), // data server may jaega
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      print("KACHRA CHECK: ${supplierData.toJson()}");
      var data = response.data;
      return SupplierModel.fromJson(data);
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<SupplierModel> putSupplier({
    required int warehouseID,
    required SupplierModel supplierData,
    required int supplierId,
  }) async {
    try {
      Response response = await _dio.put(
        '${ApiEndpoints.suppliers}$supplierId',
        data: supplierData.toJson(), // data server may jaega
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      var data = response.data;
      return SupplierModel.fromJson(data);
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<bool> deleteSupplier({
    required int supplierId,
    required int warehouseID,
  }) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.suppliers}$supplierId',
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
