import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/service/socket_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'core/dependency/get_it_injection.dart';
import 'core/route/routes.dart';
import 'helper/device_utils/device_utils.dart';
import 'package:device_preview/device_preview.dart';

import 'helper/local_db/local_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();

  initDependencies();

  // RevenueCat live API key
  final liveApiKey = Platform.isAndroid
      ? "goog_sCftdXMYAurDYVZVoYgBtPyWPbQ"
      : "appl_BXKcaKbTpnefeGGYkxEtmWkSiEL";

  // Configure RevenueCat
  DBHelper dbHelper = DBHelper();
  String userId = await dbHelper.getUserId() ?? "";
  await Purchases.configure(PurchasesConfiguration(liveApiKey)..appUserID = userId);

  // Fetch initial customer info
  final customerInfo = await Purchases.getCustomerInfo();
  debugPrint("🔹 Initial Customer Info: $customerInfo");

  // Listen for subscription updates
  Purchases.addCustomerInfoUpdateListener((customerInfo) {
    debugPrint("🔔 RevenueCat Customer Info Updated: $customerInfo");
  });



  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
     /* MyApp()*/
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          // Route Section
          routeInformationParser: AppRouter.route.routeInformationParser,
         routerDelegate: AppRouter.route.routerDelegate,
          routeInformationProvider: AppRouter.route.routeInformationProvider,
        );
      },
    );
  }
}
