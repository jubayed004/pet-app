import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessEditServiceScreen extends StatelessWidget {
   BusinessEditServiceScreen({super.key});
  final _profileController = GetControllers.instance.getProfileController();
  final _petShopRegistrationController = GetControllers.instance.getBusinessAddServiceController();
  final _authController = GetControllers.instance.getAuthController();
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "Edit Service",
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: paddingH16V8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Service  Photo",fontWeight: FontWeight.w400,fontSize: 16,),
                  Gap(8),
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
                  Gap(14),
                  CustomText(text: "Service Type",fontWeight: FontWeight.w400,fontSize: 16,),
                  Gap(8),
                  DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.blackColor,), // Default border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color:AppColors.blackColor,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.blackColor, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.blackColor,),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.blackColor,),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: AppColors.blackColor),
                    ),
                    hint: CustomText(
                      text: "select business type",
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    items: _petShopRegistrationController.analystType
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: CustomText(text: item,fontSize: 16,fontWeight: FontWeight.w400),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _petShopRegistrationController.selectedAnalystType.value = value;
                      }
                    },
                    style: TextStyle(color: AppColors.blackColor,fontSize: 16,fontWeight: FontWeight.w400),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_downward_rounded, color: AppColors.blackColor),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.whiteColor,
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  Gap(14),
                  CustomText(text: "Service name",fontWeight: FontWeight.w400,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter service name",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter service name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  Gap(14),
                  CustomText(text: "Location",fontWeight: FontWeight.w400,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter service name",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter service name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  Gap(14),
                  CustomText(text: " Time Duration",fontWeight: FontWeight.w600,fontSize: 16),
                  Gap(14),
                  CustomText(text: "Opening time",fontWeight: FontWeight.w500,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter opening time",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter opening time';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  Gap(14),
                  CustomText(text: "Closing  time",fontWeight: FontWeight.w500,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter closing time",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter closing time';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  Gap(14),
                  CustomText(text: "Off day",fontWeight: FontWeight.w500,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter off day ",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter off day ';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),
                  Gap(14),
                  CustomText(text: "Website Link",fontWeight: FontWeight.w500,fontSize: 16),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "link here",
                    keyboardType: TextInputType.text,
                    textEditingController: _authController.nameSignUp,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'link here';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null; // Valid
                    },
                  ),

                  Gap(24),
                  CustomButton(onTap: (){
                 AppRouter.route.pop(RoutePath.businessServiceScreen);
                  },title: "Update service",textColor: Colors.black)

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
