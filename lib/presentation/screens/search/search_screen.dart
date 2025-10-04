import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/search/widget/search_item_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

import 'model/country_city_model.dart';

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
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldState,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.pagingController.refresh();
          },
          child: CustomScrollView(
            slivers: [
              /// Top AppBar
              CustomDefaultAppbar(title: "What are you looking for?"),

              /// Floating Search Bar
              SliverPersistentHeader(
                floating: true,
                pinned: false,
                delegate: _SearchHeaderDelegate(
                  child: CupertinoSearchTextField(
                    controller: controller.searchController,
                    onSubmitted: (value) {
                      controller.search.value = value;
                      controller.pagingController.refresh();
                    },
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Iconsax.search_favorite,
                        color: AppColors.blackColor,
                      ),
                    ),
                    placeholder: "Search here...",
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12), // ⬅️ height বাড়বে
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                ),
              ),

              /// Paged List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: PagedSliverList<int, ServiceItem>(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ServiceItem>(
                    itemBuilder: (context, item, index) {
                      return SearchItemCardWidget(
                        item: item,
                        showWebsite: index == 1 || index == 3,
                        isShop: index == 1 ? false : true,
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
        ),
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // scroll অনুযায়ী নিচে offset
    double extraOffset = shrinkOffset > 0 ? 30 : 0;

    return Material(
      color: Colors.white,
      elevation: overlapsContent ? 4 : 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(14, extraOffset, 14, 8),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
