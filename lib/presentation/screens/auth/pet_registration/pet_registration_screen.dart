import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_images/app_images.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class PetRegistrationScreen extends StatefulWidget {

  const PetRegistrationScreen({super.key});

  @override
  State<PetRegistrationScreen> createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {

  final TextEditingController name = TextEditingController();
  final TextEditingController animalType = TextEditingController();
  final TextEditingController breed = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    animalType.dispose();
    breed.dispose();
    age.dispose();
    gender.dispose();
    weight.dispose();
    height.dispose();
    color.dispose();
    description.dispose();
    super.dispose();
  }
  final _authController = GetControllers.instance.getAuthController();
/*  final _profileController = GetControllers.instance.getProfileController();*/
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: CustomText(
          text: AppStrings.petRegistration,
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
                textEditingController: name,
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
                text: AppStrings.petType,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              CustomTextField(
                hintText: AppStrings.petType,
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 10,
                fillColor: Colors.white,
                keyboardType: TextInputType.text,
                textEditingController: animalType,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pet type is required';
                  }
                  if (value.length < 3) {
                    return 'Pet type must be at least 3 characters';
                  }
                  return null;
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
                textEditingController: age,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Age is required';
                  }
                  final age = int.tryParse(value.trim());
                  if (age == null) {
                    return 'Please enter a valid number';
                  }
                  if (age <= 0) {
                    return 'Age must be greater than 0';
                  }
                  return null;
                },
              ),

              Gap(14),
          /*    CustomAlignText(
                text: AppStrings.gender,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),*/
              CustomDropdown(
                onChanged: (value){
                 if( value!=null){
                   _authController.genderSelected.value = value;
                 }
                },
                selectedValue: _authController.genderSelected.value,
                title: AppStrings.gender,
                items: ["MALE", "FEMALE"],
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
                textEditingController: weight,
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
                textEditingController: height,
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
                textEditingController: color,
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
                textEditingController: breed,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pet breed is required';
                  }
                  if (value.trim().length < 2) {
                    return 'Pet breed must be at least 2 characters';
                  }
                  return null;
                },
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
                textEditingController: description,
              ),
              Gap(14),
              CustomAlignText(
                text: AppStrings.petPhoto,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.0),
              GestureDetector(
                onTap: _authController.petPhoto,
                child: SizedBox(
                  height: 156.h,
                  width: double.infinity,
                  child: Obx(() {
                    final image = _authController.selectedPetPhoto.value?.path;
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
                                                .selectedPetPhoto
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
                  isLoading: _authController.petRegistrationUpLoading.value,
                  title: " Continue",
                  textColor: Colors.black,
                  showIcon: false,
                  onTap: () {

                    if(_authController.rememberMe.value){

                      if (_formKey.currentState!.validate()) {
                        final body = {
                          "name": name.text,
                          "animalType": animalType.text,
                          "breed": breed.text,
                          "gender":  _authController.genderSelected.value,
                          "weight": weight.text,
                          "height": height.text,
                          "color": color.text,
                          "age": age.text,
                          "description": description.text,
                        };
                        _authController.petRegistration(body: body);
                      }
                    }else{
                      toastMessage(message:"Please agree trems and conditions");
                    }
                  /*  AppRouter.route.goNamed(RoutePath.navigationPage);*/
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
