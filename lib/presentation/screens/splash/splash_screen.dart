import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DBHelper dbHelper = serviceLocator();
  @override
  void initState() {
    super.initState();
   checkLoginStatus();
  }



  Future<void> checkLoginStatus() async {
    bool rememberMe = await dbHelper.getRememberMe();
    if (rememberMe == true) {
      final token = await dbHelper.getToken();
      if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
        final role = await dbHelper.getUserRole();
        if (role == "USER") {
          AppRouter.route.goNamed(RoutePath.navigationPage);
        } else {
          AppRouter.route.goNamed(RoutePath.businessNavigationPage);
        }
      } else {
        AppRouter.route.goNamed(RoutePath.onboardingScreen);
      }
    } else {
      final token = await dbHelper.getToken();
      final role = await dbHelper.clearData();

      if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
        if (role == "USER") {
          AppRouter.route.goNamed(RoutePath.navigationPage);
        } else {
          AppRouter.route.goNamed(RoutePath.businessNavigationPage);
        }
      } else {
        AppRouter.route.goNamed(RoutePath.signInScreen);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFe7abcd),
              Color(0xFF91DF92),
            ],
          ),
        ),
        child: Center(child:Assets.images.splashlogo.image(width: 255.w)
        ),
      ),
    );
  }
}
