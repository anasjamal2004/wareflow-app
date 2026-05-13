import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:warehouse_management_system/core/api/api_client/api_client.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_getx_message.dart';

class ApiError {
  static void handler(dynamic e) {
    String errorMSG = "An unexpected error occurred";
    //

    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        print("MASLA: Server unreachable hai (Down ya Slow).");
        errorMSG = 'Server unreachable';
      }
      // Token Expire per yeh login screen per navigate krdega.
      else if (e.response?.statusCode == 401) {
        // ager yeh login screen may galat password dalne se huwa hai
        bool isLoginPath = e.requestOptions.path.contains(ApiEndpoints.login);

        if (isLoginPath) {
          // ager yeh true huwa.
          print('Error 401 Wrong passwoard');
          errorMSG = e.response?.data['detail'];
          // Login par 401 = Wrong Password. Bas aage jane do.
        } else {
          // Login token expire hogaya hai
          print("MASLA: Token expire ho gaya, dubara login karo.");
          GetAppStorage.clearAll(); // Sab saaf hojaega.
          Get.offAllNamed(AppRoutes.loginScreen);
          errorMSG = "Session is expired";
        }
      }
      // CHECK 3: Server ne koi aur error diya? (400, 500 etc.)
      // e.response != null matlab server ne kuch toh bheja
      else if (e.response != null) {
        var data = e.response?.data;
        var detail = data is Map ? data['detail'] : null;

        if (detail is List && detail.isNotEmpty) {
          // Case 1: Validation errors (List of maps)
          // Hum check kar rahe hain ke detail[0] waqai Map hai ya nahi
          var errorLocation =
              detail[0]['loc']; // 👈 Yeh batayega kaunsi field hai
          var errorMsg = detail[0]['msg'];
          print("🚨 Field missing: $errorLocation | Message: $errorMsg");
          var firstError = detail[0];
          if (firstError is Map && firstError.containsKey('msg')) {
            errorMSG = firstError['msg'].toString();
          } else {
            errorMSG = "Validation error occurred";
          }
        } else if (detail is String) {
          // Case 2: Simple error message (String)
          errorMSG = detail;
        } else if (data is Map && data.containsKey('message')) {
          // Case 3: Kuch backend 'message' key use karte hain
          errorMSG = data['message'].toString();
        } else {
          // Case 4: Default fallback
          errorMSG = "Server Error: ${e.response?.statusCode}";
        }
      }
    } else {
      errorMSG = e.toString();
      print('Its not dio error: $errorMSG');
    }

    // Inmay se jo bhi true hoga snackbar usko print krdega.
    GetXMessage.onError(message: errorMSG);
  }
}
