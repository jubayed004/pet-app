import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class BusinessServiceScreen extends StatelessWidget {
  BusinessServiceScreen({super.key});
  final categoryController = GetControllers.instance.getBusinessServiceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          categoryController.pagingController.refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            CustomDefaultAppbar(
              title: "Services",
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Assets.icons.animalshelter.svg(),
                  GestureDetector(
                    onTap: () {
                AppRouter.route.pushNamed(RoutePath.businessAddServiceScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 26, color: const Color(0xff3F5332)),
                        const Gap(6),
                        const CustomText(
                          text: "Add Service",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3F5332),
                        )
                      ],
                    ),
                  ),
                  const Gap(16), // spacing before list
                ],
              ),
            ),
            PagedSliverList<int, Widget>(

              pagingController: categoryController.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Widget>(

                itemBuilder: (context, item, index) {

                  return item;
                },
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: ErrorCard(
                    onTap: () => categoryController.pagingController.refresh(),
                    text: categoryController.pagingController.error.toString(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
