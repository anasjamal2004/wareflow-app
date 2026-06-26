import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:warehouse_management_system/core/animation/loading_animation_widget.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/widgets/custom_action_dialog.dart';
import 'package:warehouse_management_system/core/widgets/custom_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_floating_action_button.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_toggle_tab.dart';
import 'package:warehouse_management_system/features/orders/features/create_order.dart';
import 'package:warehouse_management_system/features/orders/features/custom_order_card.dart';
import 'package:warehouse_management_system/features/orders/features/order_controller.dart';

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
                    return Center(
                      child: CustomText(
                        text: "No orders found",
                        color: AppTheme.current.textSecondary,
                      ),
                    );
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
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          getXController.clearFields();
          CustomActionDialog.show(
            context: context,
            title: 'CREATE ORDER',
            content: CreateOrder(),
            actionButton: Obx(
              () => CustomButton(
                text: "ADD",
                isLoading: Get.find<OrderController>().isLoading.value,
                color: AppTheme.current.button,
                textColor: AppTheme.current.textPrimary,
                onPressed: () async {
                  if (Get.find<OrderController>().isLoading.value) return;
                  await Get.find<OrderController>().submitOrder();
                },
              ),
            ),
          );
        },
        icon: LucideIcons.shoppingCart,
      ),
    );
  }
}
