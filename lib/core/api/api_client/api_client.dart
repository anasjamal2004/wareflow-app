import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl =
      "https://traceried-karyn-peroratorically.ngrok-free.dev";

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}

class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String warehouse = '/warehouses/';
}
