import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class AllPetsScreen extends StatefulWidget {
  const AllPetsScreen({super.key});

  @override
  State<AllPetsScreen> createState() => _AllPetsScreenState();
}

class _AllPetsScreenState extends State<AllPetsScreen> {
  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myPetsController.getAllPet();
    });
  }

  Future<void> _refresh() async {
    await myPetsController.getAllPet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      top: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: _refresh,
          color: AppColors.purple500,
          child: Obx(() {
            final status = myPetsController.loading.value;
            final pets = myPetsController.profile.value.pet ?? [];

            /// Loading State
            if (status == Status.loading) {
              return _buildLoadingState();
            }

            /// Internet Error State
            if (status == Status.internetError) {
              return _buildErrorState(
                icon: Iconsax.wifi_square,
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                onRetry: () => myPetsController.getAllPet(),
              );
            }

            /// General Error State
            if (status == Status.error) {
              return _buildErrorState(
                icon: Iconsax.danger,
                title: "Something Went Wrong",
                message: "We couldn't load your pets. Please try again.",
                onRetry: () => myPetsController.getAllPet(),
              );
            }

            /// No Data Found State
            if (status == Status.noDataFound || pets.isEmpty) {
              return _buildEmptyState();
            }

            /// Success State - Show Pets List
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                CustomDefaultAppbar(title: "All Pets"),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "${pets.length} ${pets.length == 1 ? 'Pet' : 'Pets'}",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = pets[index];
                      return _buildPetCard(item, index);
                    }, childCount: pets.length),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Modern Pet Card Widget
  Widget _buildPetCard(item, int index) {
    final String id = item.id ?? "";
    final String name = item.name ?? "Unknown";
    final String petType = item.animalType ?? "Unknown Type";
    final String breed = item.breed ?? "";
    final String photo = (item.petPhoto ?? "").trim();
    final String gender = item.gender ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => AppRouter.route.pushNamed(RoutePath.myPetsDetailsScreen, extra: id),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                /// Pet Avatar
                Hero(
                  tag: 'pet_$id',
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                          photo.isEmpty
                              ? LinearGradient(
                                colors: [AppColors.purple200, AppColors.purple500.withValues(alpha: 0.6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                              : null,
                      image: photo.isNotEmpty ? DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover) : null,
                      border: Border.all(color: AppColors.purple500.withValues(alpha: 0.2), width: 2),
                    ),
                    child: photo.isEmpty ? Icon(Iconsax.pet5, color: AppColors.purple500, size: 28.sp) : null,
                  ),
                ),
                SizedBox(width: 12.w),

                /// Pet Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.grey[900]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (gender.isNotEmpty) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              gender.toUpperCase() == "MALE" ? Iconsax.man : Iconsax.woman,
                              size: 16.sp,
                              color: gender.toUpperCase() == "MALE" ? Colors.blue : Colors.pink,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(petType, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.purple500)),
                      if (breed.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(breed, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]), overflow: TextOverflow.ellipsis),
                      ],
                    ],
                  ),
                ),

                /// Delete Button
                Container(
                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8.r)),
                  child: IconButton(
                    onPressed: () => _showDeleteDialog(id, name),
                    icon: Icon(Iconsax.trash, color: Colors.red, size: 20.sp),
                    padding: EdgeInsets.all(8.w),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(String id, String name) {
    defaultDeletedYesNoDialog(context: context, title: 'Are you sure you want to delete $name?', onYes: () => myPetsController.deletedPet(id: id));
  }

  /// Loading State
  Widget _buildLoadingState() {
    return CustomScrollView(
      slivers: [
        CustomDefaultAppbar(title: "All Pets"),
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 24.h),
                Text("Loading your pets...", style: TextStyle(fontSize: 16.sp, color: Colors.grey[600], fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Error State
  Widget _buildErrorState({required IconData icon, required String title, required String message, required VoidCallback onRetry}) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        CustomDefaultAppbar(title: "All Pets"),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                    child: Icon(icon, size: 64.sp, color: Colors.grey[400]),
                  ),
                  SizedBox(height: 24.h),
                  Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.grey[900]), textAlign: TextAlign.center),
                  SizedBox(height: 12.h),
                  Text(message, style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5), textAlign: TextAlign.center),
                  SizedBox(height: 32.h),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: Icon(Iconsax.refresh, size: 20.sp),
                    label: Text("Try Again", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple500,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Empty State
  Widget _buildEmptyState() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        CustomDefaultAppbar(title: "All Pets"),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(color: AppColors.purple200.withOpacity(0.3), shape: BoxShape.circle),
                    child: Icon(Iconsax.pet5, size: 80.sp, color: AppColors.purple500),
                  ),
                  SizedBox(height: 24.h),
                  Text("No Pets Yet", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.grey[900])),
                  SizedBox(height: 12.h),
                  Text(
                    "You haven't added any pets yet. Add your first pet to get started!",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton.icon(
                    onPressed: () => myPetsController.getAllPet(),
                    icon: Icon(Iconsax.refresh, size: 20.sp),
                    label: Text("Refresh", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple500,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
