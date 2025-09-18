import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

import 'widgets/button_section_all.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = GetControllers.instance.getProfileController();
  final controller = GetControllers.instance.getNavigationControllerMain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          profileController.userProfile();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: kToolbarHeight,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CustomText(text: "Profile", fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)],
              ),
            ),

            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Obx(() {
                  final image = profileController.profile.value.user?.profilePic;
                  print("Profile Image: ${ApiUrl.imageBase}$image");

                  return image != null && image.isNotEmpty
                      ? CustomNetworkImage(imageUrl: "${ApiUrl.imageBase}$image", width: double.infinity, height: double.infinity)
                      : CustomNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',

                        width: double.infinity,
                        height: double.infinity,
                      );
                }),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  children: [
                    Obx(() {
                      switch (profileController.loading.value) {
                        case Status.loading:
                          return Center(child: CircularProgressIndicator());
                        case Status.error:
                          return Center(
                            child: ErrorCard(
                              onTap: () {
                                profileController.userProfile();
                              },
                            ),
                          );
                        case Status.internetError:
                          return Center(
                            child: NoInternetCard(
                              onTap: () {
                                profileController.userProfile();
                              },
                            ),
                          );
                        case Status.noDataFound:
                          return Center(
                            child: MoreDataErrorCard(
                              onTap: () {
                                profileController.userProfile();
                              },
                            ),
                          );
                        case Status.completed:
                          final item = profileController.profile.value.user;
                          if (item == null) {
                            return Center(
                              child: NoDataCard(
                                onTap: () {
                                  profileController.userProfile();
                                },
                              ),
                            );
                          }
                          return Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(text: item.name ?? "", fontSize: 22, fontWeight: FontWeight.w700),
                                      GestureDetector(
                                        onTap: () {
                                          AppRouter.route.pushNamed(
                                            RoutePath.editProfileScreen,
                                            extra: {"name": item.name ?? "", "phoneNumber": item.phone ?? "", "address": item.address ?? ""},
                                          );
                                        },
                                        child: Card(
                                          shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: AppColors.purple500, width: 1),
                                          ),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                CustomText(text: "Edit Profile", fontWeight: FontWeight.w400, fontSize: 12),
                                                Gap(6),
                                                Icon(Iconsax.edit, size: 20, color: AppColors.purple500),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(16),
                                  Row(
                                    children: [
                                      Assets.icons.emailicon.svg(),
                                      Gap(6),
                                      CustomText(text: item.email ?? "", fontWeight: FontWeight.w400, fontSize: 14),
                                    ],
                                  ),
                                  Gap(16),
                                  Row(
                                    children: [
                                      Assets.icons.phoneicon.svg(),
                                      Gap(6),
                                      CustomText(text: item.phone ?? "", fontWeight: FontWeight.w400, fontSize: 14),
                                    ],
                                  ),
                                  Gap(16),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 20, color: AppColors.purple500),
                                      Gap(6),
                                      CustomText(text: item.address ?? "", fontWeight: FontWeight.w400, fontSize: 14),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                      }
                    }),

                    Gap(16),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24),
                      child: Column(
                        children: [
                          ButtonSectionAll(
                            icon: Assets.icons.myappointmenticon.svg(),
                            text: AppStrings.myAppointments,
                            onTap: () {
                              AppRouter.route.pushNamed(RoutePath.myAppointmentScreen);
                            },
                          ),

                          ButtonSectionAll(
                            icon: Assets.icons.mypeticon.svg(colorFilter: ColorFilter.mode(AppColors.purple500, BlendMode.srcIn)),
                            text: AppStrings.myPets,
                            onTap: () {
                              controller.selectedNavIndex.value = 3;
                            },
                          ),

                          ButtonSectionAll(
                            icon: Assets.icons.addpeticon.svg(),
                            text: AppStrings.addPet,
                            onTap: () {
                              AppRouter.route.pushNamed(RoutePath.addPetScreen);
                            },
                          ),

                          ButtonSectionAll(
                            icon: Assets.icons.chaticon.svg(colorFilter: ColorFilter.mode(AppColors.purple500, BlendMode.srcIn)),
                            text: AppStrings.chat,
                            onTap: () {
                              controller.selectedNavIndex.value = 2;
                            },
                          ),

                          ButtonSectionAll(
                            icon: Assets.icons.settingicon.svg(),
                            text: AppStrings.settings,
                            onTap: () {
                              AppRouter.route.pushNamed(RoutePath.settingsPage);
                            },
                          ),

                          ButtonSectionAll(
                            showTrailingIcon: false,
                            icon: Assets.icons.logouticon.svg(),
                            text: AppStrings.signOut,
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
                                      await Future.delayed(Duration(milliseconds: 100));
                                      showCustomAnimatedDialog(
                                        context: context,
                                        title: "Success",
                                        subtitle: "You have been logged out successfully.",
                                        animationSrc: "assets/animation/success.json",
                                        // Path to your Lottie animation
                                        isDismissible: true,
                                        actionButton: [
                                          CustomButton(
                                            height: 36,
                                            width: 100,
                                            onTap: () {
                                              DBHelper().logOut(); // Navigate
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
                          ),
                        ],
                      ),
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
