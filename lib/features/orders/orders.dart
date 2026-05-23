import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/colors/app_colors.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/widgets/custom_toggle_tab.dart';
import 'package:warehouse_management_system/features/orders/custom_order_card.dart';
import 'package:warehouse_management_system/features/orders/order_controller.dart';

class Orders extends StatelessWidget {
  final OrderController getXController = Get.put(OrderController());
  Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(kToolbarHeight),
      //   child: CustomAppBar(
      //     text: 'Orders',
      //     buttonText: '+ Create Order',
      //     onTap: () {
      //       Navigator.pushNamed(context, AppRoutes.createOrderScreen);
      //     },
      //   ),
      // ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            Obx(
              () => CustomToggleTab(
                leftLabel: "Inbound",
                rightLabel: "Outbound",
                leftIcon: Icons.arrow_downward,
                rightIcon: Icons.arrow_upward,
                selectedIndex: getXController.selectedTab.value,
                onChanged: (index) => getXController.switchTab(index),
              ),
            ),
            SizedBox(height: 10.h),

            Expanded(
              // 👈 Yeh crash rokne ke liye zaroori hai
              child: RefreshIndicator(
                onRefresh: () async => await getXController.fetchOrder(),
                child: Obx(() {
                  // 👈 Taake data aane par list nazar aaye

                  // Filtered list select karo tab ke mutabiq
                  final orders = getXController.selectedTab.value == 0
                      ? getXController.inBoundOrders
                      : getXController.outBoundOrders;

                  if (getXController.isLoading.value) {
                    return const Center(child: LoadingAnimation());
                  }

                  if (orders.isEmpty) {
                    return const Center(child: Text("No Orders Found"));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final currentOrder = orders[index];
                      return CustomOrderCard(
                        order: currentOrder,
                        onStatusChanged: (selectedStatus) {
                          if (selectedStatus != null &&
                              currentOrder.id != null) {
                            getXController.updateOrderStatus(
                              currentOrder.id!,
                              selectedStatus,
                            );
                          }
                        },
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),

        onPressed: () {
          // widget.getXcontroller.clearFields();
          Get.toNamed(AppRoutes.createOrderScreen);
          getXController.clearFields();
        },
      ),
    );
  }
}
