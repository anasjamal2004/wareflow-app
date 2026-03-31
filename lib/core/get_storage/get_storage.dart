import 'package:get_storage/get_storage.dart';

class GetAppStorage {
  static final box = GetStorage();
  //
  static void getData(String? token) {
    box.write('user_login', token);
  }

  static String readData() {
    return box.read('user_login');
  }
}
