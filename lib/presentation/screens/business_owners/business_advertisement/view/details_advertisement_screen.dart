import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_advertisement/model/details_advertisement_model.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class DetailsAdvertisementScreen extends StatefulWidget {
  const DetailsAdvertisementScreen({super.key});

  @override
  State<DetailsAdvertisementScreen> createState() => _DetailsAdvertisementScreenState();
}

class _DetailsAdvertisementScreenState extends State<DetailsAdvertisementScreen>
    with SingleTickerProviderStateMixin {
  final controller = GetControllers.instance.getBusinessAdvertisementController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDetailsAdvertisement();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(
          text: "Advertisement Management",
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: Colors.grey[900]!,
        ),
        iconTheme: IconThemeData(color: Colors.grey[900]),
        actions: [
          IconButton(
            onPressed: () => controller.getDetailsAdvertisement(),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Refresh",
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // Stats Row
                Obx(() {
                  final total = controller.totalAdvertisementsCount;
                  final active = controller.activeAdvertisementsCount;
                  final inactive = controller.inactiveAdvertisementsCount;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.assessment,
                          label: "Total",
                          value: total.toString(),
                          color: AppColors.purple500,
                        ),
                        Gap(12.w),
                        _buildStatCard(
                          icon: Icons.check_circle,
                          label: "Active",
                          value: active.toString(),
                          color: Colors.green,
                        ),
                        Gap(12.w),
                        _buildStatCard(
                          icon: Icons.pause_circle,
                          label: "Inactive",
                          value: inactive.toString(),
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  );
                }),
                // Tab Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.purple500,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      indicatorSize: TabBarIndicatorSize.tab, // indicator covers full tab
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[700],
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: "Inactive"),
                        Tab(text: "Active"),
                      ],
                    ),
                  ),
                ),

                Gap(12.h),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        // Loading State
        if (controller.loading.value == Status.loading) {
          return _buildLoadingState();
        }

        // Error State
        if (controller.loading.value == Status.error) {
          return _buildErrorState(
            icon: Icons.error_outline,
            title: "Something went wrong!",
            subtitle: "Unable to load advertisements. Please try again.",
            onRetry: () => controller.getDetailsAdvertisement(),
          );
        }

        // Internet Error State
        if (controller.loading.value == Status.internetError) {
          return _buildErrorState(
            icon: Icons.wifi_off_rounded,
            title: "No Internet Connection",
            subtitle: "Please check your connection and try again.",
            onRetry: () => controller.getDetailsAdvertisement(),
          );
        }

        // No Data Found State
        if (controller.loading.value == Status.noDataFound) {
          return _buildErrorState(
            icon: Icons.inbox_outlined,
            title: "No Advertisements",
            subtitle: "You haven't created any advertisements yet.",
            showRetry: false,
          );
        }

        // Success State - Show TabBarView
        return TabBarView(
          controller: _tabController,
          children: [
            InactiveTab(),
            ActiveTab(),
          ],
        );
      }),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.sp),
            Gap(6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: value,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                CustomText(
                  text: label,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.purple500,
            strokeWidth: 3,
          ),
          Gap(20.h),
          CustomText(
            text: "Loading advertisements...",
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]!,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState({
    required IconData icon,
    required String title,
    required String subtitle,
    bool showRetry = true,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(28.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 72.sp,
                color: Colors.grey[500],
              ),
            ),
            Gap(28.h),
            CustomText(
              text: title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.grey[900]!,
              textAlign: TextAlign.center,
            ),
            Gap(10.h),
            CustomText(
              text: subtitle,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]!,
              textAlign: TextAlign.center,
            ),
            if (showRetry) ...[
              Gap(28.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: 20.sp),
                label: CustomText(
                  text: "Try Again",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple500,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  elevation: 2,
                  shadowColor: AppColors.purple500.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==================== Active Tab Widget ====================
class ActiveTab extends StatelessWidget {
  ActiveTab({super.key});
  final controller = GetControllers.instance.getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final advertisements = controller.profile.value.advertisement ?? [];
      final activeAdvertisements = advertisements
          .where((ad) => ad.status == "ACTIVE")
          .toList();

      if (activeAdvertisements.isEmpty) {
        return _buildEmptyState(
          icon: Icons.check_circle_outline,
          title: "No Active Advertisements",
          subtitle: "Publish your advertisements to see them here",
          color: Colors.green,
        );
      }

      return RefreshIndicator(
        onRefresh: () async => await controller.getDetailsAdvertisement(),
        color: AppColors.purple500,
        child: ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: activeAdvertisements.length,
          itemBuilder: (context, index) {
            final ad = activeAdvertisements[index];
            return _buildAdvertisementCard(
              ad: ad,
              index: index,
              isActive: true,
            );
          },
        ),
      );
    });
  }

  Widget _buildAdvertisementCard({
    required Advertisement ad,
    required int index,
    required bool isActive,
  }) {
    final images = ad.advertisementImg ?? [];

    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Status Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: CustomNetworkImage(
                  imageUrl: images.first,
                  height: 220.h,
                  width: double.infinity,
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
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
              ),
              // Status Badge
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.orange.shade600,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: (isActive ? Colors.green : Colors.orange)
                            .withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? Icons.check_circle : Icons.pause_circle,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      Gap(5.w),
                      CustomText(
                        text: isActive ? "Active" : "Inactive",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              // Image Count Badge
              if (images.length > 1)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.photo_library_rounded,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        Gap(5.w),
                        CustomText(
                          text: "${images.length}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          // Info Section
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Advertisement #${index + 1}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]!,
                        ),
                        Gap(4.h),
                        if (ad.createdAt != null)
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 13.sp,
                                color: Colors.grey[500],
                              ),
                              Gap(5.w),
                              CustomText(
                                text: _formatDate(ad.createdAt),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]!,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                if (ad.updatedAt != null && ad.updatedAt != ad.createdAt) ...[
                  Gap(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.update_rounded,
                          size: 13.sp,
                          color: Colors.blue.shade700,
                        ),
                        Gap(5.w),
                        CustomText(
                          text: "Updated ${_formatDate(ad.updatedAt)}",
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80.sp,
                color: color,
              ),
            ),
            Gap(28.h),
            CustomText(
              text: title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.grey[900]!,
              textAlign: TextAlign.center,
            ),
            Gap(10.h),
            CustomText(
              text: subtitle,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== Inactive Tab Widget ====================
class InactiveTab extends StatelessWidget {
  InactiveTab({super.key});
  final controller = GetControllers.instance.getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final advertisements = controller.profile.value.advertisement ?? [];
      final inactiveAdvertisements = advertisements
          .where((ad) => ad.status == "INACTIVE")
          .toList();

      if (inactiveAdvertisements.isEmpty) {
        return ActiveTab()._buildEmptyState(
          icon: Icons.pause_circle_outline,
          title: "No Inactive Advertisements",
          subtitle: "All your advertisements are currently active",
          color: Colors.orange,
        );
      }

      return RefreshIndicator(
        onRefresh: () async => await controller.getDetailsAdvertisement(),
        color: AppColors.purple500,
        child: ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: inactiveAdvertisements.length,
          itemBuilder: (context, index) {
            final ad = inactiveAdvertisements[index];
            return ActiveTab()._buildAdvertisementCard(
              ad: ad,
              index: index,
              isActive: false,
            );
          },
        ),
      );
    });
  }
}