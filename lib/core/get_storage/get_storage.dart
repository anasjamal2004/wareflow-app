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

  static void getWarehouseID_Data(int warehouseID) {
    box.write('select_warehouse_id', warehouseID);
  }

  static int readWarehouseID_Data() {
    return box.read('select_warehouse_id');
  }
}
