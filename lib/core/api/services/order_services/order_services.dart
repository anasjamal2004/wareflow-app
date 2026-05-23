import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/model/orders_model/orders_model.dart';

class OrderServices {
  final Dio _dio = ApiClient().dio;

  Future<List<OrderModel>?> getOrders({required int warehouseID}) async {
    try {
      Response response = await _dio.get(
        ApiEndpoints.orders,
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      List data = response.data;
      return data.map((item) => OrderModel.fromJson(item)).toList();
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<OrderModel> postOrder({
    required int warehouseID,
    required OrderModel orderData,
  }) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.orders,
        data: orderData.toJson(), // data server may jaega
        options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
      );

      print("DEBUG: API Status Code: ${response.statusCode}");
      print("DEBUG: Raw Response Data: ${response.data}");
      print("Order Data CHECK: ${orderData.toJson()}");
      var data = response.data;
      return OrderModel.fromJson(data);
    } catch (e) {
      // print("GET Supplier Error: ${e.response?.statusCode} - ${e.message}");
      rethrow;
    }
  }

  Future<bool> updateStatus({
  required int orderId,
  required int warehouseID,
  required String status,
}) async {
  try {
    Response response = await _dio.patch(
      "${ApiEndpoints.orders}/$orderId/status",
      data: {
        "status": status, // Sirf yeh map bhejo, poora model nahi! kyun ky patch may chota change hota hai.
      },
      options: Options(headers: {'x-warehouse-id': warehouseID.toString()}),
    );

    return response.statusCode == 200;
  } catch (e) {
    print("PATCH Status Error: $e");
    rethrow;
  }
}

  Future<bool> deleteOrder({
    required int orderId,
    required int warehouseID,
  }) async {
    try {
      Response response = await _dio.delete(
        '${ApiEndpoints.orders}$orderId',
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
