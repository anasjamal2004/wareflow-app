import 'package:dio/dio.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';

class AuthServices {
  final Dio _dio = ApiClient().dio;
  //

  Future<void> pingServer() async {
    try {
      await _dio.get('/');
      print("Server Wake-up request.");
    } catch (e) {
      print("Server responded (even if it's 404). It's awake now.");
    }
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      // FormData formData = FormData.fromMap({
      //   "grant_type": "password",
      //   "username": email,
      //   "password": password,
      // });

      final Map<String, dynamic> loginData = {
        "grant_type": "password",
        "username": email,
        "password": password,
      };

      final response = await _dio.post(
        ApiEndpoints.login,
        data: loginData,
        options: Options(contentType: "application/x-www-form-urlencoded"),
      );

      if (response.statusCode == 200) {
        print('--- DEBUGGING LOGIN RESPONSE ---');
        print(response.data['detail']);
        String token = response.data['access_token'];

        print("Login Successful! Token: $token");
        return token;
      } else {
        return null;
      }
    } on DioException catch (e) {
      // yaha per api client ka error catch hoga.
      String errorMSG;

      if (e.response != null) {
        // error jo server dega
        errorMSG = e.response?.data['detail'];
        print('Login Error: $errorMSG');
      } else {
        errorMSG = 'Server is not responding';
      }

      //if-else may se jo true hoga wooh error agye throw hojaega.
      throw errorMSG;
    }
  }

  //
  Future<bool> signUpUser(String name, String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {"name": name, "email": email, "password": password},
      );

      // 201 ya 200 ka matlab hai User Create ho gaya
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("SignUp Successful: ${response.data}");
        return true;
      }
    } on DioException catch (e) {
      String errorMSG;
      if (e.response != null) {
        errorMSG = e.response?.data['detail'];
        print('Sign In Error: $errorMSG');
      } else {
        errorMSG = 'Server is not responding';
      }

      throw errorMSG;
    }
    return false;
  }
}
