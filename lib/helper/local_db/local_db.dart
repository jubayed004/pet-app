import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_service.dart';

class DBHelper {
  /// ====================== Subscribe  ==================
  Future<void> saveMembership({required bool isAlreadySubscribe}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isAlreadySubscribe', isAlreadySubscribe);
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] Subscribe Error -----------------|📍📍📍|',
      );
    }
  }

  /// ====================== Subscribe ==================
  Future<bool> getMembership() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool('isAlreadySubscribe') ?? false;
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] Subscribe Error -----------------|📍📍📍|',
      );
      return false;
    }
  }

  Future<bool> saveProfile() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool('isAlreadySubscribe') ?? false;
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] Subscribe Error -----------------|📍📍📍|',
      );
      return false;
    }
  }

  Future<bool> getProfile() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool('isAlreadySubscribe') ?? false;
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] Subscribe Error -----------------|📍📍📍|',
      );
      return false;
    }
  }

  /// ====================== Get Token ====================
  Future<String> getToken() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('token') != null) {
        return sharedPreferences.getString('token') ?? "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  /// ====================== Get User ID ==================
  Future<String> getUserId() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('id') != null) {
        return sharedPreferences.getString('id') ?? "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  /// ====================== Get User Role ==================
  Future<String> getUserRole() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('role') != null) {
        return sharedPreferences.getString('role') ?? "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  /// ====================== Get User Role ==================
  Future<String> getUserEmail() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('email') != null) {
        return sharedPreferences.getString('email') ?? "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  /// ====================== Get Is SaveIntro ==================
  Future<bool> getIsSeenIntro() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('intro') != null) {
        return sharedPreferences.getBool('intro') ?? false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// ====================== SaveIntro ==================
  Future<void> saveIntro({required bool isSeen}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('intro', isSeen);
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] Intro Save Error -----------------|📍📍📍|',
      );
    }
  }

  /// ====================== Save User Information ==================
  Future saveUserdata({
    required String token,
    required String id,
    required String email,
    required String role,
    required bool rememberMe,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("token", token);
      sharedPreferences.setBool("rememberMe", rememberMe);
      sharedPreferences.setString("id", id);
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("role", role);
    } catch (e) {
      log.i(
        '|📍📍📍|----------------- [[ DB HELPER ]] USER DATA SAVE ERROR -----------------|📍📍📍|',
      );
    }
  }

  /// ====================== Save User Information ==================
  Future logOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs
          .clear()
          .then((value) async {
            toastMessage(message: "logout_successful");
            AppRouter.route.goNamed(RoutePath.onboardingScreen);
          })
          .onError((error, stack) {
            AppRouter.route.goNamed(RoutePath.onboardingScreen);
          });
    } catch (e) {
      AppRouter.route.goNamed(RoutePath.onboardingScreen);
    }
  }

  Future clearData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (_) {}
  }

  /// ====================== RememberMe ==================
  Future<bool> getRememberMe() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getBool("rememberMe") ?? false;
    } catch (e) {
      return false;
    }
  }
}
