/*
import 'dart:io';
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:betwise_app/helper/image/network_image.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/screens/nav/controller/navigation_controller.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/back_button/back_button.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = GetControllers.instance.getProfileController();
  final controllerNav = GetControllers.instance.getNavigationControllerMain();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(text: "Edit Profile ",fontSize: 16,fontWeight: FontWeight.w500,),
          leading:CustomBackButton(
            onTap: () {
              AppRouter.route.pop();
            },
          )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                   */
/* Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Obx(() {
                          return controller.selectedImage.value != null? Image.file(File(controller.selectedImage.value?.path??""), fit: BoxFit.cover) :
                          CustomNetworkImage(imageUrl: controller.profile.value.data?.profileImage?? "");
                        }),
                      ),
                    ),*//*

                    Positioned(
                      bottom: 10,
                      right: 2,
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                          ),
                          child: Icon(Iconsax.camera, size: 16, color: AppColors.blackColor,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24),
              ///=============================== Full name text ==================================
              CustomAlignText(text: "Name",fontWeight: FontWeight.w500,),
              Gap(8.0),
              CustomTextField(
                fillColor: Colors.white,
                hintText: "Ely Mohammed",
                keyboardType: TextInputType.name,
                textEditingController: controller.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'first_name_is_required';
                  }
                  return null;
                },
              ),

              Gap(14),
              CustomAlignText(text: "Email",fontWeight: FontWeight.w500,),
              Gap(8.0),
              CustomTextField(
              textEditingController: controller.email,
                hintText: "michelle.rivera@example.com",
                fieldBorderColor: AppColors.secondTextColor,
                fieldBorderRadius: 10,
                fillColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                //textEditingController:controller.emailSignUp,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email_is_required';
                  }
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter_a_valid_email';
                  }
                  return null;
                },
              ),
              Gap(14),

              ///=============================== PHONE text ==================================
              CustomAlignText(text: " Contact number",fontWeight: FontWeight.w500,),
              const Gap(8),
              CustomTextField(
                fillColor: Colors.white,
                hintText: "(603) 555-0123",
                keyboardType: TextInputType.number,
                //textEditingController: controller.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'phone_number_is_required';
                  }
                  return null;
                },
              ),
              const Gap(12),


              ///=============================== Sign Up text ==================================
              const Gap(12),
          CustomButton(
            title: "Update",

            isLoading: controller.isUpdateLoading.value,
            onTap: () {
                if (_formKey.currentState!.validate()) {
                      controller.updateProfile();
                    }

              showCustomAnimatedDialog(
                animationSrc: "assets/images/warning.png",
                context: context,
                title: "Warning",
                subtitle: "Are you sure you want to update your profile information?",
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
                        subtitle: "Your profile has been updated successfully.",
                        animationSrc: "assets/animation/success.json",  // Path to your Lottie animation
                        isDismissible: true,
                        actionButton: [
                          CustomButton(
                            height: 36,
                            width: 100,
                            onTap: () {
                              AppRouter.route.pop();
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
          )
            ],
          ),
        ),
      ),
    );
  }
}
*/
