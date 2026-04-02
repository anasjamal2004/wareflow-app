import 'package:get/state_manager.dart';
import 'package:warehouse_management_system/core/api/services/order_services/order_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';

class DashboardController extends GetxController {
  var warehouseToken = GetAppStorage.readData();
  var warehouseID = GetAppStorage.readWarehouseID_Data();

  //
  var completedOrdersList = 0.obs;

  @override
  void onInit() {
    super.onInit();
    completedOrders();
  }

  Future<void> completedOrders() async {
    // print("DEBUG: Fetching for Warehouse ID: $warehouseID");
    var allOrders = await OrderServices().getOrders(
      warehouseToken,
      warehouseID,
    );

    if (allOrders != null && allOrders.isNotEmpty) {
      completedOrdersList.value = allOrders
          .where((item) => item.status.toString().toLowerCase() == 'completed')
          .length;
    }
  }
}
