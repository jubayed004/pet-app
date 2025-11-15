import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class BusinessEditShopProfileScreen extends StatefulWidget {
  final String? name;
  final String? address;
  final String? webSiteLink;
  final String? logoUrl;
  final String? shopPicUrl;

  const BusinessEditShopProfileScreen({
    super.key,
    this.name,
    this.address,
    this.webSiteLink,
    this.logoUrl,
    this.shopPicUrl,
  });

  @override
  State<BusinessEditShopProfileScreen> createState() =>
      _BusinessEditShopProfileScreenState();
}

class _BusinessEditShopProfileScreenState
    extends State<BusinessEditShopProfileScreen> {
  final _shopProfileController =
  GetControllers.instance.getBusinessShopProfileController();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _businessNameController;
  late TextEditingController _addressController;
  late TextEditingController _websiteController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _businessNameController = TextEditingController(text: widget.name ?? '');
    _addressController = TextEditingController(text: widget.address ?? '');
    _websiteController = TextEditingController(text: widget.webSiteLink ?? '');
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _shopProfileController.updateShopProfile(
        businessName: _businessNameController.text,
        address: _addressController.text,
        website:
        _websiteController.text.isNotEmpty ? _websiteController.text : null,
      );
    }
  }

  Widget _buildImagePicker({
    required String label,
    required VoidCallback onTap,
    required Rx<XFile?> selectedImage, // <- expects Rx<XFile?>
    String? networkImageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAlignText(text: label, fontWeight: FontWeight.w600),
        Gap(10.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.purple500.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Obx(() {
              final localImage = selectedImage.value;
              final hasLocalImage = localImage != null;
              final hasNetworkImage =
                  networkImageUrl != null && networkImageUrl.isNotEmpty;

              return Stack(
                children: [
                  Positioned.fill(
                    child: hasLocalImage
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        File(localImage.path),
                        fit: BoxFit.cover,
                      ),
                    )
                        : hasNetworkImage
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CustomNetworkImage(
                        imageUrl: networkImageUrl,
                        height: 180.h,
                        borderRadius: BorderRadius.circular(14),
                        width: double.infinity,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color:
                        AppColors.purple500.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  if (!hasLocalImage && !hasNetworkImage)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color:
                              AppColors.purple500.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 28.sp,
                              color: AppColors.purple500,
                            ),
                          ),
                          Gap(12.h),
                          Text(
                            'Tap to upload image',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.purple500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            'PNG, JPG (Max 5MB)',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (hasLocalImage || hasNetworkImage)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.edit,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: "Edit Business Profile",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Shop Name
              CustomAlignText(
                text: "Pet Shop Name *",
                fontWeight: FontWeight.w600,
              ),
              Gap(10.h),
              CustomTextField(
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 12,
                fillColor: Colors.white,
                hintText: "Enter your pet shop name",
                keyboardType: TextInputType.text,
                textEditingController: _businessNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pet shop name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              Gap(20.h),

              // Business Address
              CustomAlignText(
                text: "${AppStrings.businessAddress} *",
                fontWeight: FontWeight.w600,
              ),
              Gap(10.h),
              CustomTextField(
                textEditingController: _addressController,
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 12,
                fillColor: Colors.white,
                hintText: "Enter your business address",
                keyboardType: TextInputType.streetAddress,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business address';
                  }
                  if (value.length < 10) {
                    return 'Address must be at least 10 characters';
                  }
                  return null;
                },
              ),
              Gap(20.h),

              // Website Link
              CustomAlignText(
                text: "Website Link (Optional)",
                fontWeight: FontWeight.w600,
              ),
              Gap(10.h),
              CustomTextField(
                fieldBorderColor: AppColors.purple500,
                fieldBorderRadius: 12,
                fillColor: Colors.white,
                hintText: "https://example.com",
                keyboardType: TextInputType.url,
                textEditingController: _websiteController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final urlPattern = RegExp(
                      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$',
                      caseSensitive: false,
                    );
                    if (!urlPattern.hasMatch(value)) {
                      return 'Please enter a valid URL';
                    }
                  }
                  return null;
                },
              ),
              Gap(28.h),

              // Shop Logo
              _buildImagePicker(
                label: "Shop Logo",
                onTap: _shopProfileController.pickLogoImage,
                selectedImage:
                _shopProfileController.selectedLogoRx, // <-- pass Rx
                networkImageUrl: widget.logoUrl,
              ),
              Gap(24.h),

              // Shop Picture
              _buildImagePicker(
                label: "Shop Picture",
                onTap: _shopProfileController.pickShopPicture,
                selectedImage:
                _shopProfileController.selectedShopPicRx, // <-- pass Rx
                networkImageUrl: widget.shopPicUrl,
              ),
              Gap(32.h),

              // Submit Button
              Obx(() {
                return CustomButton(
                  isLoading: _shopProfileController.isUpdateLoading,
                  title: "Save Changes",
                  textColor: Colors.white,
                  showIcon: false,
                  onTap: _handleSubmit,
                );
              }),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
