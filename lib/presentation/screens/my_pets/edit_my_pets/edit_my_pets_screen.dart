import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class EditMyPetsScreen extends StatelessWidget {
   EditMyPetsScreen({super.key});
  final controller = GetControllers.instance.getMyPetsProfileController();
   final _authController = GetControllers.instance.getAuthController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: AppColors.blackColor,
            pinned: true,
             backgroundColor: AppColors.primaryColor,
            expandedHeight: 200,
            centerTitle: true,
            title:  CustomText(text: 'Edit My Pet',fontWeight: FontWeight.w600,fontSize: 24,color: AppColors.blackColor,),
            flexibleSpace: FlexibleSpaceBar(
              background:Obx(() {
                return Stack(
                  children: [
                    controller.selectedImage.value != null
                        ? Image.file(
                      File(controller.selectedImage.value!.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                        : Image.network(
                      'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              })
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
              child: Column(
                children: [

                  CustomAlignText(
                    text: AppStrings.petName,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(8.0),
                  CustomTextField(
                    hintText: "Enter your pet name",
                    fieldBorderColor: AppColors.purple500,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    keyboardType: TextInputType.phone,
                    textEditingController: _authController.emailSignUp,
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
                  Gap(24),
                  
                  CustomButton(onTap: (){},title: "Save",textColor: Colors.black,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
