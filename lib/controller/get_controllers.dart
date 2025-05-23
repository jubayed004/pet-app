import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/onboarding/controller/onboarding_controller.dart';


class GetControllers {
  static final GetControllers _singleton = GetControllers._internal();

  GetControllers._internal();

  static GetControllers get instance => _singleton;

/*
  LanguageController getLanguageController() {
    if (!Get.isRegistered<LanguageController>()) {
      Get.put(LanguageController(),permanent: true);
    }
    return Get.find<LanguageController>();
  }
*/

  OnboardingController getOnboardingController() {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }
    return Get.find<OnboardingController>();
  }
/*AuthController getAuthController() {
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }
    return Get.find<AuthController>();
  }

  NavigationControllerMain getNavigationControllerMain() {
    if (!Get.isRegistered<NavigationControllerMain>()) {
      Get.put(NavigationControllerMain());
    }
    return Get.find<NavigationControllerMain>();
  }

  OtherController getOtherController() {
    if (!Get.isRegistered<OtherController>()) {
      Get.put(OtherController());
    }
    return Get.find<OtherController>();
  }

  FaqController getFaqController() {
    if (!Get.isRegistered<FaqController>()) {
      Get.put(FaqController());
    }
    return Get.find<FaqController>();
  }


  ProfileController getProfileController() {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    return Get.find<ProfileController>();
  }

  HomeController getHomeController() {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }
    return Get.find<HomeController>();
  }

  SearchScreenController getSearchScreenController() {
    if (!Get.isRegistered<SearchScreenController>()) {
      Get.put(SearchScreenController());
    }
    return Get.find<SearchScreenController>();
  }


  NotifyController getNotifyController() {
    if (!Get.isRegistered<NotifyController>()) {
      Get.put(NotifyController());
    }
    return Get.find<NotifyController>();
  }
}
*/
}