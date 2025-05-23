/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:betwise_app/helper/image/network_image.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/screens/profile/widgets/profile_box_card.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/show_custom_animated_dialog/show_custon_animated_dialog.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = GetControllers.instance.getProfileController();
final controller = GetControllers.instance.getNavigationControllerMain();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
    centerTitle: true,
          title: CustomText(
            text: "Profile",fontSize: 16,fontWeight: FontWeight.w600,
          ),

      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // profileController.getProfile();
        },
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 16,right: 16,top: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Same as Card's border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Custom shadow color
                      blurRadius: 24,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                          */
/*  SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CustomNetworkImage(imageUrl: profileController.profile.value.data?.??"",)
                              ),
                            ),*//*

                            SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CustomNetworkImage(
                                  imageUrl: "assets/icons/Profileicon.svg",
                                ),
                              ),
                            ),
                             Gap(10),
                            Column(

                              children: [
                                CustomText(
                                  text: "Ely Mohammed",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                Gap(8),
                                Row(

                                  children: [
                                    Assets.icons.alternateEmail.svg(),
                                    Gap(4),
                                    FittedBox(child: CustomText(text: "Marvin@gmail.com",overflow: TextOverflow.ellipsis,maxLines: 2,))
                                  ],
                                ),
                                Gap(8),
                                Row(

                                  children: [
                                    Assets.icons.call.svg(),
                                    Gap(4),
                                    CustomText(text: "(555) 123-4567")
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                     GestureDetector(
                       onTap: (){
                         AppRouter.route.pushNamed(RoutePath.editProfileScreen);
                       },
                       child: Container(
                         padding: EdgeInsets.all(2),
                         decoration:BoxDecoration(
                           borderRadius: BorderRadius.circular(2),
                           color: Colors.white,
                           border: Border.all(color: AppColors.greenColor,width: 1),

                         ),
                         child: GestureDetector(
                           onTap: ()=> AppRouter.route.pushNamed(
                             RoutePath.editProfileScreen,
                           ),
                           child: Row(
                             children: [
                               Assets.icons.edit.svg(width: 14.w),
                               CustomText(text: "Edit Profile ",fontWeight: FontWeight.w500,fontSize: 10,)
                             ],
                           ),
                         ),
                       ),
                     )

                      ],
                    ),

                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileBoxCard(

                      icons: Assets.icons.setting.svg(),
                      text: "Account Setting",
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.settingsScreen);
                      },
                    ),

                    ProfileBoxCard(
                      icons: Assets.icons.givefeedback.svg(),
                      text: "Give Feedback", onTap: () {
                      showCustomAnimatedDialogTwo(
                        context: context,
                        controller: controller,
                      );
                    },
                      //onTap: () => buildShowLanguageDialog(context),
                    ),
                    ProfileBoxCard(
                      icons: Assets.icons.notification.svg(),
                      text: "Notification",
                      onTap: () {
                     controller.selectedNavIndex.value = 2;
                      },
                    ),
                    CustomAlignText(

                      text: "more",
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(8),
                    ProfileBoxCard(
                      icons: Assets.icons.tramCondi.svg(),
                      text: "Terms & Condition",
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.termsOfCondition);
                      },
                    ),
                    ProfileBoxCard(
                      icons: Assets.icons.privacypolice.svg(),
                      text: "Privacy policy",
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.privacyPolicy);
                      },
                    ),
                    ProfileBoxCard(
                      icons: Assets.icons.helpsupport.svg(),
                      text: "Help/Support", onTap: () {
                      AppRouter.route.pushNamed(RoutePath.helpFaqScreen);
                    },

                    ),
                    ProfileBoxCard(
                      icons: Assets.icons.logout.svg(),
                      text: "Log Out",
                      onTap:
                          () {
                            showCustomAnimatedDialog(
                              animationSrc: "assets/images/warning.png",
                              context: context,
                              title: "Warning",
                              subtitle: "Are you sure you want to change your subscription plan?",
                              actionButton: [
                                CustomButton(
                                  width: double.infinity,
                                  height: 36,
                                  fillColor: Colors.white,                 // White background
                                  borderWidth: 1,                          // Border width
                                  borderColor: AppColors.greenColor,               // Border color (black)
                                  onTap: () {
                                    AppRouter.route.pop();
                                  },
                                  textColor: AppColors.greenColor,
                                  title: "Cancel",
                                  isBorder: true,
                                  fontSize: 14,// Ensure the border is visible
                                ),
                                CustomButton(
                                  width: double.infinity,
                                  height: 36,
                                  onTap: ()async{

                                    AppRouter.route.pop();
                                    await Future.delayed(Duration(milliseconds: 100));
                                    showCustomAnimatedDialog(
                                      context: context,
                                      title: "Success",
                                      subtitle: "You have been logged out successfully.",
                                      animationSrc: "assets/animation/success.json",  // Path to your Lottie animation
                                      isDismissible: true,
                                      actionButton: [
                                        CustomButton(
                                          height: 36,
                                          width: 100,
                                          onTap: () {
                                            AppRouter.route.goNamed(RoutePath.signInScreen);  // Navigate
                                          },
                                          title: "Confirm",
                                          fontSize: 14,
                                        ),
                                      ],
                                    );


                                  },
                                  title: " Confirm",
                                  fontSize: 14,

                                ),
                              ],
                            );
                          }

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

*/
