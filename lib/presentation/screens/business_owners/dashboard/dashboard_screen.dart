import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/dashboard/widgets/sales_overview_chart.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/variable/variable.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body:  CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title:"Dashboard"),
          SliverToBoxAdapter(child: SalesOverviewChart()),

          SliverPadding(
            padding: padding12H,
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: vendorGridList.length,
                    (context, index) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.kScaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 7.r),
                    ],
                  ),
                  child: ButtonTapWidget(
                    radius: 8.r,
                    onTap: () {
                    /*  Get.toNamed(vendorGridList[index].route);*/
                      AppRouter.route.pushNamed(vendorGridList[index].route);
                    },
                    child: Padding(
                      padding: padding8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          vendorGridList[index].img,
                          FittedBox(
                            child: CustomText(
                              text: vendorGridList[index].title,
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 18.w,crossAxisSpacing: 18.w
              ),
            ),
          ),
        ],
      ),
    );
  }
}
