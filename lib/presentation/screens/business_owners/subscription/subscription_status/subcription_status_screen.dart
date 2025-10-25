/*

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../controller/get_controllers.dart';
import '../../../../../core/custom_assets/assets.gen.dart';
import '../../../../../core/route/route_path.dart';
import '../../../../../core/route/routes.dart';
import '../../../../../helper/dialog/show_custom_animated_dialog.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../widget/back_button/back_button.dart';

class SubscriptionStatusScreen extends StatefulWidget {
  SubscriptionStatusScreen({super.key});

  @override
  State<SubscriptionStatusScreen> createState() =>
      _SubscriptionStatusScreenState();
}

class _SubscriptionStatusScreenState extends State<SubscriptionStatusScreen> {
  final profileController = GetControllers.instance.getProfileController();
  final controller = GetControllers.instance.getSubscriptionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: CustomText(text: "Subscription status",
            fontWeight: FontWeight.w500,
            fontSize: 16,),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 135,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Color(0xfffffbeb),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.white.withAlpha(50), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: Offset(4, 4),
                    ),
                  ]
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(4),

                        ),
                        child:Assets.images.subicon.image(width: 40),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "Your subscription is active until:",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,),
                          CustomText(text: DateFormat('MMMM dd, yyyy').format(
                     */
/*       profileController.profile.value.data
                                ?.subscriptionEndDate ??*//*

                                DateTime.now(),
                          ),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,),

                        ],
                      ),

                    ],
                  ),
                  Positioned(
                      right: -30,
                      bottom: -30,
                      child: Assets.images.subicon2.image(width: 145)
                  )
                ],
              ),
            ),
            Gap(20),
            CustomText(text: "subscription Type",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              bottom: 8,),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none,
                    gapPadding: 100
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomText(
                    text: */
/*profileController.profile.value.data?.subscriptionPlan
                        ?.subscriptionType ??*//*
 "Gold",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    textAlign: TextAlign.start,
                    color: AppColors.secondTextColor,),
                ),
              ),
            ),
            CustomText(text: "Last Purchase Date",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              bottom: 8,
              top: 8,),
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 2,
            color: Colors.white,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide.none,
                gapPadding: 100
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomText(
                text: DateFormat('MMMM dd, yyyy').format(
                  */
/*  profileController.profile.value.data
                            ?.subscriptionStartDate ?? *//*
DateTime.now(),
                ),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                textAlign: TextAlign.start,
                color: AppColors.secondTextColor,),
            ),
          ),
        ),
           */
/* Obx(() {
              return
            }),*//*

            CustomText(text: "Subscription Expiry Date",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              bottom: 8,
              top: 8,),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none,
                    gapPadding: 100
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomText(text: DateFormat('MMMM dd, yyyy').format(
                    */
/*  profileController.profile.value.data
                          ?.subscriptionEndDate ??*//*

                    DateTime.now(),
                  ),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    textAlign: TextAlign.start,
                    color: AppColors.secondTextColor,),
                ),
              ),
            ),
        */
/*    Obx(() {
    *//*
*/
/*          print(profileController.profile.value.data?.subscriptionEndDate);*//*
*/
/*
              return ;
            }),*//*

            Gap(20),
            CustomButton(
              onTap: () {
                showCustomAnimatedDialog(
                  animationSrc: "assets/images/warning.png",
                  context: context,
                  title: "Warning",
                  subtitle: "Would you like to renew your subscription now to avoid interruption?",
                  actionButton: [
                    CustomButton(
                      width: double.infinity,
                      height: 36,
                      fillColor: Colors.white,
                      // White background
                      borderWidth: 1,
                      // Border width
                      borderColor: AppColors.greenColor,
                      // Border color (black)
                      onTap: () {
                        AppRouter.route.pop();
                      },
                      textColor: AppColors.greenColor,
                      title: "Cancel",
                      isBorder: true,
                      fontSize: 14, // Ensure the border is visible
                    ),
                    CustomButton(
                      width: double.infinity,
                      height: 36,
                      onTap: () async {
                        AppRouter.route.pop();
                        showCustomAnimatedDialog(
                          context: context,
                          title: "Success",
                          subtitle: "Your password has been changed successfully.",
                          animationSrc: "assets/animation/success.json",  // Path to your Lottie animation
                          isDismissible: true,
                          actionButton: [
                            CustomButton(
                              height: 36,
                              width: 100,
                              onTap: () {
                         */
/*       final play =  profileController.profile.value.data?.subscriptionPlan?.id;
                                print(play);
                                if(play != null){
                                  controller.paymentUrl(subscriptionId: play);
                                }*//*

                                AppRouter.route.pop();
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
              },
              title: " Renew subscription",
            ),
            Gap(20),
            CustomButton(
              onTap: () {
                showCustomAnimatedDialog(
                  animationSrc: "assets/images/warning.png",
                  context: context,
                  title: "Warning",
                  subtitle: "Are you sure you want to change your subscription plan?",
                  actionButton: [
                    CustomButton(
                      width: double.infinity,
                      height: 36,
                      fillColor: Colors.white,
                      // White background
                      borderWidth: 1,
                      // Border width
                      borderColor: AppColors.greenColor,
                      // Border color (black)
                      onTap: () {
                        AppRouter.route.pop();
                      },
                      textColor: AppColors.greenColor,
                      title: "Cancel",
                      isBorder: true,
                      fontSize: 14, // Ensure the border is visible
                    ),
                    CustomButton(
                      width: double.infinity,
                      height: 36,
                      onTap: () async {
                        AppRouter.route.pop();
                     AppRouter.route.pushNamed(RoutePath.changeSubscriptionScreen);
                      },
                      title: " Confirm",
                      fontSize: 14,
                    ),
                  ],
                );
              },
              title: "Change subscription",
              fillColor: Colors.white,
              isBorder: true,
              textColor: AppColors.greenColor,
            ),
          ],
        ),
      ),
    );
  }
}
*/
