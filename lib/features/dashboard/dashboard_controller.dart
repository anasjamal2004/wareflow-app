import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:warehouse_management_system/core/api/services/order_services/order_services.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navi_controller.dart';
import 'package:warehouse_management_system/features/start_screen/select_warehouse/select_warehouse_controller.dart';

class DashboardController extends GetxController {
  final getXWarehouse =
      Get.find<SelectWarehouseController>(); // yaha se token ka access milega
  final getXBottom =
      Get.find<BottomNavigationContoller>(); // yaha se warehouseID milegi
  late String warehouseToken;
  late int warehouseID;

  //
  var completedOrdersList = 0.obs;

  @override
  void onInit() {
    super.onInit();
    warehouseToken = getXWarehouse.warehouseToken;
    warehouseID = getXBottom.warehouseId;
  }

  Future<void> completedOrders() async {
    var allOrders = await OrderServices().getOrders(
      warehouseToken,
      warehouseID,
    );

    if (allOrders != null && allOrders.isNotEmpty) {
      completedOrdersList.value = allOrders
          .where((item) => item.status == 'Completed')
          .length;
    }
  }
}
