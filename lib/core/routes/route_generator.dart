import 'package:flutter/material.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/features/product_features/add_product.dart';
import 'package:warehouse_management_system/features/start_screen/login_screen/login_screen.dart';
import 'package:warehouse_management_system/features/start_screen/select_warehouse/select_warehouse.dart';
import 'package:warehouse_management_system/features/start_screen/sign_up_screen/sign_up_screen.dart';
import 'package:warehouse_management_system/features/supplier_features/add_supplier.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navigation.dart';
import 'package:warehouse_management_system/features/create_order/create_order.dart';
import 'package:warehouse_management_system/features/inventory/show_inventory.dart';
import 'package:warehouse_management_system/features/product_features/update_product.dart';
import 'package:warehouse_management_system/features/supplier_features/update_supplier.dart';
import 'package:warehouse_management_system/features/suppliers/show_supplier_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case AppRoutes.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case AppRoutes.selectWarehouseScreen:
        return MaterialPageRoute(builder: (context) => SelectWarehouse());
      case AppRoutes.bottomNavigationScreen:
        return MaterialPageRoute(
          builder: (context) => BottomNavigation(),
          settings: settings,
        );
      case AppRoutes.addProductScreen:
        return MaterialPageRoute(builder: (context) => AddProduct());
      case AppRoutes.updateProductScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateProduct(),
          settings: settings,
        );
      case AppRoutes.updateSupplierScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateSupplier(),
          settings: settings,
        );
      case AppRoutes.addSupplierScreen:
        return MaterialPageRoute(builder: (context) => AddSupplier());
      case AppRoutes.createOrderScreen:
        return MaterialPageRoute(builder: (context) => CreateOrder());
      case AppRoutes.showInventoryScreen:
        return MaterialPageRoute(
          builder: (context) => ShowInventory(),
          settings: settings,
        );
      case AppRoutes.showSupplierScreen:
        return MaterialPageRoute(
          builder: (context) => ShowSupplier(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text('Error: Route not found'))),
        );
    }
  }
}
