import 'package:get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';

class GetAppStorage {
  static final box = GetStorage();
  // user ka token
  static void getData(String? token) {
    box.write('user_login', token);
  }

  // yaha per read
  static String readData() {
    return box.read('user_login') ?? "";
  }

  // warehouse name

  static void saveWarehouseName(String name) {
    box.write('select_warehouse_name', name);
  }

  static String readWarehouseName() {
    return box.read('select_warehouse_name') ?? "";
  }

  static void deleteWarehouseData() {
    box.remove('select_warehouse_id');
    box.remove('select_warehouse_name');
    // ID delete ki (apni sahi key use karna yahan)
    print("Warehouse data cleared from storage!");
  }

  // warehouse id
  static void getWarehouseID_Data(int warehouseID) {
    box.write('select_warehouse_id', warehouseID);
  }

  static int readWarehouseID_Data() {
    return box.read('select_warehouse_id') ?? 0;
  }

  // Direct app khulte hee bottomnaviagion per lejana user ko

  static String checkUserLogin() {
    String userToken = readData();
    var rawWarehouseID = readWarehouseID_Data();
    int finalWarehouseID = int.tryParse(rawWarehouseID.toString()) ?? 0;

    // 🚨 LOGS START HERE - Inhein ignore mat karna!
    print("==========================================");
    print("🛠️ APP STARTUP LOGIC CHECK");
    print("1. TOKEN IN STORAGE: '${userToken.isEmpty ? "EMPTY" : "EXISTS"}'");
    print(
      "2. RAW WAREHOUSE FROM BOX: '$rawWarehouseID' (Type: ${rawWarehouseID.runtimeType})",
    );
    print("3. FINAL PARSED ID: $finalWarehouseID");

    if (userToken.isEmpty) {
      print("4. RESULT: Token nahi mila -> AppRoutes.loginScreen");
      print("==========================================");
      return AppRoutes.loginScreen;
    }

    if (finalWarehouseID > 0) {
      print(
        "4. RESULT: Warehouse ID '$finalWarehouseID' mili -> AppRoutes.dashboardScreen",
      );
      print("==========================================");
      return AppRoutes.dashboardScreen;
    }

    print(
      "4. RESULT: Token hai par ID 0 hai -> AppRoutes.selectWarehouseScreen",
    );
    print("==========================================");
    return AppRoutes.selectWarehouseScreen;
  }

  //Logout func

  static Future<void> clearAll() async {
    await box.erase();
  }
}
