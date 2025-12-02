import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class BusinessEditProfileScreen extends StatefulWidget {
  final String profileImage;
  const BusinessEditProfileScreen({super.key, required this.profileImage});

  @override
  State<BusinessEditProfileScreen> createState() => _BusinessEditProfileScreenState();
}

class _BusinessEditProfileScreenState extends State<BusinessEditProfileScreen> {
  final businessProfileController = GetControllers.instance.getBusinessProfileController();
  final controller = GetControllers.instance.getNavigationControllerMain();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    name = TextEditingController(text: businessProfileController.profile.value.ownerDetails?.name);
    phone = TextEditingController(text: businessProfileController.profile.value.ownerDetails?.phone);
    address = TextEditingController(text: businessProfileController.profile.value.ownerDetails?.address);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: CustomText(fontWeight: FontWeight.w600, fontSize: 16, text: "Edit Profile"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Obx(
                    () {
                  final selected = businessProfileController.selectedImage.value;
                  return Stack(
                    children: [
                      // --- Background Image ---
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: selected != null
                            ? Image.file(
                          File(selected.path),
                          fit: BoxFit.cover,
                        )
                            : widget.profileImage.isNotEmpty ?  CustomNetworkImage(
                          imageUrl: widget.profileImage,
                          height: 180.h,
                          borderRadius: BorderRadius.circular(14),
                          width: double.infinity,
                        ) :Icon(Icons.person) ,
                      ),

                      // --- Dark Overlay ---
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: Colors.black.withValues(alpha: 0.25),
                      ),

                      // --- Camera Button ---
                      Positioned.fill(
                        child: Center(
                          child: GestureDetector(
                            onTap: businessProfileController.pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 32,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  children: [
                    CustomAlignText(
                      fontSize: 16.sp,
                      text: "Name",
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(8.0),
                    CustomTextField(
                      hintText: "Enter your name",
                      fieldBorderColor: AppColors.purple500,
                      fieldBorderRadius: 10,
                      fillColor: Colors.white,
                      keyboardType: TextInputType.text,
                      textEditingController: name,
                    ),

                    Gap(16),
                    CustomAlignText(
                      fontSize: 16.sp,
                      text: "Phone Number",
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(8.0),
                    CustomTextField(
                      isDens: true,
                      hintText: "Enter your phone",
                      fieldBorderColor: AppColors.purple500,
                      fieldBorderRadius: 10,
                      fillColor: Colors.white,
                      keyboardType: TextInputType.phone,
                      textEditingController: phone,
                    ),

                    Gap(16),
                    CustomAlignText(
                      fontSize: 16.sp,
                      text: "Address",
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(8.0),
                    CustomTextField(
                      hintText: "Enter your address",
                      fieldBorderColor: AppColors.purple500,
                      fieldBorderRadius: 10,
                      fillColor: Colors.white,
                      keyboardType: TextInputType.streetAddress,
                      textEditingController: address,
                    ),
                    Gap(24),
                    Obx(() {
                      return CustomButton(
                        isLoading:businessProfileController.isUpdateLoading.value,
                        onTap: () {
                          final body = {
                            "name": name.text,
                            "phone": phone.text,
                            "address": address.text,
                          };
                          businessProfileController.businessUpdateProfile(body: body);
                        },
                        title: "Save",
                        textColor: Colors.black,
                      );
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
