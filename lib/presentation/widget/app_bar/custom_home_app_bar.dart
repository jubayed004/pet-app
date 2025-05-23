/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transport/core/custom_assets/assets.gen.dart';
import 'package:transport/presentation/screens/user/profile/controller/user_profile_controller.dart';
import 'package:transport/utils/app_colors/app_colors.dart';
import 'package:transport/utils/app_const/app_const.dart';

class CustomHomeAppBar extends StatelessWid get implements PreferredSizeWidget {
  CustomHomeAppBar({super.key, required this.scaffoldStateKey});

  final GlobalKey<ScaffoldState> scaffoldStateKey;
  final controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double width = MediaQuery.of(context).size.width;
    return AppBar(
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle
          ),
          child: Obx(()=>controller.loading.value == Status.completed?ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: controller.profile.value.data?.profileImage != null ? CachedNetworkImage(
              imageUrl: AppConstants.baseURL+controller.profile.value.data!.profileImage!,
              placeholder: (context, data) =>
              const Center(child: CircularProgressIndicator(),),
              errorWidget: (context, data, errorWidget) =>
              const Icon(Icons.person),
              fit: BoxFit.cover,
            ) : const SizedBox(),
          ):Shimmer.fromColors(
            baseColor: isDarkMode?AppColors.whiteColor.withOpacity(0.2):AppColors.blackColor.withOpacity(0.2),
            highlightColor: isDarkMode?AppColors.whiteColor.withOpacity(0.5):AppColors.blackColor.withOpacity(0.5),
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayColor,
              ),
            ),
          )),
        ),
      ),
      centerTitle: false,
      title: Obx(()=>controller.loading.value == Status.completed?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.profile.value.data?.name ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 20),
              Flexible(child: Text(
                "${controller.profile.value.data?.addressLine ??
                    ""} ${controller.profile.value.data?.addressCity ??
                    ""} ${controller.profile.value.data?.addressState ??
                    ""} ${controller.profile.value.data?.country ?? ""}",
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),)),
            ],
          ),
        ],
      ):Shimmer.fromColors(
        baseColor: isDarkMode?AppColors.whiteColor.withOpacity(0.2):AppColors.blackColor.withOpacity(0.2),
        highlightColor: isDarkMode?AppColors.whiteColor.withOpacity(0.5):AppColors.blackColor.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              width: width/3,
              color: AppColors.grayColor,
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20),
                Container(
                  height: 10,
                  width: width/2,
                  color: AppColors.grayColor,
                ),
              ],
            ),
          ],
        ),
      )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? const Color(0xFF1C1B1B) : const Color(
                  0xFFE6F2FF),
            ),
            child: IconButton(
              onPressed: () {
                scaffoldStateKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu, color: AppColors.blueColor),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
*/
