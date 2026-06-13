import 'package:get/get.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/features/bottom_navigation/bottom_navigation.dart';
import 'package:warehouse_management_system/features/create_order/create_order.dart';
import 'package:warehouse_management_system/features/dashboard/dashboard.dart';
import 'package:warehouse_management_system/features/product_features/add_product.dart';
import 'package:warehouse_management_system/features/product_features/update_product.dart';
import 'package:warehouse_management_system/features/start_screen/auth_screen/login_screen/login_screen.dart';
import 'package:warehouse_management_system/features/start_screen/auth_screen/sign_up_screen/sign_up_screen.dart';
import 'package:warehouse_management_system/features/start_screen/select_warehouse/select_warehouse.dart';
import 'package:warehouse_management_system/features/start_screen/splash_screen/splash_screen.dart';
import 'package:warehouse_management_system/features/start_screen/splash_screen/splash_screen_controller.dart';
import 'package:warehouse_management_system/features/supplier_features/add_supplier.dart';
import 'package:warehouse_management_system/features/supplier_features/update_supplier.dart';
import 'package:warehouse_management_system/features/suppliers/show_supplier_detail.dart';
// Apne saare imports yahan dalo (Login, Dashboard, Splash, etc.)

class AppPages {
  // Yeh list GetMaterialApp ko jayegi
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
      // Binding yahan lagane se build method saaf ho jayega!
      binding: BindingsBuilder(() {
        Get.put(SplashScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(
      name: AppRoutes.selectWarehouseScreen,
      page: () => SelectWarehouse(),
    ),
    GetPage(name: AppRoutes.dashboardScreen, page: () => Dashboard()),
    GetPage(
      name: AppRoutes.bottomNavigationScreen,
      page: () => const BottomNavigation(),
      
    ),
    GetPage(name: AppRoutes.addProductScreen, page: () => const AddProduct()),
    GetPage(name: AppRoutes.updateProductScreen, page: () => UpdateProduct()),
    GetPage(name: AppRoutes.addSupplierScreen, page: () => const AddSupplier()),
    GetPage(name: AppRoutes.updateSupplierScreen, page: () => UpdateSupplier()),
    GetPage(name: AppRoutes.createOrderScreen, page: () => CreateOrder()),
    // GetPage(
    //   name: AppRoutes.showInventoryScreen,
    //   page: () => const ShowInventory(),
    // ),
    GetPage(
      name: AppRoutes.showSupplierScreen,
      page: () => const ShowSupplier(),
    ),
  ];
}
