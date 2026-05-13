import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';

class ApiClient {
  // BaseURL
  // static const String baseUrl =
  //     "https://wareflow-vk1u.onrender.com/"; // Actual Server Url
  static const String baseUrl =
      "https://traceried-karyn-peroratorically.ngrok-free.dev"; // ngrok URL

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // User Token
          String? token = GetAppStorage.readData();
          options.headers["Authorization"] = "Bearer $token";
          print("Api Client Request: ${options.path}");
          return handler.next(options);
        },

        onResponse: (response, handler) {
          // Yahan sirf print karo taake tumhein pata chale server zinda hai
          print("✅ [${response.statusCode}] ${response.requestOptions.path}");

          // Data ko chhero mat, bas aage bhej do
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          // yeh Error Agye send krdega.
          return handler.next(e);
        },
      ),
    );
  }
}

class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String warehouse = '/warehouses/';
  static const String inventory = '/inventory/';
  static const String suppliers = '/suppliers/';
  static const String orders = '/orders/';
  static const String reportInventoryCategory =
      '/reports/inventory-by-category';
  static const String reportRevenueTrend = '/reports/revenue-trend';
}
