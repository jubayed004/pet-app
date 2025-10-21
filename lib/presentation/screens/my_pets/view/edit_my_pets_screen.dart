import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/details_card.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

// ==================== EDIT MY PETS SCREEN ====================
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

  const EditMyPetsScreen({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.color,
    required this.petType,
    required this.breed,
    required this.id,
  });

  @override
  State<EditMyPetsScreen> createState() => _EditMyPetsScreenState();
}

class _EditMyPetsScreenState extends State<EditMyPetsScreen> {
  final controller = GetControllers.instance.getMyPetsProfileController();
  final navigationController =
  GetControllers.instance.getNavigationControllerMain();

  late TextEditingController petNameController;
  late TextEditingController petTypeController;
  late TextEditingController ageController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  late TextEditingController colorController;
  late TextEditingController breedController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    petNameController = TextEditingController(text: widget.name);
    petTypeController = TextEditingController(text: widget.petType);
    ageController = TextEditingController(text: widget.age);
    weightController = TextEditingController(text: widget.weight);
    heightController = TextEditingController(text: widget.height);
    colorController = TextEditingController(text: widget.color);
    breedController = TextEditingController(text: widget.breed);
    controller.genderSelected.value = widget.gender;
  }

  @override
  void dispose() {
    petNameController.dispose();
    petTypeController.dispose();
    ageController.dispose();
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
        backgroundColor: Colors.grey.shade50,
        body: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "Edit My Pet"),

            // Image Section with Modern Design
            SliverToBoxAdapter(
              child: Obx(() {
                return Container(
                  margin: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: controller.selectedImage.value != null
                            ? Image.file(
                          File(controller.selectedImage.value!.path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 220.h,
                        )
                            : Image.network(
                          'https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 220.h,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220.h,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.pets,
                                  size: 80.sp, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      // Dark overlay
                      Container(
                        height: 220.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                      // Camera Button
                      Positioned.fill(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 32.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Edit Badge
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit,
                                  size: 14.sp, color: Colors.white),
                              Gap(4.w),
                              CustomText(
                                text: "Tap to change",
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Form Section
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.purple500.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(Icons.pets,
                                color: AppColors.purple500, size: 24.sp),
                          ),
                          Gap(12.w),
                          CustomText(
                            text: "Pet Information",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Gap(20.h),

                      _buildModernTextField(
                        label: AppStrings.petName,
                        hint: "Enter your pet name",
                        controller: petNameController,
                        icon: Iconsax.user,
                      ),
                      Gap(16.h),

                      _buildModernTextField(
                        label: AppStrings.petType,
                        hint: "Enter your pet type (e.g., Dog, Cat)",
                        controller: petTypeController,
                        icon: Iconsax.category,
                      ),
                      Gap(16.h),

                      _buildModernTextField(
                        label: AppStrings.age,
                        hint: AppStrings.enterAge,
                        controller: ageController,
                        icon: Iconsax.calendar,
                        keyboardType: TextInputType.number,
                      ),
                      Gap(16.h),

                      // Gender Dropdown with Modern Design
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.user_octagon,
                                  size: 20.sp, color: AppColors.purple500),
                              Gap(8.w),
                              CustomText(
                                text: AppStrings.gender,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                          Gap(8.h),
                          Obx(() {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.purple500.withOpacity(0.3),
                                ),
                              ),
                              child: CustomDropdown(
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.genderSelected.value = value;
                                  }
                                },
                                selectedValue: controller.genderSelected.value,
                                title: "",
                                borderColor: Colors.transparent,
                                items: ["MALE", "FEMALE"],
                              ),
                            );
                          }),
                        ],
                      ),
                      Gap(16.h),

                      Row(
                        children: [
                          Expanded(
                            child: _buildModernTextField(
                              label: AppStrings.weight,
                              hint: "kg",
                              controller: weightController,
                              icon: Iconsax.weight,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: _buildModernTextField(
                              label: AppStrings.height,
                              hint: "cm",
                              controller: heightController,
                              icon: Iconsax.arrow_up_3,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Gap(16.h),

                      _buildModernTextField(
                        label: AppStrings.color,
                        hint: AppStrings.enterColor,
                        controller: colorController,
                        icon: Iconsax.colorfilter,
                      ),
                      Gap(16.h),

                      _buildModernTextField(
                        label: AppStrings.breed,
                        hint: AppStrings.enterPetBreed,
                        controller: breedController,
                        icon: Iconsax.share,
                      ),
                      Gap(32.h),

                      // Save Button
                      Obx(() {
                        return CustomButton(
                          isLoading: controller.isUpdateLoading.value,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final body = {
                                "name": petNameController.text.trim(),
                                "animalType": petTypeController.text.trim(),
                                "breed": breedController.text.trim(),
                                "age": ageController.text.trim(),
                                "gender": controller.genderSelected.value,
                                "weight": weightController.text.trim(),
                                "height": heightController.text.trim(),
                                "color": colorController.text.trim(),
                              };
                              controller.updateMyPet(body: body, id: widget.id);
                            }
                          },
                          title: "Save Changes",
                          textColor: Colors.white,
                          fillColor: AppColors.primaryColor,
                          height: 50.h,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20.sp, color: AppColors.purple500),
            Gap(8.w),
            CustomText(
              text: label,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ],
        ),
        Gap(8.h),
        CustomTextField(
          hintText: hint,
          fieldBorderColor: AppColors.purple500.withOpacity(0.3),
          fieldBorderRadius: 12,
          fillColor: Colors.grey.shade50,
          keyboardType: keyboardType ?? TextInputType.text,
          textEditingController: controller,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}