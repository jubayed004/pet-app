/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/image/network_image.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:betwise_app/utils/app_const/app_const.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({super.key});
  final controller = GetControllers.instance.getProfileController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.white,
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
              borderRadius: BorderRadius.circular(25),
              child: controller.loading.value == Status.completed?
              CustomNetworkImage(imageUrl: */
/*controller.profile.value.data?.profileImage??*//*
 ""):
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                child: const Icon(Icons.person),
              ),
            ):Shimmer.fromColors(
              baseColor: AppColors.whiteColor.withValues(alpha: 0.2),
              highlightColor: AppColors.whiteColor.withValues(alpha: 0.5),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(()=>controller.loading.value == Status.completed?
          Text("Hello Jane Copper ",
     */
/*   ${controller.profile.value.data?.firstName??""} ${controller.profile.value.data?.lastName??""}*//*

              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)):
          Shimmer.fromColors(
            baseColor: AppColors.whiteColor.withValues(alpha: 0.2),
            highlightColor: AppColors.whiteColor.withValues(alpha: 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: width/3,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          )),
          Text("Welcome to BetWisePicks", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
        ],
      ),


    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
*/
