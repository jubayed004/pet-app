
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/helper/extension/base_extension.dart';
import 'package:pet_app/my_textscreen.dart';
import 'package:pet_app/presentation/screens/add_pet/view/add_pet_screen.dart';
import 'package:pet_app/presentation/screens/auth/forgot/forgot_pass.dart';
import 'package:pet_app/presentation/screens/auth/otp/verify_otp_screen.dart';
import 'package:pet_app/presentation/screens/auth/password/set_new_password.dart';
import 'package:pet_app/presentation/screens/auth/pet_registration/pet_registration_screen.dart';
import 'package:pet_app/presentation/screens/auth/pet_shop_registration/view/pet_shop_registration_screen.dart';
import 'package:pet_app/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:pet_app/presentation/screens/auth/sign_up/sign_up.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/view/business_all_pets_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_nav/business_navigation_page.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/business_add_service/view/business_add_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/business_add_service/view/business_edit_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/view/business_service_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_shop_profile/view/business_shop_profile_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/change_subscription/change_subscription_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/subscription_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/subscription_status/subcription_status_screen.dart';
import 'package:pet_app/presentation/screens/category/book_an_appointment/view/book_an_appointment_screen.dart';
import 'package:pet_app/presentation/screens/category/book_an_appointment/view/congratulation_screen.dart';
import 'package:pet_app/presentation/screens/category/category_details/view/category_details_screen.dart';
import 'package:pet_app/presentation/screens/category/service/view/service_screen.dart';
import 'package:pet_app/presentation/screens/category/view/category_screen.dart';
import 'package:pet_app/presentation/screens/chat/view/chatting_page.dart';
import 'package:pet_app/presentation/screens/faq/help_faq_screen.dart';
import 'package:pet_app/presentation/screens/my_appointment/view/my_appointment_screen.dart';
import 'package:pet_app/presentation/screens/my_pets/edit_my_pets/edit_my_pets_screen.dart';
import 'package:pet_app/presentation/screens/nav/navigation_page.dart';
import 'package:pet_app/presentation/screens/notify/view/notify_screen.dart';
import 'package:pet_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pet_app/presentation/screens/other/terms_of_condition.dart';
import 'package:pet_app/presentation/screens/pet_health/view/pet_health_screen.dart';
import 'package:pet_app/presentation/screens/profile/change_password_page.dart';
import 'package:pet_app/presentation/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:pet_app/presentation/screens/profile/help_center_screen.dart';
import 'package:pet_app/presentation/screens/profile/privacy_policy.dart';
import 'package:pet_app/presentation/screens/profile/settings_page.dart';
import 'package:pet_app/presentation/screens/search/search_screen.dart';
import 'package:pet_app/presentation/screens/splash/splash_screen.dart';
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
        pageBuilder: (context, state) => _buildPageWithAnimation(child: SplashScreen(), state: state),
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
            (context, state) =>
                _buildPageWithAnimation(child: PetRegistrationScreen(), state: state),
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
        pageBuilder: (context, state){
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return _buildPageWithAnimation(
            child: VerifyOtpScreen(email: extra["email"] as String? ?? "", isSignUp: extra["isSignUp"] as bool? ?? false,),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.setNewPassword,
        path: RoutePath.setNewPassword.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: SetNewPassword(email: state.extra as String),
              state: state,
            ),
      ),
      ///======================= Navigation Route =======================
      GoRoute(
        name: RoutePath.navigationPage,
        path: RoutePath.navigationPage.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: NavigationPage(
                index: state.extra != null && (state.extra is int) ? state.extra as int : 0,
              ),
              state: state,
            ),
      ),
      ///======================= Massage Route =======================
      GoRoute(
        name: RoutePath.chatScreen,
        path: RoutePath.chatScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: ChatScreen(),
              state: state,
            ),
      ),
      ///======================= MY Pets Route =======================

      GoRoute(
        name: RoutePath.editMyPetsScreen,
        path: RoutePath.editMyPetsScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
          child: EditMyPetsScreen(),
          state: state,
        ),
      ),

      GoRoute(
        name: RoutePath.editProfileScreen,
        path: RoutePath.editProfileScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child:  EditProfileScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.addPetScreen,
        path: RoutePath.addPetScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child:  AddPetScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.petHealthScreen,
        path: RoutePath.petHealthScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child:  PetHealthScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.settingsPage,
        path: RoutePath.settingsPage.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child:  SettingsPage(),
              state: state,
            ),
      ),

      ///======================= Category Route =======================
      GoRoute(
        name: RoutePath.categoryScreen,
        path: RoutePath.categoryScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
          child:  CategoryScreen(),
          state: state,
        ),
      ),
      GoRoute(
        name: RoutePath.categoryDetailsScreen,
        path: RoutePath.categoryDetailsScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
          child: CategoryDetailsScreen(),
          state: state,
        ),
      ),
      GoRoute(
        name: RoutePath.serviceScreen,
        path: RoutePath.serviceScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
          child: ServiceScreen(),
          state: state,
        ),
      ),
      GoRoute(
        name: RoutePath.bookAnAppointmentScreen,
        path: RoutePath.bookAnAppointmentScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
          child: BookAnAppointmentScreen(),
          state: state,
        ),
      ),
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
          child:  MyAppointmentScreen(),
          state: state,
        ),
      ),
      ///======================= Notify Route =======================
      GoRoute(
        name: RoutePath.notifyScreen,
        path: RoutePath.notifyScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: const NotifyScreen(),
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
            (context, state) => _buildPageWithAnimation(
              child: HelpFaqScreen(),
              state: state,
            ),
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

      GoRoute(
        name: RoutePath.subscriptionStatusScreen,
        path: RoutePath.subscriptionStatusScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: SubscriptionStatusScreen(),
              state: state,
            ),
      ),

      GoRoute(
        name: RoutePath.changeSubscriptionScreen,
        path: RoutePath.changeSubscriptionScreen.addBasePath,
        pageBuilder:
            (context, state) => _buildPageWithAnimation(
              child: ChangeSubscriptionScreen(),
              state: state,
            ),
      ),
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
            (context, state) => _buildPageWithAnimation(
              child: BusinessServiceScreen(),
              state: state,
            ),
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
            (context, state) => _buildPageWithAnimation(
              child: BusinessEditServiceScreen(),
              state: state,
            ),
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
