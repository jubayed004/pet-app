import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'core/dependency/get_it_injection.dart';
import 'core/route/routes.dart';
import 'helper/device_utils/device_utils.dart';
import 'helper/local_db/local_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  initDependencies();
  // RevenueCat API keys
  final apiKey = Platform.isAndroid
      ? "goog_sCftdXMYAurDYVZVoYgBtPyWPbQ"
      : "appl_BXKcaKbTpnefeGGYkxEtmWkSiEL";

  // Configure RevenueCat
  DBHelper dbHelper = DBHelper();
  String userId = await dbHelper.getUserId() ?? "";

  await Purchases.configure(
    PurchasesConfiguration(apiKey)..appUserID = userId,
  );

  // Fetch initial customer info
  try {
    final customerInfo = await Purchases.getCustomerInfo();
    debugPrint("🔹 Initial Customer Info: ${customerInfo.entitlements.active.keys}");
  } catch (e) {
    debugPrint("❌ Error fetching customer info: $e");
  }

  // Listen for subscription updates
  Purchases.addCustomerInfoUpdateListener((customerInfo) {
    debugPrint("🔔 Subscription Updated: ${customerInfo.entitlements.active.keys}");
  });

  runApp(
    const MyApp(),
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
          routeInformationParser: AppRouter.route.routeInformationParser,
          routerDelegate: AppRouter.route.routerDelegate,
          routeInformationProvider: AppRouter.route.routeInformationProvider,
        );
      },
    );
  }
}