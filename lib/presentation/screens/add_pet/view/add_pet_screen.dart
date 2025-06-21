import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class AddPetScreen extends StatelessWidget {
   AddPetScreen({super.key});
  final _authController = GetControllers.instance.getAuthController();
  final _profileController = GetControllers.instance.getProfileController();
   final controller = GetControllers.instance.getNavigationControllerMain();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: CustomText(
          text: AppStrings.addPet,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomAlignText(text: "Pet Name", fontWeight: FontWeight.w500),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: "Enter your pet name",
                  keyboardType: TextInputType.text,
                  textEditingController: _authController.nameSignUp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null; // Valid
                  },
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.age,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  hintText: AppStrings.enterAge,
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.phone,
                  textEditingController: _authController.emailSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.gender,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  textEditingController: _authController.phoneNumberSignUp,
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterGender,
                  keyboardType: TextInputType.text,
                ),

                Gap(14),

                CustomAlignText(
                  text: AppStrings.weight,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterWight,

                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.passwordSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.height,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterHeight,

                  keyboardType: TextInputType.visiblePassword,
                  textEditingController: _authController.confirmPasswordSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.color,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterColor,

                  keyboardType: TextInputType.text,
                  textEditingController: _authController.confirmPasswordSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.breed,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterPetBreed,

                  keyboardType: TextInputType.text,
                  textEditingController: _authController.confirmPasswordSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.moreInfo,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                CustomTextField(
                  fieldBorderColor: AppColors.purple500,
                  fieldBorderRadius: 10,
                  fillColor: Colors.white,
                  hintText: AppStrings.enterMoreInformation,

                  keyboardType: TextInputType.text,
                  textEditingController: _authController.confirmPasswordSignUp,
                ),
                Gap(14),
                CustomAlignText(
                  text: AppStrings.petPhoto,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.0),
                GestureDetector(
                  onTap: _profileController.pickImage,
                  child: SizedBox(
                    height: 156.h,
                    width: double.infinity,
                    child: Obx(() {
                      final image = _profileController.selectedImage.value?.path;
                      return Stack(
                        children: [
                          Positioned.fill(
                            child:
                            image != null && image.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(
                                  _profileController
                                      .selectedImage
                                      .value
                                      ?.path ??
                                      "",
                                ),
                                height: 156.h,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            )
                                : CustomNetworkImage(
                              imageUrl:
                              "https://www.rawpixel.com/image/12143311/png",
                              height: 156.h,
                              borderRadius: BorderRadius.circular(6),
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          image != null && image.isNotEmpty
                              ? SizedBox()
                              : Center(
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffC2C2C2),
                                  width: 1.w,
                                ),
                                color: AppColors.whiteColor700,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.image_outlined,
                                size: 18.sp,
                                color: AppColors.purple500,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),



                Gap(24),
                Obx(() {
                  return CustomButton(
                    isLoading: _authController.loginLoading.value,
                    title: " Save   ",
                    textColor: Colors.black,
                    showIcon: false,
                    onTap: () {
                      controller.selectedNavIndex.value = 3;
                      AppRouter.route.goNamed(RoutePath.navigationPage);
                    },
                  );
                }),
                Gap(14),
              ],
            ),
          ),
        ),
    );
  }
}
