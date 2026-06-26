import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warehouse_management_system/core/constants/theme/app_theme.dart';
import 'package:warehouse_management_system/core/constants/theme/theme_controller.dart';
import 'package:warehouse_management_system/core/routes/app_routes.dart';
import 'package:warehouse_management_system/core/routes/getx_route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const WareHouseManagementSystem());
}

class WareHouseManagementSystem extends StatefulWidget {
  const WareHouseManagementSystem({super.key});

  @override
  State<WareHouseManagementSystem> createState() =>
      _WareHouseManagementSystemState();
}

class _WareHouseManagementSystemState extends State<WareHouseManagementSystem>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Get.forceAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          smartManagement: SmartManagement.full,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppPages.pages,
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppTheme.light.background,
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppTheme.dark.background,
          ),
          themeMode: themeController.systemThemeMode,
          builder: (context, child) {
            return MediaQuery(
              // Ager user ne apne phone per font ka size change kiya huwa hai toh wooh app may change nhi hoga.
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        );
      },
    );
  }
}
