import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/dashboard/widgets/sales_overview_chart.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/utils/variable/variable.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final controller = GetControllers.instance.getDashBoardController();

  @override
  Widget build(BuildContext context) {
    final List<_BookingItem> items = [
      _BookingItem(
        title: 'Total ongoing',
        icon: Icons.event,
        count: 1245,
        color: Colors.pinkAccent,
      ),
      _BookingItem(
        title: 'Total Pending',
        icon: Icons.pending_actions,
        count: 215,
        color: Colors.pinkAccent,
      ),
      _BookingItem(
        title: 'Total Completed',
        icon: Icons.check_circle,
        count: 215,
        color: Colors.pinkAccent,
      ),
      _BookingItem(
        title: 'Total Reject',
        icon: Icons.cancel_schedule_send,
        count: 1245,
        color: Colors.pinkAccent,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Dashboard"),
          /* SliverToBoxAdapter(child: SalesOverviewChart()),*/
          SliverToBoxAdapter(
            child: Obx(() {
              return Padding(
                padding: paddingH12V6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "salesOverview ,(${controller.selectedView})", fontSize: 16,),
                    Container(
                      color: AppColors.purple500,
                      child: SizedBox(
                        height: 20.w,
                        child: DropdownButton<String>(
                          padding: padding6H,
                          value: controller.selectedView.value,
                          dropdownColor: AppColors.kPrimaryLightDarkColor,
                          underline: SizedBox(),
                          icon: Icon(Icons.keyboard_arrow_down_sharp, size: 15.sp,),
                          iconEnabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          items: ['Monthly', 'weekly'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) {
                           controller.selectedView.value=value!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = items[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.r,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 32.sp, color: item.color),
                            SizedBox(height: 12.h),
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              item.count.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.7,
              ),
            ),
          ),
          SliverPadding(
            padding: padding12H,
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: vendorGridList.length,
                    (context, index) =>
                    Container(
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
                  mainAxisSpacing: 18.w,
                  crossAxisSpacing: 18.w
              ),
            ),
          ),
        ],
      ),
    );
  }

}
class _BookingItem {
  final String title;
  final IconData icon;
  final int count;
  final Color color;

  _BookingItem({
    required this.title,
    required this.icon,
    required this.count,
    required this.color,
  });
}