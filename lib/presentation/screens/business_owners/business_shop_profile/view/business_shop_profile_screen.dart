import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessShopProfileScreen extends StatelessWidget {
  BusinessShopProfileScreen({super.key});

  final shopProfileController = GetControllers.instance.getBusinessShopProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Business Profile"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await shopProfileController.getBusinessShopProfile();
        },
        color: AppColors.purple500,
        child: CustomScrollView(
          slivers: [

            /// ---------- Main Profile Section ----------
            SliverToBoxAdapter(
              child: Obx(() {
                final status = shopProfileController.loading;

                // Show loading indicator
                if (status == Status.loading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.purple500,
                            strokeWidth: 3,
                          ),
                          Gap(16.h),
                          CustomText(
                            text: "Loading profile...",
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Check if profile data exists
                final businesses = shopProfileController.shopProfile?.business ?? [];
                if (businesses.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100.h),
                      child: CircularProgressIndicator(
                        color: AppColors.purple500,
                      ),
                    ),
                  );
                }

                final business = businesses.first;

                // Get shop images with fallbacks
                final shopPic = business.shopPic?.isNotEmpty == true
                    ? business.shopPic!.first
                    : 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80';

                final shopLogo = business.shopLogo ??
                    'https://via.placeholder.com/150x150.png?text=Pet+Shop';

                return Column(
                  children: [
                    // Header Section with Cover & Logo
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Cover Image with Gradient Overlay
                        Container(
                          height: 220.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CustomNetworkImage(
                                imageUrl: shopPic,
                                width: double.infinity,
                                height: 220.h,
                              ),
                              // Gradient overlay for better text visibility
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Floating Logo
                        Positioned(
                          bottom: -50.h,
                          left: 24.w,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: CustomNetworkImage(imageUrl: shopLogo),
                            ),
                          ),
                        ),

                        // Edit Button
                        Positioned(
                          top: 16.h,
                          right: 16.w,
                          child: GestureDetector(
                            onTap: () {
                              AppRouter.route.pushNamed(
                                RoutePath.businessEditShopProfileScreen,
                                extra: {
                                  "name": business.businessName ?? "",
                                  "phoneNumber": business.website ?? "",
                                  "address": business.address ?? "",
                                  "logoUrl": business.shopLogo,
                                  "shopPicUrl": business.shopPic?.isNotEmpty == true
                                      ? business.shopPic!.first
                                      : null,
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.edit,
                                    size: 16.sp,
                                    color: AppColors.purple500,
                                  ),
                                  Gap(6.w),
                                  CustomText(
                                    text: "Edit",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    color: AppColors.purple500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(60.h),

                    // Business Info Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Business Name
                          CustomText(
                            text: business.businessName ?? "Unknown Business",
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          Gap(8.h),

                          // Address with Icon
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 18.sp,
                                color: AppColors.purple500,
                              ),
                              Gap(6.w),
                              Expanded(
                                child: CustomText(
                                  text: business.address ?? "No address provided",
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          Gap(20.h),

                          // Website Button
                          CustomButton(
                            onTap: () async {
                              String websiteUrl = business.website ?? "";

                              if (websiteUrl.isEmpty) {
                                Get.snackbar(
                                  "No Website",
                                  "This business hasn't added a website yet",
                                  backgroundColor: Colors.orange.shade100,
                                  colorText: Colors.orange.shade900,
                                  icon: Icon(Icons.info_outline, color: Colors.orange.shade900),
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: EdgeInsets.all(16.w),
                                  borderRadius: 12,
                                );
                                return;
                              }

                              if (!websiteUrl.startsWith('http')) {
                                websiteUrl = 'https://$websiteUrl';
                              }

                              final Uri url = Uri.parse(websiteUrl);

                              try {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Could not launch website",
                                    backgroundColor: Colors.red.shade100,
                                    colorText: Colors.red.shade900,
                                    icon: Icon(Icons.error_outline, color: Colors.red.shade900),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.all(16.w),
                                    borderRadius: 12,
                                  );
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  "Invalid website URL",
                                  backgroundColor: Colors.red.shade100,
                                  colorText: Colors.red.shade900,
                                  icon: Icon(Icons.error_outline, color: Colors.red.shade900),
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: EdgeInsets.all(16.w),
                                  borderRadius: 12,
                                );
                              }
                            },
                            title: "Visit Website",
                            textColor: AppColors.purple500,
                            height: 48.h,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            fillColor: AppColors.purple500.withOpacity(0.1),
                            borderColor: AppColors.purple500,
                            borderWidth: 1.5,
                            isBorder: true,
                          ),
                          Gap(32.h),

                          // Details Section
                          _buildSectionTitle("Business Details"),
                          Gap(16.h),

                          // Business Type Card
                          _buildInfoCard(
                            icon: Iconsax.category,
                            title: AppStrings.businessType,
                            child: business.servicesType != null &&
                                business.servicesType!.isNotEmpty
                                ? Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: business.servicesType!.map((service) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.purple500.withOpacity(0.15),
                                        AppColors.purple500.withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.purple500.withOpacity(0.3),
                                    ),
                                  ),
                                  child: CustomText(
                                    text: service,
                                    fontSize: 13.sp,
                                    color: AppColors.purple500,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }).toList(),
                            )
                                : CustomText(
                              text: "No business type specified",
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Gap(12.h),

                          // Address Card
                          _buildInfoCard(
                            icon: Icons.location_on_rounded,
                            title: AppStrings.businessAddress,
                            child: CustomText(
                              text: business.address ?? "Not Available",
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              maxLines: 5,
                            ),
                          ),
                          Gap(12.h),

                          // More Info Card
                          _buildInfoCard(
                            icon: Icons.info_outline_rounded,
                            title: "More Information",
                            child: CustomText(
                              text: business.moreInfo?.isNotEmpty == true
                                  ? business.moreInfo!
                                  : "No additional information available",
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              maxLines: 10,
                            ),
                          ),
                          Gap(32.h),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Title Widget
  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
  }

  /// Info Card Widget
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.purple500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: AppColors.purple500,
                ),
              ),
              Gap(12.w),
              CustomText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ],
          ),
          Gap(12.h),
          child,
        ],
      ),
    );
  }
}