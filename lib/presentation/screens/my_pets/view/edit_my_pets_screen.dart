import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class EditMyPetsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String petType;
  final String age;
  final String gender;
  final String weight;
  final String height;
  final String color;
  final String breed;

  const EditMyPetsScreen(
      {super.key, required this.name, required this.age, required this.gender, required this.weight, required this.height, required this.color, required this.petType, required this.breed, required this.id});

  @override
  State<EditMyPetsScreen> createState() => _EditMyPetsScreenState();
}

class _EditMyPetsScreenState extends State<EditMyPetsScreen> {
  final controller = GetControllers.instance.getMyPetsProfileController();
  final navigationController = GetControllers.instance
      .getNavigationControllerMain();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petTypeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController breedController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    petNameController = TextEditingController(text: widget.name);
    petTypeController = TextEditingController(text: widget.petType);
    ageController = TextEditingController(text: widget.age);
    genderController = TextEditingController(text: widget.gender);
    weightController = TextEditingController(text: widget.weight);
    heightController = TextEditingController(text: widget.height);
    colorController = TextEditingController(text: widget.color);
    breedController = TextEditingController(text: widget.breed);
    super.initState();
  }

  @override
  void dispose() {
    petNameController.dispose();
    petTypeController.dispose();
    ageController.dispose();
    genderController.dispose();
    weightController.dispose();
    heightController.dispose();
    colorController.dispose();
    breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "Edit My Pet",),
            SliverToBoxAdapter(
              child: Obx(() {
                return Stack(
                  children: [
                    controller.selectedImage.value != null
                        ? Image.file(
                      File(controller.selectedImage.value!.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.h,
                    )
                        : Image.network(
                      'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.h,

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
              }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20),
                child: Form(
                  key: _formKey,
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
                        keyboardType: TextInputType.text,
                        textEditingController: petNameController,
                      ),
                      Gap(14),
                      CustomAlignText(
                        text: AppStrings.petType,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(8.0),
                      CustomTextField(
                        hintText: "Enter your pet type",
                        fieldBorderColor: AppColors.purple500,
                        fieldBorderRadius: 10,
                        fillColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textEditingController: petTypeController,
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
                        textEditingController: ageController,
                      ),
                      Gap(14),
                      CustomDropdown(
                        onChanged: (value){
                          if( value!=null){
                            controller.genderSelected.value = value;
                          }
                        },
                        selectedValue: controller.genderSelected.value,
                        title: AppStrings.gender,
                        borderColor: AppColors.purple500,
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
                        textEditingController: weightController,
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
                        textEditingController: heightController,
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
                        textEditingController: colorController,
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
                        textEditingController: breedController,
                      ),
                      /*      Gap(14),
                      CustomAlignText(
                        text: AppStrings.moreInfo,
                        fontWeight: FontWeight.w500,
                      ),*/
                      /*                  Gap(8.0),
                      CustomTextField(
                        fieldBorderColor: AppColors.purple500,
                        fieldBorderRadius: 10,
                        fillColor: Colors.white,
                        hintText: AppStrings.enterMoreInformation,

                        keyboardType: TextInputType.text,
                        textEditingController: _authController.confirmPasswordSignUp,
                      ),*/
                      Gap(24),

                      Obx(() {
                        return CustomButton(
                          isLoading: controller.isUpdateLoading.value,
                          onTap: () {
                          final body = {
                            "name": petNameController.text,
                            "animalType": petTypeController.text,
                            "breed": breedController.text,
                            "age": ageController.text,
                            "gender": controller.genderSelected.value,
                            "weight": weightController.text,
                            "height": heightController.text,
                            "color": colorController.text,
                          };
                          if (_formKey.currentState!.validate()) {
                            controller.updateMyPet(body: body, id: widget.id);
                          }
/*
                          navigationController.selectedNavIndex.value = 3;
                        AppRouter.route.goNamed(RoutePath.navigationPage);*/
                        }, title: "Save", textColor: Colors.black,
                        );
                      })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
