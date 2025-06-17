
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

import 'widget/search_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = GetControllers.instance.getSearchScreenController();
  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldState,

        body: Obx(() {
          return RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: CustomScrollView(
              slivers: [
                CustomDefaultAppbar(title: "What are you looking for?",),
                /// Floating AppBar (Search + Filter)
                SliverPersistentHeader(

                  floating: true,
                  pinned: false,
                  delegate: _SearchHeaderDelegate(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: CupertinoSearchTextField(
                                controller: controller.searchController,
                                onSubmitted: (value) {
                                  controller.search.value = value;
                                  controller.pagingController.refresh();
                                },
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(Iconsax.search_favorite,
                                      color: AppColors.blackColor),
                                ),
                                placeholder: "Chicago Bulls vs Brooklyn Nets",
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1),
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
           /*               GestureDetector(
                            onTap: () {
 controller.search.value = "";
                            controller.searchController.clear();

                              _scaffoldState.currentState?.openEndDrawer();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                border: Border.all(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Assets.icons..svg(),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
                controller.search.value.isEmpty ?
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Search history",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,),
                            CustomText(text: "Clear all",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,)
                          ],
                        ),
                        Gap(16),
                        Wrap(
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 8),
                              child: GestureDetector(
                                onTap: (){
                                  controller.search.value = "kifrir4";
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.greenColor, width: 1),
                                      color: Color(0xffF0FDF4),
                                    ),
                                    child: Text("Los Angeles Lakers")),
                              ),
                            );
                          }),
                        )

                      ],
                    ),
                  ),
                ) :
                /// Paged List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: PagedSliverList<int, Widget>(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Widget>(
                      itemBuilder: (context, item, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16, top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.greenColor.withOpacity(0.4),
                                width: 1),
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
                            child: item,
                          ),
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) {
                        return Center(
                          child: ErrorCard(
                            onTap: () => controller.pagingController.refresh(),
                            text: controller.pagingController.error,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// Delegate class for scrollable search/filter app bar
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Material(
      color: Colors.white,
      elevation: overlapsContent ? 4 : 0,
      child: child,
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
