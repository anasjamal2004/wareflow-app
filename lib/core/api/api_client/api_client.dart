import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';

class ApiClient {
  // BaseURL
  static const String baseUrl =
      "https://wareflow-vk1u.onrender.com/"; // Actual Server Url
  // static const String baseUrl =
  //     "https://traceried-karyn-peroratorically.ngrok-free.dev"; // ngrok URL

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
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.connectionError) {
            print("MASLA: Server unreachable hai (Down ya Slow).");
            // throught the to UI
            return handler.next(e);
          }
          // Token Expire per yeh login screen per navigate krdega.
          if (e.response?.statusCode == 401) {
            // ager yeh login screen may galat password dalne se huwa hai
            bool isLoginPath = e.requestOptions.path.contains(
              ApiEndpoints.login,
            );

            if (isLoginPath) {
              print('Error 401 Wrong passwoard');
              // Login par 401 = Wrong Password. Bas aage jane do.
              return handler.next(e);
            } else {
              // Login token expire hogaya hai
              print("MASLA: Token expire ho gaya, dubara login karo.");
              GetAppStorage.clearAll(); // Sab saaf hojaega.
              Get.offAllNamed(AppRoutes.loginScreen);

              Get.snackbar(
                "Session Expired",
                "Please login again",
                backgroundColor: Colors.orange,
                colorText: Colors.white,
              );

              // handler.next(e) = "error ko UI tak jane do"
              // Toh try/catch mein jo likha hai woh chalega
              return handler.next(e);
            }
          }

          // CHECK 3: Server ne koi aur error diya? (400, 500 etc.)
          // e.response != null matlab server ne kuch toh bheja
          if (e.response != null) {
            print("SERVER ERROR: ${e.response?.statusCode}");
          }

          // handler.next(e) = "error ko UI tak jane do"
          // Toh try/catch mein jo likha hai woh chalega
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
