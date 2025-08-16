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

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String address;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileController = GetControllers.instance.getProfileController();
  final controller = GetControllers.instance.getNavigationControllerMain();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    name = TextEditingController(text: widget.name);
    phone = TextEditingController(text: widget.phoneNumber);
    address = TextEditingController(text: widget.address);
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
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
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
                background: Obx(() {
                  return Stack(
                    children: [
                      profileController.selectedImage.value != null
                          ? Image.file(
                        File(profileController.selectedImage.value!.path),
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
                }),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  children: [
                    CustomAlignText(text: "Name", fontWeight: FontWeight.w500),
                    Gap(8.0),
                    CustomTextField(
                      hintText: "Enter your name",
                      fieldBorderColor: AppColors.purple500,
                      fieldBorderRadius: 10,
                      fillColor: Colors.white,
                      keyboardType: TextInputType.text,
                      textEditingController: name,
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Name is required';
                        }
                        if (value
                            .trim()
                            .length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        final nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
                        if (!nameRegExp.hasMatch(value.trim())) {
                          return 'Name can only contain letters and spaces';
                        }
                        return null; // Valid
                      },
                    ),

                    Gap(16),
                    CustomAlignText(
                      text: "Phone Number",
                      fontWeight: FontWeight.w500,
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
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Phone number is required';
                        }

                        final phoneRegExp = RegExp(r'^\+?\d{10,15}$');
                        if (!phoneRegExp.hasMatch(value.trim())) {
                          return 'Enter a valid phone number';
                        }

                        return null; // Valid
                      },
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
                      textEditingController: address,
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Address is required';
                        }
                        if (value.length < 5) {
                          return 'Please enter a valid address';
                        }
                        return null; // Valid
                      },
                    ),
                    Gap(24),
                    Obx(() {
                      return CustomButton(
                        isLoading: profileController.isUpdateLoading.value,
                        onTap: () {
                          final body = {
                            "name": name.text,
                            "phone": phone.text,
                            "address": address.text,
                          };
                          if (_formKey.currentState!.validate()) {
                            profileController.updateProfile(body: body);
                          }
                        },
                        title: "Save",
                        textColor: Colors.black,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
