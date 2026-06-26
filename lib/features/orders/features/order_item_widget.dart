import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/model/inventory_model/inventory_model.dart';
import 'package:warehouse_management_system/core/widgets/custom_container.dart';
import 'package:warehouse_management_system/core/widgets/custom_dropdownmenu.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';
import 'package:warehouse_management_system/core/widgets/custom_text_field.dart';
import 'package:warehouse_management_system/features/orders/features/order_controller.dart';

class OrderItemWidget extends StatefulWidget {
  final int index;
  final OrderController controller;

  const OrderItemWidget({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  // 1. Controller ko top par declare kiya
  late TextEditingController quantityTextController;

  @override
  void initState() {
    super.initState();
    // 2. InitState mein sirf EK dafa controller initialize hoga
    final currentItem = widget.controller.cartItems[widget.index];
    quantityTextController = TextEditingController(
      text: currentItem.quantity?.toString() ?? "1",
    );
  }

  @override
  void dispose() {
    // 3. Memory leak se bachne ke liye dispose karna zaroori hai
    quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Jab mein Create Order may class ko call karonga toh waha mein controller or Index ko pass karonga.
    final currentItem = widget.controller.cartItems[widget.index];

    // InventoryData List may jo product id hai usko hum cartItems may jo product id hai us se match karingye. Takay dropdown may display hojae.
    final selectedInventoryProduct = currentItem.productId == null
        ? null
        : widget.controller.inventoryData.firstWhereOrNull(
            (product) => product.id == currentItem.productId,
          );

    return Padding(
      padding: EdgeInsets.all(4),
      child: CustomContainer(
        height: 155.h,
        widget: Column(
          children: [
            // --- DROPDOWN ---
            Obx(() {
              final availableProducts = widget.controller.filteredProduct();

              // 🎯 SAFETY: Check if the currently selected product is still valid for the new supplier
              final bool isProductValid = availableProducts.any(
                (p) => p.id == selectedInventoryProduct?.id,
              );
              return CustomDropdown<InventoryModel>(
                hint: 'Select Product',
                items:
                    availableProducts, // Jo supplier selected hoga sirf usky products show hongye
                selectedValue: isProductValid
                    ? selectedInventoryProduct
                    : null, // Jo user yaha per product select karega
                itemLabel: (product) => product.name ?? "",
                onSelected: (selectedProduct) {
                  widget.controller.cartItems[widget.index].productId =
                      selectedProduct.id;
                  widget.controller.cartItems[widget.index].priceAtOrder =
                      selectedProduct.price;
                  widget.controller.cartItems.refresh();
                },
              );
            }),

            Row(
              children: [
                // --- PRICE FIELD ---
                CustomText(
                  text: 'PRICE: ${currentItem.priceAtOrder?.toString() ?? '0'}',
                  color: AppTheme.current.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),

                SizedBox(width: 5.w),

                // --- QUANTITY FIELD ---
                Expanded(
                  child: CustomTextField(
                    keyboardType: TextInputType.number,
                    controller:
                        quantityTextController, // Ab yeh memory-friendly controller hai
                    label: 'Product Quantity',
                    hintText: '',
                    onChanged: (value) {
                      // value string form may hai usko integer may convert kia hai.
                      int newQuantity = int.tryParse(value) ?? 0;
                      widget.controller.cartItems[widget.index].quantity =
                          newQuantity;

                      // `.refresh()` sirf data update karega, naya controller nahi banaye ga
                      widget.controller.cartItems.refresh();
                    },
                  ),
                ),

                // --- DELETE BUTTON ---
                IconButton(
                  onPressed: () => widget.controller.removeRow(widget.index),
                  icon: const Icon(Icons.delete),
                  color: AppTheme.redColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
