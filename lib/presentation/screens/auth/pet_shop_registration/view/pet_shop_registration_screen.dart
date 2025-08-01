import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class PetShopRegistrationScreen extends StatelessWidget {
   PetShopRegistrationScreen({super.key});

  final _authController = GetControllers.instance.getAuthController();
  /*final _profileController = GetControllers.instance.getProfileController();*/
  final _petShopRegistrationController = GetControllers.instance.getPetShopRegistrationController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: CustomText(
          text: "Pet shop Registration",
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
              CustomAlignText(text: "Pet Shop Name", fontWeight: FontWeight.w500),
              Gap(8.0),
              CustomTextField(
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 10,
                fillColor: Colors.white,
                hintText: "Enter your pet shop name",
                keyboardType: TextInputType.text,
                textEditingController: _authController.businessName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pet shop name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null; // Valid
                },
              ),
           /*   Gap(14),
              CustomAlignText(
                text: AppStrings.businessType,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _petShopRegistrationController.analystType.map((item) {
                          final isSelected = _petShopRegistrationController.selectedAnalystTypes.contains(item);
                          return CheckboxListTile(
                            title: Text(item),
                            value: isSelected,
                            onChanged: (_) {
                              _petShopRegistrationController.toggleSelection(item);
                            },
                          );
                        }).toList(),
                      ));
                    },
                  );
                },
                child: Obx(() {
                  final selected = _petShopRegistrationController.selectedAnalystTypes.join(', ');
                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.purple500),
                      ),
                      hintText: "Select business types",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    child: Text(
                      selected.isEmpty ? "Select business types" : selected,
                      style: TextStyle(
                        color: selected.isEmpty ? AppColors.purple500 : AppColors.blackColor,
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
              ),*/

              Gap(14),
              CustomAlignText(
                text: AppStrings.businessAddress,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              CustomTextField(
                textEditingController: _authController.address,
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 10,
                fillColor: Colors.white,
                hintText: "Enter your address",
                keyboardType: TextInputType.text,
              ),
              Gap(14),
              CustomAlignText(
                text: "Website link",
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              CustomTextField(
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 10,
                fillColor: Colors.white,
                hintText: "website link",
                keyboardType: TextInputType.visiblePassword,
                textEditingController: _authController.website,
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
                textEditingController: _authController.moreInfo,
              ),
              Gap(14),
              CustomAlignText(
                text: "Shop logo ",
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              GestureDetector(
                onTap: _authController.shopLogo,
                child: SizedBox(
                  height: 156.h,
                  width: double.infinity,
                  child: Obx(() {
                    final image = _authController.selectedLogo.value?.path;
                    return Stack(
                      children: [
                        Positioned.fill(
                          child:
                          image != null && image.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              File(
                                _authController
                                    .selectedLogo
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
              CustomAlignText(
                text: "Shop pic ",
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              GestureDetector(
                onTap: _authController.shopPic,
                child: SizedBox(
                  height: 156.h,
                  width: double.infinity,
                  child: Obx(() {
                    final image = _authController.selectedPic.value?.path;
                    return Stack(
                      children: [
                        Positioned.fill(
                          child:
                          image != null && image.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              File(
                                _authController
                                    .selectedPic
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
              Gap(16),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        // Toggling the rememberMe value
                        _authController.rememberMe.value =
                        !_authController.rememberMe.value;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 16.h,
                        width: 16.w,
                        decoration: BoxDecoration(
                          color:
                          _authController.rememberMe.value
                              ? AppColors.purple500
                              : Colors.transparent,
                          border: Border.all(
                            width: .5.sp,
                            color: AppColors.secondPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        child: Center(
                          child:
                          _authController.rememberMe.value
                              ? Icon(
                            Icons.check,
                            color: AppColors.whiteColor,
                            size: 14.sp,
                          )
                              : const SizedBox(),
                        ),
                      ),
                    );
                  }),
                  Gap(6),
                  RichText(
                    text: TextSpan(
                      text: 'I agree to return Policies ,',
                      style: TextStyle(
                        color: AppColors.secondTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: " terms and conditions.",
                          style: TextStyle(
                            color: AppColors.purple500,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.route.pushNamed(
                                RoutePath.termsOfCondition,
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(24),
              Obx(() {
                return CustomButton(
                  isLoading: _authController.loginLoading.value,
                  title: " Continue   ",
                  textColor: Colors.black,
                  showIcon: false,
                  onTap: () {
                    if(_authController.rememberMe.value){
                      if (_formKey.currentState!.validate()) {
                        _authController.petShopRegistration();
                      }
                    }else{
                      toastMessage(message:"Please agree trems and conditions");
                    }

       /*        AppRouter.route.goNamed(RoutePath.subscriptionScreen);*/
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
