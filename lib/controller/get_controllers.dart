import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/auth/controller/auth_controller.dart';
import 'package:pet_app/presentation/screens/category/book_an_appointment/controller/book_an_appointment_controller.dart';
import 'package:pet_app/presentation/screens/category/category_details/controller/category_details_controller.dart';
import 'package:pet_app/presentation/screens/category/controller/category_controller.dart';
import 'package:pet_app/presentation/screens/category/service/controller/service_controller.dart';
import 'package:pet_app/presentation/screens/chat/chat_controller/message_controller.dart';
import 'package:pet_app/presentation/screens/home/controller/home_controller.dart';
import 'package:pet_app/presentation/screens/my_appointment/controller/my_appointment_controller.dart';
import 'package:pet_app/presentation/screens/my_pets/controller/my_pets_controller.dart';
import 'package:pet_app/presentation/screens/nav/controller/navigation_controller.dart';
import 'package:pet_app/presentation/screens/onboarding/controller/onboarding_controller.dart';
import 'package:pet_app/presentation/screens/other/controller/other_controller.dart';
import 'package:pet_app/presentation/screens/profile/controller/profile_controller.dart';
import 'package:pet_app/presentation/screens/search/controller/search_screen_controller.dart';


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
AuthController getAuthController() {
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

/*
  FaqController getFaqController() {
    if (!Get.isRegistered<FaqController>()) {
      Get.put(FaqController());
    }
    return Get.find<FaqController>();
  }
*/


  ProfileController getProfileController() {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    return Get.find<ProfileController>();
  }

  MyPetsProfileController getMyPetsProfileController() {
    if (!Get.isRegistered<MyPetsProfileController>()) {
      Get.put(MyPetsProfileController());
    }
    return Get.find<MyPetsProfileController>();
  }

  HomeController getHomeController() {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }
    return Get.find<HomeController>();
  }

  MyAppointmentController getMyAppointmentController() {
    if (!Get.isRegistered<MyAppointmentController>()) {
      Get.put(MyAppointmentController());
    }
    return Get.find<MyAppointmentController>();
  }

  CategoryController getCategoryController() {
    if (!Get.isRegistered<CategoryController>()) {
      Get.put(CategoryController());
    }
    return Get.find<CategoryController>();
  }

  CategoryDetailsController getCategoryDetailsController() {
    if (!Get.isRegistered<CategoryDetailsController>()) {
      Get.put(CategoryDetailsController());
    }
    return Get.find<CategoryDetailsController>();
  }


  ServiceController getServiceController() {
    if (!Get.isRegistered<ServiceController>()) {
      Get.put(ServiceController());
    }
    return Get.find<ServiceController>();
  }


  BookAnAppointmentController getBookAnAppointmentController() {
    if (!Get.isRegistered<BookAnAppointmentController>()) {
      Get.put(BookAnAppointmentController());
    }
    return Get.find<BookAnAppointmentController>();
  }

  MessageController getMessageController() {
    if (!Get.isRegistered<MessageController>()) {
      Get.put(MessageController());
    }
    return Get.find<MessageController>();
  }

  SearchScreenController getSearchScreenController() {
    if (!Get.isRegistered<SearchScreenController>()) {
      Get.put(SearchScreenController());
    }
    return Get.find<SearchScreenController>();
  }

/*
  NotifyController getNotifyController() {
    if (!Get.isRegistered<NotifyController>()) {
      Get.put(NotifyController());
    }
    return Get.find<NotifyController>();
  }*/
}
