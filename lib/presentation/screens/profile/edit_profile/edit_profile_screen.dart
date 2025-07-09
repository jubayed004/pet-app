import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({super.key});
  final profileController = GetControllers.instance.getProfileController();
  final controller = GetControllers.instance.getNavigationControllerMain();
   final _authController = GetControllers.instance.getAuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: kToolbarHeight,
            centerTitle: true,
            title: CustomText(
              text: "Edit Profile",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SliverAppBar(
            foregroundColor: AppColors.primaryColor,
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 200,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
                background:Obx(() {
                  return Stack(
                    children: [
                      profileController.selectedImage.value != null
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
                      ),


                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              profileController.pickImage();
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
              padding: EdgeInsets.only(left: 16,right: 16,top: 20),
              child: Column(
                children: [

                  CustomAlignText(
                    text: "Name",
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(8.0),
                  CustomTextField(
                    hintText: "Enter your name",
                    fieldBorderColor: AppColors.purple500,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.emailSignUp,
                  ),
                  Gap(16),
                  CustomAlignText(
                    text: "Phone Number",
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(8.0),
                  CustomTextField(
                    isDens: true,
                  /*  prefixIcon: CountryCodePicker(
                      onChanged: (code) {
                        profileController.selectedCountryCode.value = code.dialCode!;
                      },
                      initialSelection: 'BD',
                      favorite: ['+880', 'US', 'IN'],
                      showFlag: true,
                      showDropDownButton: true,
                      alignLeft: false,
                    ),*/
                    hintText: "Enter your phone",
                    fieldBorderColor: AppColors.purple500,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    keyboardType: TextInputType.phone,
                  ),
                  Gap(16),
                  CustomAlignText(
                    text: "Address",
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(8.0),
                  CustomTextField(
                    hintText: "Enter your address",
                    fieldBorderColor: AppColors.purple500,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    keyboardType: TextInputType.streetAddress,
                    textEditingController: _authController.emailSignUp,
                  ),
                  Gap(24),
                  CustomButton(onTap: (){
                    controller.selectedNavIndex.value = 4;
                    AppRouter.route.goNamed(RoutePath.navigationPage);
                  },
                    title: "Save",
                  textColor: Colors.black,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
