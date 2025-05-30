import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

import 'widgets/button_section_all.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = GetControllers.instance.getProfileController();
  final _controller = GetControllers.instance.getMyPetsProfileController();
  final controller = GetControllers.instance.getNavigationControllerMain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          // profileController.getProfile();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: kToolbarHeight,
              centerTitle: true,
              title: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40.w,),
                    CustomText(
                      text: "Pixel Posse",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    _controller.selectedImage.value != null
                        ? ClipOval(
                      child: Image.file(
                        File(_controller.selectedImage.value!.path),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    )
                        : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                      ),
                    ),
                  ],
                );
              }),
            ),

            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Obx(() {
                  return profileController.selectedImage.value != null
                      ? Image.file(
                    File(profileController.selectedImage.value!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                      : Image.network(
                    'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                }),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Pixel Posse",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    AppRouter.route.pushNamed(RoutePath.editProfileScreen);
                                  },
                                  child: Card(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColors.purple500,width: 1),
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          CustomText(text: "Edit Profile",fontWeight: FontWeight.w400,fontSize: 12,),
                                          Gap(6),
                                          Icon(Icons.edit_outlined,size: 20,color: AppColors.purple500,)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Assets.icons.emailicon.svg(),
                                Gap(6),
                                CustomText(
                                  text: "pixelposse@gmail.com",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            Gap(16),
                            Row(
                              children: [
                                Assets.icons.phoneicon.svg(),
                                Gap(6),
                                CustomText(
                                  text: "0758519048",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            Gap(16),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,size: 20,color: AppColors.purple500,),
                                Gap(6),
                                CustomText(
                                  text: "123 Main Street, Dhaka, Bangladesh",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(16),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24),
                      child: Column(
                        children: [

                          ButtonSectionAll(
                              icon: Assets.icons.myappointmenticon.svg(),
                              text: AppStrings.myAppointments,
                            onTap: () {  },),

                          ButtonSectionAll(
                              icon: Assets.icons.mypeticon.svg(colorFilter:ColorFilter.mode(AppColors.purple500, BlendMode.srcIn)),
                              text: AppStrings.myPets,
                            onTap: () {  },),

                          ButtonSectionAll(
                              icon: Assets.icons.addpeticon.svg(),
                              text: AppStrings.addPet,
                            onTap: () {  },),

                          ButtonSectionAll(
                              icon: Assets.icons.chaticon.svg(colorFilter:ColorFilter.mode(AppColors.purple500, BlendMode.srcIn)),
                              text: AppStrings.chat,
                            onTap: () {
                              controller.selectedNavIndex.value = 2;
                            },),

                          ButtonSectionAll(
                              icon: Assets.icons.settingicon.svg(),
                              text: AppStrings.settings,
                            onTap: () {  },),

                          ButtonSectionAll(
                            showTrailingIcon: false,
                              icon: Assets.icons.logouticon.svg(),
                              text: AppStrings.signOut,
                            onTap: () {  },),


                        ],
                      ),
                    )
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



