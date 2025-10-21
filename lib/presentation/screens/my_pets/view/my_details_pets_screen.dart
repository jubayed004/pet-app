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
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/details_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class MyDetailsPetsScreen extends StatefulWidget {
  final String id;

  const MyDetailsPetsScreen({super.key, required this.id});

  @override
  State<MyDetailsPetsScreen> createState() => _MyDetailsPetsScreenState();
}

class _MyDetailsPetsScreenState extends State<MyDetailsPetsScreen> {
  final controller = GetControllers.instance.getMyPetsProfileController();

  @override
  void initState() {
    super.initState();
    controller.myAllPetDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.myAllPetDetails(id: widget.id);
        },
        color: AppColors.primaryColor,
        child: CustomScrollView(
          slivers: [
            Obx(() {
              return CustomDefaultAppbar(
                  title: controller.details.value.pet?.name ?? "Pet Details");
            }),

            // Hero Image Section
            SliverToBoxAdapter(
              child: Obx(() {
                final petPhoto = controller.details.value.pet?.petPhoto ?? "";
                return Stack(
                  children: [
                    petPhoto.isNotEmpty
                        ? Image.network(
                      petPhoto,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 280.h,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                    )
                        : _buildPlaceholderImage(),
                    // Gradient overlay
                    Container(
                      height: 280.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            // Main Content
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -30.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        // Pet Info Card
                        Obx(() {
                          final pet = controller.details.value.pet;
                          return Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: pet?.name ?? "",
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24.sp,
                                      ),
                                      Gap(8.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.purple500
                                              .withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                        ),
                                        child: CustomText(
                                          text: pet?.gender ?? "",
                                          textAlign: TextAlign.start,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.purple500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                    AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      AppRouter.route.pushNamed(
                                        RoutePath.editMyPetsScreen,
                                        extra: {
                                          "id": pet?.id ?? "",
                                          "name": pet?.name ?? "",
                                          "animalType": pet?.animalType ?? "",
                                          "breed": pet?.breed ?? "",
                                          "age": pet?.age.toString() ?? "",
                                          "gender": pet?.gender ?? "",
                                          "weight": pet?.weight.toString() ?? "",
                                          "height": pet?.height.toString() ?? "",
                                          "color": pet?.color ?? "",
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Iconsax.edit,
                                      color: AppColors.primaryColor,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Gap(20.h),

                        // About Section
                        _buildSectionHeader(
                          icon: Icons.info_outline,
                          title: "About",
                          subtitle: controller.details.value.pet?.name ?? "",
                        ),
                        Gap(12.h),

                        // Details Cards
                        SizedBox(
                          height: MediaQuery.of(context).size.height/6,
                          child: Obx(() {
                            final pet = controller.details.value.pet;
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildModernDetailsCard(
                                  title: "Age",
                                  value: "${pet?.age ?? 0}",
                                  icon: Iconsax.calendar,
                                  color: Colors.blue,
                                ),
                                _buildModernDetailsCard(
                                  title: "Type",
                                  value: pet?.animalType ?? "",
                                  icon: Iconsax.category,
                                  color: Colors.purple,
                                ),
                                _buildModernDetailsCard(
                                  title: "Weight",
                                  value: "${pet?.weight ?? 0} kg",
                                  icon: Iconsax.weight,
                                  color: Colors.orange,
                                ),
                                _buildModernDetailsCard(
                                  title: "Height",
                                  value: "${pet?.height ?? 0} cm",
                                  icon: Iconsax.arrow_up_3,
                                  color: Colors.green,
                                ),
                                _buildModernDetailsCard(
                                  title: "Color",
                                  value: pet?.color ?? "",
                                  icon: Iconsax.colorfilter,
                                  color: Colors.red,
                                ),
                                _buildModernDetailsCard(
                                  title: "Breed",
                                  value: pet?.breed ?? "",
                                  icon: Iconsax.share,
                                  color: Colors.teal,
                                ),
                              ],
                            );
                          }),
                        ),
                        Gap(24.h),

                        // Health Section Header
                        _buildSectionHeader(
                          icon: Icons.health_and_safety,
                          title: "Health Status",
                          subtitle:
                          controller.details.value.pet?.name ?? "Pet",
                          actionText: "See All",
                          onActionTap: () {
                            AppRouter.route.pushNamed(
                              RoutePath.petHealthScreen,
                              extra: widget.id,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Medical History List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Obx(() {
                    final medicalHistory =
                        controller.details.value.petMedicalHistory ?? [];

                    if (medicalHistory.isEmpty) {
                      return Container(
                        //padding: EdgeInsets.all(40.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.medical_services_outlined,
                                size: 60.sp, color: Colors.grey.shade300),
                            Gap(16.h),
                            CustomText(
                              text: "No medical history available",
                              fontSize: 16.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    }

                    final treatment = medicalHistory[index];
                    return _buildMedicalHistoryCard(treatment);
                  }),
                  childCount:
                  controller.details.value.petMedicalHistory?.isEmpty ??
                      true
                      ? 1
                      : controller.details.value.petMedicalHistory?.length ??
                      0,
                ),
              ),
            ),
            SliverGap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 280.h,
      color: Colors.grey.shade200,
      child: Image.network(
        'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(Icons.pets, size: 80.sp, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    String? subtitle,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 24.sp),
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
              if (subtitle != null)
                CustomText(
                  text: subtitle,
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
            ],
          ),
        ),
        if (actionText != null && onActionTap != null)
          TextButton(
            onPressed: onActionTap,
            child: CustomText(
              text: actionText,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),
      ],
    );
  }

  Widget _buildModernDetailsCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          Gap(8.h),
          CustomText(
            text: title,
            fontSize: 11.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          Gap(4.h),
          CustomText(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryCard(treatment) {
    final treatmentName = treatment.treatmentName ?? "Unknown";
    final doctorName = treatment.doctorName ?? "Unknown Doctor";
    final treatmentDate = treatment.treatmentDate != null
        ? DateFormat('EEE, dd MMM yyyy').format(treatment.treatmentDate!)
        : "Unknown Date";
    final treatmentDescription =
        treatment.treatmentDescription ?? "No description";
    final treatmentStatus = treatment.treatmentStatus ?? "PENDING";
    final isCompleted = treatmentStatus == "COMPLETED";

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
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
                  color: (isCompleted ? Colors.green : Colors.orange)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  isCompleted ? Iconsax.tick_circle4 : Iconsax.clock5,
                  color: isCompleted ? Colors.green : Colors.orange,
                  size: 20.sp,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: treatmentName,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isCompleted ? Colors.green.shade700 : Colors.orange.shade700,
                      textAlign: TextAlign.start,
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Icon(Iconsax.user_octagon, size: 14.sp, color: Colors.grey),
                        Gap(4.w),
                        CustomText(
                          text: doctorName,
                          fontSize: 13.sp,
                          color: Colors.grey.shade700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green.shade700 : Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text: treatmentStatus,
                  fontSize: 11.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Divider(height: 1, color: Colors.grey.shade200),
          Gap(12.h),

          // Date
          Row(
            children: [
              Icon(Iconsax.calendar_1, size: 16.sp, color: AppColors.purple500),
              Gap(8.w),
              CustomText(
                text: treatmentDate,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ],
          ),
          Gap(12.h),

          // Description
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Iconsax.document_text, size: 16.sp, color: AppColors.purple500),
              Gap(8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Treatment Description",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple500,
                    ),
                    Gap(6.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: (isCompleted ? Colors.green : Colors.orange).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: (isCompleted ? Colors.green : Colors.orange).withOpacity(0.2),
                        ),
                      ),
                      child: CustomText(
                        text: treatmentDescription,
                        fontSize: 13.sp,
                        color: Colors.black87,
                        textAlign: TextAlign.start,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper widget for Gap in Sliver
class SliverGap extends SliverToBoxAdapter {
  SliverGap(double height) : super(child: SizedBox(height: height));
}