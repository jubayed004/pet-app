import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/helper/extension/base_extension.dart';
import 'package:pet_app/my_textscreen.dart';
import 'package:pet_app/presentation/screens/auth/account_active_otp/account_active_otp_screen.dart';
import 'package:pet_app/presentation/screens/auth/forgot/forgot_pass.dart';
import 'package:pet_app/presentation/screens/auth/otp/verify_otp_screen.dart';
import 'package:pet_app/presentation/screens/auth/password/set_new_password.dart';
import 'package:pet_app/presentation/screens/auth/pet_registration/pet_registration_screen.dart';
import 'package:pet_app/presentation/screens/auth/pet_shop_registration/view/pet_shop_registration_screen.dart';
import 'package:pet_app/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:pet_app/presentation/screens/auth/sign_up/sign_up.dart';
import 'package:pet_app/presentation/screens/business_owners/business_advertisement/view/business_advertisement_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_advertisement/view/details_advertisement_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/view/business_all_pets_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/view/business_pet_details_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/view/health_records_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/view/business_booking_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_nav/business_navigation_page.dart';
import 'package:pet_app/presentation/screens/business_owners/business_profile/view/business_edit_profile.dart';
import 'package:pet_app/presentation/screens/business_owners/business_review/view/business_review_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/view/business_add_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/view/business_edit_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/view/business_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_shop_profile/view/business_shop_profile_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/change_subscription/change_subscription_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/subscription_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/subscription_status/subcription_status_screen.dart';
import 'package:pet_app/presentation/screens/category/book_an_appointment/view/congratulation_screen.dart';
import 'package:pet_app/presentation/screens/category/category_details/view/category_details_screen.dart';
import 'package:pet_app/presentation/screens/category/service/view/service_screen.dart';
import 'package:pet_app/presentation/screens/category/view/category_screen.dart';
import 'package:pet_app/presentation/screens/chat/chat_page.dart';
import 'package:pet_app/presentation/screens/my_appointment/view/my_appointment_details_screen.dart';
import 'package:pet_app/presentation/screens/my_appointment/view/my_appointment_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/pet_health/view/pet_health_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/view/edit_my_pets_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/view/my_details_pets_screen.dart';
import 'package:pet_app/presentation/screens/nav/navigation_page.dart';
import 'package:pet_app/presentation/screens/notify/view/notify_screen.dart';
import 'package:pet_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pet_app/presentation/screens/profile/add_pet/view/add_pet_screen.dart';
import 'package:pet_app/presentation/screens/profile/change_password_page.dart';
import 'package:pet_app/presentation/screens/profile/edit_profile_screen.dart';
import 'package:pet_app/presentation/screens/profile/faq/help_faq_screen.dart';
import 'package:pet_app/presentation/screens/profile/help_center_screen.dart';
import 'package:pet_app/presentation/screens/profile/privacy_policy.dart';
import 'package:pet_app/presentation/screens/profile/settings_page.dart';
import 'package:pet_app/presentation/screens/profile/terms_of_condition.dart';
import 'package:pet_app/presentation/screens/review/view/review_screen.dart';
import 'package:pet_app/presentation/screens/search/search_screen.dart';
import 'package:pet_app/presentation/screens/splash/splash_screen.dart';
import 'package:pet_app/presentation/screens/subscription/subscription_screen.dart';
import 'package:pet_app/presentation/screens/text_screen/view/text_screen.dart';
import 'package:pet_app/presentation/screens/vendor_selection/vendor_selection_screen.dart';
import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      ///======================= Initial Route =======================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: SplashScreen(), state: state),
      ),
      GoRoute(
        name: RoutePath.onboardingScreen,
        path: RoutePath.onboardingScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: OnboardingScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.vendorSelectionScreen,
        path: RoutePath.vendorSelectionScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: VendorSelectionScreen(),
              state: state,
            ),
      ),

      ///======================= Auth Route =======================
      GoRoute(
        name: RoutePath.signInScreen,
        path: RoutePath.signInScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: SignInScreen(), state: state),
      ),
      GoRoute(
        name: RoutePath.signUpScreen,
        path: RoutePath.signUpScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: SignUpScreen(), state: state),
      ),
      GoRoute(
        name: RoutePath.petRegistrationScreen,
        path: RoutePath.petRegistrationScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: PetRegistrationScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.forgotPassScreen,
        path: RoutePath.forgotPassScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: ForgotPassScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.verifyOtpScreen,
        path: RoutePath.verifyOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra =
              state.extra != null && state.extra is String ? state.extra as String : "";
          return _buildPageWithAnimation(
            child: VerifyOtpScreen(email: extra),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.accountActiveOtpScreen,
        path: RoutePath.accountActiveOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final email = extra['email'] as String;
          return _buildPageWithAnimation(
            child: AccountActiveOtpScreen(
              email: email,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.setNewPassword,
        path: RoutePath.setNewPassword.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};

          return _buildPageWithAnimation(
            child: SetNewPassword(
              email: extra["email"] as String? ?? "",
              code: extra["code"] as String? ?? "",
            ),
            state: state,
          );
        },
      ),

      ///======================= Navigation Route =======================
      GoRoute(
        name: RoutePath.navigationPage,
        path: RoutePath.navigationPage.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: NavigationPage(
                index:
                    state.extra != null && (state.extra is int)
                        ? state.extra as int
                        : 0,
              ),
              state: state,
            ),
      ),

      ///======================= Massage Route =======================
      GoRoute(
        name: RoutePath.chatScreen,
        path: RoutePath.chatScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: ChatScreen(senderId: state.extra as String,), state: state),
      ),

      ///======================= MY Pets Route =======================
      GoRoute(
        name: RoutePath.editMyPetsScreen,
        path: RoutePath.editMyPetsScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String;
          final name = extra['name'] as String;
          final petType = extra['animalType'] as String;
          final age = extra['age'] as String;
          final gender = extra['gender'] as String;
          final weight = extra['weight'] as String;
          final height = extra['height'] as String;
          final color = extra['color'] as String;
          final breed = extra['breed'] as String;
          return _buildPageWithAnimation(
            child: EditMyPetsScreen(
              id: id,
              name: name,
              petType: petType,
              age: age,
              gender: gender,
              weight: weight,
              height: height,
              color: color,
              breed: breed,
            ),

            state: state,
          );
            }
      ),

      GoRoute(
        name: RoutePath.editProfileScreen,
        path: RoutePath.editProfileScreen.addBasePath,
        pageBuilder:
            (context, state) {
          final extra = state.extra as Map<String , dynamic>;
          final name = extra['name'] as String;
          final phoneNumber = extra['phoneNumber'] as String ;
          final address = extra['address'] as String;
          return _buildPageWithAnimation(
            child: EditProfileScreen(
              name: name,
              phoneNumber: phoneNumber
              , address: address,
            ),
            state: state,
          );
            }
      ),

      GoRoute(
        name: RoutePath.addPetScreen,
        path: RoutePath.addPetScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: AddPetScreen(), state: state),
      ),

      GoRoute(
        name: RoutePath.petHealthScreen,
        path: RoutePath.petHealthScreen.addBasePath,
        pageBuilder:
            (context, state) {
          final args = state.extra as String ;
          return _buildPageWithAnimation(
              child: PetHealthScreen(
                id: args,
              ),
              state: state);
            }

      ),

      GoRoute(
        name: RoutePath.settingsPage,
        path: RoutePath.settingsPage.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: SettingsPage(), state: state),
      ),

      GoRoute(
        name: RoutePath.myPetsDetailsScreen,
        path: RoutePath.myPetsDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as String;

          return _buildPageWithAnimation(
            child: MyDetailsPetsScreen(
              id: args,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.businessPetsDetailsScreen,
        path: RoutePath.businessPetsDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as String;
          return _buildPageWithAnimation(
            child: BusinessPetsDetailsScreen(id: args,

            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.healthRecordsScreen,
        path: RoutePath.healthRecordsScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as String;
          return _buildPageWithAnimation(
            child: HealthRecordsScreen( petId: args,
            ),
            state: state,
          );
        },
      ),

      ///======================= Category Route =======================
      GoRoute(
        name: RoutePath.categoryScreen,
        path: RoutePath.categoryScreen.addBasePath,
        pageBuilder:
            (context, state) {
          final args = state.extra as int;
           return   _buildPageWithAnimation(child: CategoryScreen(index: args,), state: state);
            }

      ),
      GoRoute(
        name: RoutePath.categoryDetailsScreen,
        path: RoutePath.categoryDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final haveData = extra != null;

          if (haveData) {
            final data = extra as List;
            final showWebsite = data[0];
            final id = data[1];
            final isShop = data[2];

            return _buildPageWithAnimation(
              child: CategoryDetailsScreen(
                showWebsite: showWebsite,
                id: id,
                isShop: isShop,
              ),
              state: state,
            );
          }
          return _buildPageWithAnimation(
            child: CategoryDetailsScreen(
              showWebsite: false,
              id: "id",
              isShop: false,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.serviceScreen,
        path: RoutePath.serviceScreen.addBasePath,
        pageBuilder: (context, state) {
          final value = state.extra;
          final Map data = value != null && value is Map ? value : {};

          final isHotel = data['isHotel'] as bool? ?? false;
          final id = data['id'] as String? ?? "";
          final businessId = data['businessId'] as String? ?? "";

          debugPrint("🟢 Navigating with id: $id");
          debugPrint("🟢 Navigating with businessId: $businessId");

          return _buildPageWithAnimation(
            child: ServiceScreen(
              showWebsite: isHotel,
              id: id,
              businessId: businessId,
            ),
            state: state,
          );
        },
      ),
/*      GoRoute(
        name: RoutePath.bookAnAppointmentScreen,
        path: RoutePath.bookAnAppointmentScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BookAnAppointmentScreen(
                bookingTime: state.extra != null ? state.extra as bool : false,
              ),
              state: state,
            ),
      ),*/
      GoRoute(
        name: RoutePath.congratulationScreen,
        path: RoutePath.congratulationScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: CongratulationScreen(),
              state: state,
            ),
      ),

      ///======================= MY Appointments Route =======================
      GoRoute(
        name: RoutePath.myAppointmentScreen,
        path: RoutePath.myAppointmentScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: MyAppointmentScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.myAppointmentDetailsScreen,
        path: RoutePath.myAppointmentDetailsScreen.addBasePath,
        pageBuilder:
            (context, state) {
              final args = state.extra as String;
            return  _buildPageWithAnimation(
                child: MyAppointmentDetailsScreen(
                  id: args,
                ),
                state: state,
              );
            }
      ),

      ///======================= Notify Route =======================
      GoRoute(
        name: RoutePath.notifyScreen,
        path: RoutePath.notifyScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child:  NotifyScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.searchScreen,
        path: RoutePath.searchScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: const SearchScreen(),
              state: state,
            ),
      ),
      // GoRoute(
      //   name: RoutePath.checkNotify,
      //   path: RoutePath.checkNotify.addBasePath,
      //   pageBuilder:
      //       (context, state) => _buildPageWithAnimation(
      //         child:  CheckNotify(),
      //         state: state,
      //       ),
      // ),
      ///======================= Other Route =======================
      /*GoRoute(
        name: RoutePath.settingsScreen,
        path: RoutePath.settingsScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: SettingsScreen(), state: state),
      ),*/
      GoRoute(
        name: RoutePath.changePasswordScreen,
        path: RoutePath.changePasswordScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: ChangePasswordScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.privacyPolicy,
        path: RoutePath.privacyPolicy.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: PrivacyPolicy(), state: state),
      ),
      GoRoute(
        name: RoutePath.termsOfCondition,
        path: RoutePath.termsOfCondition.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: TermsOfCondition(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.addToOrderScrreen,
        path: RoutePath.addToOrderScrreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: AddToOrderScrreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.helpFaqScreen,
        path: RoutePath.helpFaqScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: HelpFaqScreen(), state: state),
      ),
      GoRoute(
        name: RoutePath.helpCenterScreen,
        path: RoutePath.helpCenterScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: HelpCenterScreen(),
              state: state,
            ),
      ),

      ///======================= Subscription =======================
      GoRoute(
        name: RoutePath.subscriptionScreen,
        path: RoutePath.subscriptionScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: SubscriptionScreen(),
              state: state,
            ),
      ),

/*
      GoRoute(
        name: RoutePath.subscriptionStatusScreen,
        path: RoutePath.subscriptionStatusScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: SubscriptionStatusScreen(),
              state: state,
            ),
      ),
*/

/*
      GoRoute(
        name: RoutePath.changeSubscriptionScreen,
        path: RoutePath.changeSubscriptionScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: ChangeSubscriptionScreen(),
              state: state,
            ),
      ),
*/

      ///======================= Business Owner =======================
      GoRoute(
        name: RoutePath.petShopRegistrationScreen,
        path: RoutePath.petShopRegistrationScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: PetShopRegistrationScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessNavigationPage,
        path: RoutePath.businessNavigationPage.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessNavigationPage(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessAllPetsScreen,
        path: RoutePath.businessAllPetsScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessAllPetsScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessShopProfileScreen,
        path: RoutePath.businessShopProfileScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessShopProfileScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessServiceScreen,
        path: RoutePath.businessServiceScreen.addBasePath,
        pageBuilder:
            (context, state) {

          return _buildPageWithAnimation(
          child: BusinessServiceScreen(),
            state: state,
          );
            }
      ),
      GoRoute(
        name: RoutePath.businessAddServiceScreen,
        path: RoutePath.businessAddServiceScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessAddServiceScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.businessEditServiceScreen,
        path: RoutePath.businessEditServiceScreen.addBasePath,
        pageBuilder:
            (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              final serviceName = extra['serviceName'] != null && extra['serviceName'] is String ? extra['serviceName'] as String: "";
              final id = extra['id'] as String;
              final phoneNumber = extra['phoneNumber'] as String;
              final location = extra['location'] as String;
              final webSiteLInk = extra['websiteLink'] as String;
              final serviceController = extra['serviceController'] is List<String> ? extra['serviceController'] as List<String> : <String>[];
          return  _buildPageWithAnimation(
            child: BusinessEditServiceScreen(
                serviceName:serviceName,
                phoneNumber: phoneNumber,
                location: location,
                webSiteLInk: webSiteLInk,
              id: id,
              serviceList: serviceController,
            ),
            state: state,
          );
            }
      ),
      GoRoute(
        name: RoutePath.businessBookingScreen,
        path: RoutePath.businessBookingScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessBookingScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessAdvertisementScreen,
        path: RoutePath.businessAdvertisementScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessAdvertisementScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessDetailsAdvertisementScreen,
        path: RoutePath.businessDetailsAdvertisementScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: DetailsAdvertisementScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.businessReviewScreen,
        path: RoutePath.businessReviewScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: BusinessReviewScreen(),
              state: state,
            ),
      ),
      GoRoute(
        name: RoutePath.reviewScreen,
        path: RoutePath.reviewScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, Object>? ?? {};
           final businessId = extra["businessId"] as String;
           final ownerId = extra["ownerId"] as String;
           final serviceId = extra["serviceId"] as String;
          return  _buildPageWithAnimation(
              child: ReviewScreen(
            businessId: businessId,
            ownerId: ownerId,
            serviceId: serviceId,
          ),
              state: state);
            }

      ),
      GoRoute(
        name: RoutePath.businessEditProfileScreen,
        path: RoutePath.businessEditProfileScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: BusinessEditProfileScreen(), state: state),
      ),
      GoRoute(
        name: RoutePath.textScreen,
        path: RoutePath.textScreen.addBasePath,
        pageBuilder:
            (context, state) =>
                _buildPageWithAnimation(child: TextScreen(), state: state),
      ),
    ],
  );

  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}
