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
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/review/widgets/review_card_item_widget.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({
    super.key,
    required this.showWebsite,
    required this.id,
    required this.isShop,
  });

  final bool showWebsite;
  final String id;
  final bool isShop;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final controller = GetControllers.instance.getCategoryDetailsController();

  @override
  void initState() {
    super.initState();
    controller.getCategoryDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getCategoryDetails(id: widget.id);
        },
        child: CustomScrollView(
          slivers: [
            // Transparent AppBar with back button overlay
            SliverAppBar(
              expandedHeight: 280.h,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.all(8.w),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Obx(() {
                  final image = controller.categoryDetails.value.service?.servicesImages;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      image != null && image.isNotEmpty
                          ? CustomNetworkImage(imageUrl: image,) : CustomNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                        width: double.infinity,
                        height: 280.h,
                      ),
                      // Dark gradient at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 100.h,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            // Main Content
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -30.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(24.h),
                        // Logo and Title Section
                        Row(
                          children: [
                            Gap(10),
                            // Logo
                            Obx(() {
                              final logo = controller.categoryDetails.value.service?.shopLogo;
                              return Container(
                                width: 70.w,
                                height: 70.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(color: Colors.grey.shade200, width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: logo != null && logo.isNotEmpty
                                      ? CustomNetworkImage(
                                    width: 70.w,
                                    height: 70.w,
                                    imageUrl: logo.replaceAll("\\", "/"),
                                  )
                                      : CustomImage(
                                    imageSrc: "assets/images/petshoplogo.png",
                                    sizeWidth: 70.w,
                                  ),
                                ),
                              );
                            }),
                            Gap(16.w),
                            // Title and Status
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    final serviceName = controller.categoryDetails.value.service?.serviceType;
                                    return Text(
                                      serviceName ?? "",
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        letterSpacing: -0.5,
                                      ),
                                    );
                                  }),
                                  Gap(8.h),
                                  Obx(() {
                                    final isOpen = controller.categoryDetails.value.service?.isOpenNow ?? false;
                                    return Row(
                                      children: [
                                        Container(
                                          width: 10.w,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isOpen ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                          ),
                                        ),
                                        Gap(6.w),
                                        Text(
                                          isOpen ? "Open Now" : "Closed",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: isOpen ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(24.h),
                        // Rating Card with modern design
                        Obx(() {
                          final service = controller.categoryDetails.value.service;
                          final avgRating = service?.avgRating ?? 0.0;
                          final rating = avgRating.toStringAsFixed(2);
                          return Column(
                            children: [
                              avgRating > 0
                                  ? Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFFBBF24).withOpacity(0.1),
                                      const Color(0xFFF59E0B).withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: const Color(0xFFFBBF24).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star_rounded, color: const Color(0xFFFBBF24), size: 32.sp),
                                    Gap(8.w),
                                    Text(
                                      rating,
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Gap(8.w),
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : SizedBox(), // jodi review 0.0 hoy tahole kichu dekhabe na
                            ],
                          );
                        }),

                        Gap(24.h),
                        // Schedule Section
                        Text(
                          "Schedule",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Gap(16.h),

                        Obx(() {
                          final item = controller.categoryDetails.value.service;
                          return Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.grey.shade200, width: 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Icon(
                                        Icons.access_time_rounded,
                                        color: const Color(0xFF3B82F6),
                                        size: 24.sp,
                                      ),
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Working Hours",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          Gap(4.h),
                                          Text(
                                            controller.getOpenDaysTextComplete(
                                              offDay: item?.offDay ?? "",
                                              openingTime: item?.openingTime ?? "",
                                              closingTime: item?.closingTime ?? "",
                                            ),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (item?.offDay != null && item!.offDay!.isNotEmpty) ...[
                                  Gap(12.h),
                                  Divider(color: Colors.grey.shade300, height: 1),
                                  Gap(12.h),
                                  Row(
                                    children: [
                                      Icon(Icons.event_busy_rounded, color: const Color(0xFFEF4444), size: 20.sp),
                                      Gap(8.w),
                                      Text(
                                        "Closed on ${item.offDay}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFEF4444),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          );
                        }),
                        Gap(24.h),
                        // Contact Information
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Gap(16.h),
                        // Business Type
                        Obx(() {
                          final businessType = controller.categoryDetails.value.service?.serviceName;
                          return _buildModernInfoTile(
                            icon: Icons.store_rounded,
                            iconColor: const Color(0xFF8B5CF6),
                            label: "Business Type",
                            value: businessType ?? "Not available",
                          );
                        }),
                        Gap(12.h),
                        // Address
                        Obx(() {
                          final address = controller.categoryDetails.value.service?.location;
                          return _buildModernInfoTile(
                            icon: Icons.location_on_rounded,
                            iconColor: const Color(0xFFEF4444),
                            label: "Address",
                            value: address ?? "Not available",
                          );
                        }),
                        Gap(12.h),
                        // Phone
                        Obx(() {
                          final phone = controller.categoryDetails.value.service?.phone;
                          return _buildModernInfoTile(
                            icon: Icons.phone_rounded,
                            iconColor: const Color(0xFF10B981),
                            label: "Phone Number",
                            value: phone ?? "Not available",
                          );
                        }),
                        Gap(24.h),
                        // Action Buttons
                        Row(
                          children: [
                            if (widget.showWebsite)
                              Expanded(
                                child: _buildModernButton(
                                  onTap: () async {
                                    String? websiteUrl = controller.categoryDetails.value.service?.websiteLink;
                                    if (websiteUrl == null || websiteUrl.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Website not available')),
                                      );
                                      return;
                                    }
                                    if (!websiteUrl.startsWith('http://') &&
                                        !websiteUrl.startsWith('https://')) {
                                      websiteUrl = 'https://$websiteUrl';
                                    }
                                    final Uri url = Uri.parse(websiteUrl);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url, mode: LaunchMode.externalApplication);
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Could not open website')),
                                        );
                                      }
                                    }
                                  },
                                  icon: Icons.language_rounded,
                                  label: "Website",
                                  backgroundColor: Colors.white,
                                  textColor: const Color(0xFF8B5CF6),
                                  borderColor: const Color(0xFF8B5CF6),
                                ),
                              ),
                            if (widget.showWebsite && widget.isShop) Gap(12.w),
                            if (widget.isShop)
                              Expanded(
                                child: _buildModernButton(
                                  onTap: () {
                                    final businessID = controller.categoryDetails.value.service?.businessId;
                                    final id = controller.categoryDetails.value.service?.id;
                                    if (id == null || id.isEmpty || businessID == null || businessID.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Service information not available')),
                                      );
                                      return;
                                    }
                                    final extraData = {
                                      'isHotel': widget.showWebsite,
                                      'id': id,
                                      'businessId': businessID,
                                    };

                                    AppRouter.route.pushNamed(RoutePath.serviceScreen, extra: extraData);
                                  },
                                  icon: Icons.calendar_month_rounded,
                                  label: "Book Service",
                                  backgroundColor: const Color(0xFF3B82F6),
                                  textColor: Colors.white,
                                ),
                              ),
                          ],
                        ),
                        Gap(24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInfoTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
                Gap(4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: borderColor != null ? Border.all(color: borderColor, width: 2) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 22.sp),
            Gap(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}