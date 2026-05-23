import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/api/api_client/api_error_handler.dart';
import 'package:warehouse_management_system/core/api/services/order_services/order_services.dart';
import 'package:warehouse_management_system/core/get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/model/orders_model/orders_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_getx_message.dart';
import 'package:warehouse_management_system/features/product_features/inventory_controller.dart';

class OrderController extends GetxController {
  // ==========================================
  // 1. GLOBAL UI STATE (Poori screen ka state)
  // ==========================================

  // 0 = Inbound, 1 = Outbound (Tabs switch karne ke liye)
  var selectedTab = 0.obs;

  // Order type track karne ke liye (Inbound ya Outbound)
  var selectedOrderType = 'Inbound'.obs;

  // API call ke waqt loader dikhane ke liye
  var isLoading = false.obs;

  // Yeh sirf us global 'Notes' ya 'Description' ke liye hai jo pure order ka ek hota hai.
  // (Yeh dynamically list mein multiple nahi hota, isliye controller mein rakhna theek hai).
  final descController = TextEditingController();

  // ==========================================
  // 2. DATA HOLDING VARIABLES (Asal Data)
  // ==========================================

  // Storage se warehouse ID nikal kar lane ka getter
  String get warehouseID => GetAppStorage.readWarehouseID_Data().toString();

  // API se aane wale tamam orders is list mein save honge
  RxList<OrderModel> allOrders = <OrderModel>[].obs;

  // *** THE MOST IMPORTANT LIST ***
  // Yeh list tumhare multiple carts ka data (ID, price, quantity) hold karegi backend ko bhejne ke liye. Jab user [Add items button] per click karega.
  RxList<OrderItem> cartItems = <OrderItem>[].obs;

  // Dropdown ke options
  final List<String> orderTypes = ['Inbound', 'Outbound'];

  // ==========================================
  // 3. COMPUTED GETTERS (Data ko filter karne ke methods)
  // ==========================================

  // allOrders mein se sirf Inbound wale orders nikal kar dega
  List<OrderModel> get inBoundOrders =>
      allOrders.where((order) => order.orderType == "inbound").toList();

  // allOrders mein se sirf Outbound wale orders nikal kar dega
  List<OrderModel> get outBoundOrders =>
      allOrders.where((order) => order.orderType == "outbound").toList();

  // Pure order ki total amount calculate karne ka logic (Jo UI par "Total Amount" mein dikhega)
  num get totalOrderValue {
    num total = 0;
    // Har cart item ke paas jao aur uski price ko quantity se multiply karke total mein add kardo
    for (var item in cartItems) {
      total += (item.priceAtOrder ?? 0) * (item.quantity ?? 0);
    }
    return total;
  }

  // Inventory Controller tak pohnchne ka rasta
  AddProductController get getXInventoryController =>
      Get.find<AddProductController>();

  // Puri Inventory list utha kar lane ka getter
  List<InventoryModel> get inventoryData =>
      getXInventoryController.inventoryList;

  // ==========================================
  // 4. ACTION METHODS (User jo harkatein karega)
  // ==========================================

  // Tab switch karne ka function
  void switchTab(int index) {
    selectedTab.value = index;
  }

  // Order type update karne ka function
  void updateOrderType(String value) {
    selectedOrderType.value = value;
  }

  // Naya khali dabba (Cart Item) list mein add karne ka function
  void addRow() {
    // Shuru mein ID null, quantity 1, aur price 0 hogi.
    cartItems.add(OrderItem(productId: null, quantity: 1, priceAtOrder: 0));
  }

  // Delete button dabne par specific dabba list se udane ka function
  void removeRow(int index) {
    cartItems.removeAt(index);
  }

  // Supplier ke hisab se products ko filter karne ka function (Dropdown mein dikhane ke liye)
  List<InventoryModel> filteredProduct() {
    // Agar user ne supplier select nahi kiya, toh khali list return kardo (App crash hone se bach jayegi)
    if (getXInventoryController.selectedSupplier.value == null) {
      return [];
    }
    // Warna sirf woh products do jinki supplierId select kiye gaye supplier se match karti ho
    return inventoryData
        .where(
          (product) =>
              product.supplierId ==
              getXInventoryController.selectedSupplier.value?.id,
        )
        .toList();
  }

  // Jab order complete ho jaye aur form saaf karna ho
  void clearFields() {
    cartItems.clear(); // List khali
    addRow();
    selectedOrderType.value = 'Inbound';
    descController.clear(); // Notes khali kardo
    getXInventoryController.selectedSupplier.value =
        null; // Supplier reset kardo
  }

  // ==========================================
  // 5. API CALLS (Backend se rabta)
  // ==========================================

  @override
  void onInit() {
    super.onInit();
    fetchOrder(); // Controller bante hi server se orders utha lao
    // addRow(); // yeh automatically ek row add krlega [but isme selection nhi horahi yeh fix krna hai]
  }

  // Orders GET karne ki API
  Future<void> fetchOrder() async {
    isLoading.value = true; // Loader on karo
    try {
      var result = await OrderServices().getOrders(
        warehouseID: int.tryParse(warehouseID) ?? 0,
      );
      if (result != null) {
        allOrders.assignAll(result); // Data list mein save kardo
      }
    } catch (e) {
      ApiError.handler(e); // Error aye toh error dikhao
    } finally {
      isLoading.value = false; // Loader off karo (chahe error aye ya pass ho)
    }
  }

  // Order Status update karne ki API (PATCH request)
  Future<void> updateOrderStatus(int orderId, String? newStatus) async {
    if (newStatus == null) return;

    // 1. Optimistic UI Update (Server se pehle UI par dikha do taake app fast lagay)
    int index = allOrders.indexWhere((o) => o.id == orderId);
    String? oldStatus = allOrders[index].status;

    allOrders[index].status = newStatus;
    allOrders.refresh();

    // 2. Asal Server call
    try {
      await OrderServices().updateStatus(
        orderId: orderId,
        warehouseID: int.parse(warehouseID),
        status: newStatus,
      );
    } catch (e) {
      // Agar server fail ho jaye toh chupke se UI ko wapas purane status par le aao
      allOrders[index].status = oldStatus;
      allOrders.refresh();
      ApiError.handler(e);
    }
  }

  Future<bool> submitOrder() async {
    bool productIsEmpty = cartItems.any((items) => items.productId == null);

    // yaha per yeh check karega ky kisi product ki quantity null yeh 1 se neechay toh nhi hai
    bool quantityIsEmpty = cartItems.any(
      (item) => item.quantity == null || item.quantity! < 1,
    );

    if (getXInventoryController.selectedSupplier.value == null ||
        cartItems.isEmpty ||
        quantityIsEmpty ||
        productIsEmpty) {
      GetXMessage.onError(message: 'Kindly fill the fields correctly');
      return false;
    }

    isLoading.value = true;

    try {
      OrderModel newOrderData = OrderModel(
        orderType: selectedOrderType.value,
        supplierId: getXInventoryController.selectedSupplier.value!.id,
        totalValue: totalOrderValue,
        notes: descController.text.trim(), // yeh user ky lia optional hoga.
        status: 'pending',
        // .toList() lagana zaroori hai taake list ki fresh copy bane.
        // Agar direct cartItems pass karenge toh controller clear hone par model ka data bhi urr jayega.
        items: cartItems.toList(),
      );

      await OrderServices().postOrder(
        warehouseID: int.parse(warehouseID),
        orderData: newOrderData,
      );

      await fetchOrder();
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      GetXMessage.onSuccess(message: 'New Order Add Successfully');
      return true;
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteOrder(int orderid) async {
    isLoading.value = true;
    try {
      await OrderServices().deleteOrder(
        orderId: orderid,
        warehouseID: int.parse(warehouseID),
      );
      allOrders.removeWhere((item) => item.id == orderid);
      await Future.delayed(Duration(seconds: 1));
      GetXMessage.onSuccess(message: 'Order Deleted Successfully');
      return true;
    } catch (e) {
      ApiError.handler(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================
  // 6. MEMORY MANAGEMENT
  // ==========================================

  @override
  void onClose() {
    // Sirf global text controller ko dispose kiya hai.
    // Quantity controllers ab widgets khud handle kar rahe hain.
    descController.dispose();
    super.onClose();
  }
}
