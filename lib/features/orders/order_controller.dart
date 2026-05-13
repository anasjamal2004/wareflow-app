import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warehouse_management_system/core/api/api_client/api_error_handler.dart';
import 'package:warehouse_management_system/core/api/services/order_services/order_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/model/orders_model/orders_model.dart';

class OrderController extends GetxController {
  // 0 = Inbound, 1 = Outbound
  var selectedTab = 0.obs;
  RxList<OrderModel> allOrders = <OrderModel>[].obs;
  var isLoading = false.obs;
  String get warehouseID => GetAppStorage.readWarehouseID_Data().toString();

  List<OrderModel> get inBoundOrders =>
      allOrders.where((order) => order.orderType == "inbound").toList();

  List<OrderModel> get outBoundOrders =>
      allOrders.where((order) => order.orderType == "outbound").toList();

  void switchTab(int index) {
    selectedTab.value = index;
  }

  @override
  void onInit() {
    super.onInit();

    fetchOrder();
  }

  Future<void> fetchOrder() async {
    isLoading.value = true;

    try {
      var result = await OrderServices().getOrders(
        warehouseID: int.tryParse(warehouseID) ?? 0,
      );
      if (result != null) {
        allOrders.value = result;
      }
    } catch (e) {
      ApiError.handler(e);
    } finally {
      isLoading.value = false;
    }
  }

  // OrderController.dart ke andar add karo:

  Future<void> updateOrderStatus(int orderId, String? newStatus) async {
    if (newStatus == null) return;

    // Ui Update hoga
    
    // indexWhere us order id ka index nikalega jis user status change kr raha hai
    int index = allOrders.indexWhere((o) => o.id == orderId);
    String? oldStatus = allOrders[index].status;

    allOrders[index].status = newStatus;
    allOrders.refresh();
    //

    // Server per update hoga
    try {
      // 2. Server call (PATCH)
      bool success = await OrderServices().updateStatus(
        orderId: orderId,
        warehouseID: int.parse(warehouseID),
        status: newStatus,
      );
      //

      // if (!success) {
      //   // Agar fail ho jaye toh wapas purana status kar do
      //   allOrders[index].status = oldStatus;
      //   allOrders.refresh();
      //   Get.snackbar("Error", "Failed to update status on server");
      // }
    } catch (e) {
      allOrders[index].status = oldStatus;
      allOrders.refresh();
      ApiError.handler(e);
    }
  }
}
