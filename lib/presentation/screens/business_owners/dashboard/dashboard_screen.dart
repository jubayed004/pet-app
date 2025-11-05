import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button_tap/custom_button_tap.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/variable/variable.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}



class _DashboardScreenState extends State<DashboardScreen> {
  final controller = GetControllers.instance.getDashBoardController();



  @override
  void initState() {
    controller.getDashboard(statuse: "monthly");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.getDashboard(statuse: "monthly");
        },
        child: CustomScrollView(
          slivers: [
            const CustomDefaultAppbar(title: "Dashboard"),
            /// Dropdown selection
            SliverToBoxAdapter(
              child: Padding(
                padding: paddingH12V6,
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Booking Overview (${controller.selectedView.value})",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.purple500,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: DropdownButton<String>(
                          value: controller.selectedView.value,
                          dropdownColor: AppColors.kPrimaryLightDarkColor,
                          underline: const SizedBox(),
                          icon: Icon(Icons.keyboard_arrow_down_sharp, size: 20.sp, color: Colors.white),
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          items: ['Monthly', 'Weekly'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(value, style: const TextStyle(color: Colors.white)),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null && value != controller.selectedView.value) {
                              controller.selectedView.value = value;
                              // Automatically triggers API call via .ever in controller
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }),

              ),
            ),
            /// Stats Grid
            SliverToBoxAdapter(
              child: Obx(() {
                final status = controller.loading.value;

                if (status == Status.loading) {
                  return const Center(
                      child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator()));
                }
                if (status == Status.error) {
                  return _buildMessage("Something went wrong");
                }
                if (status == Status.internetError) {
                  return _buildMessage("No internet connection\nPull down to retry");
                }
                if (status == Status.noDataFound) {
                  return _buildMessage("No data found");
                }

                final counts = controller.dashboard.value.counts;

                final List<_BookingItem> items = [
                  _BookingItem(
                    title: 'Pending',
                    icon: Icons.pending_actions,
                    count: counts?.pending ?? 0,
                    color: Colors.orange,
                  ),
                  _BookingItem(
                    title: 'Approved',
                    icon: Icons.verified,
                    count: counts?.approved ?? 0,
                    color: Colors.blue,
                  ),
                  _BookingItem(
                    title: 'Completed',
                    icon: Icons.done_all,
                    count: counts?.completed ?? 0,
                    color: Colors.green,
                  ),
                  _BookingItem(
                    title: 'Rejected',
                    icon: Icons.cancel,
                    count: counts?.rejected ?? 0,
                    color: Colors.red,
                  ),
                  _BookingItem(
                    title: 'Cancelled',
                    icon: Icons.block,
                    count: counts?.cancelled ?? 0,
                    color: Colors.grey,
                  ),
                  _BookingItem(
                    title: 'Total Bookings',
                    icon: Iconsax.book,
                    count: counts?.total ?? 0,
                    color: Colors.purple,
                  ),
                ];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 22.w,
                      childAspectRatio: 0.8,

                    ),
                    itemBuilder: (context, index) =>
                        _buildStatCard(items[index]),
                  ),
                );
              }),
            ),
            SliverPadding(
              padding: paddingH12V6,
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: vendorGridList.length,
                      (context, index) =>
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.whiteColor,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,

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

      ),
    );
  }

  Widget _buildStatCard(_BookingItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.r,
            offset: Offset(0, 2.r),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
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
    );
  }

  Widget _buildMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Text(message, style: TextStyle(fontSize: 16.sp)),
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
