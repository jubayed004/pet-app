/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/screens/no_internet/error_card.dart';
import 'package:betwise_app/presentation/widget/custom_post_betwise/custom_post_betwise.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'model/home_model.dart';
import 'widget/home_app_bar.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final homeController = GetControllers.instance.getHomeController();
  final controller = GetControllers.instance.getProfileController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(

        slivers: [
          const SliverGap(34),

          /// SliverAppBar (Floating & Snap)
          SliverAppBar(
            floating: false,
            snap: false,
            pinned: false,
            backgroundColor: Colors.white,
            elevation: 0,
             toolbarHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Obx(() => controller.loading.value == Status.completed
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CustomNetworkImage(
                                imageUrl: */
/*controller.profile.value.data?.profileImage ??*//*
 "",
                              ),
                            )
                                : Shimmer.fromColors(
                              baseColor: AppColors.whiteColor.withAlpha(50),
                              highlightColor: AppColors.whiteColor.withAlpha(100),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => controller.loading.value == Status.completed
                                  ? Text(
                                "Hello Jane Copper ",
                           */
/* ${controller.profile.value.data?.firstName ?? ""} ${controller.profile.value.data?.lastName ?? ""}*//*

                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              )
                                  : Shimmer.fromColors(
                                baseColor: AppColors.whiteColor.withAlpha(50),
                                highlightColor: AppColors.whiteColor.withAlpha(100),
                                child: Container(
                                  height: 10,
                                  width: 120,
                                  color: AppColors.primaryColor,
                                ),
                              )),
                              const Text(
                                "Welcome to BetWisePicks",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: CupertinoSearchTextField(
                        onTap: () {
                          // Navigate or custom logic
                        },
                        keyboardType: TextInputType.none,
                        placeholder: "Search Here",
                        prefixIcon: Icon(Iconsax.search_favorite, color: AppColors.blackColor),
                        decoration: const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          /// Optional Extra UI
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text("Product Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),

          /// Paged List View
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: () async {
                homeController.pagingController.refresh();
              },
              child: PagedListView<int, HomePost>(
                pagingController: homeController.pagingController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                builderDelegate: PagedChildBuilderDelegate<HomePost>(
                  itemBuilder: (context, item, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.greenColor.withOpacity(0.4), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: CustomPostWidget(
                          timeAgo: DateFormat("DD MM YY").format(item.updatedAt ?? DateTime.now()),
                          matchTitle: item.postTitle??"🏀 Los Angeles Lakers ─vs─ Golden State Warriors.",
                          predictions: item.predictionDescription ?? "",
                          analystLabel: item.predictionType??"Gold Analyst",
                          image: Text(item.postImage ??"")*/
/* Assets.images.homeimage.image()*//*
,
                        ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) => Center(
                    child: ErrorCard(
                      onTap: () => homeController.pagingController.refresh(),
                      text: homeController.pagingController.error.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


*/
