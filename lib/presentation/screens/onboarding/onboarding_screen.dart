
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final _controller = GetControllers.instance.getOnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: PageView(
        onPageChanged: (index) {
          _controller.currentIndex.value = index;
        },
        children: [
          OnboardingPageCard(),
          OnboardingPageCard(),
          OnboardingPageCard(),
        ],
      ),
    );
  }
}

class OnboardingPageCard extends StatelessWidget {
  final _controller = GetControllers.instance.getOnboardingController();

  OnboardingPageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        bottom: 24,
        top: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if(_controller.currentIndex.value > 0){
                        _controller.currentIndex.value--;
                      }
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        AppRouter.route.goNamed(RoutePath.signInScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Skip",
                          fontSize: 16.sp,
                          // Bigger text for tablets
                          fontWeight: FontWeight.w700,
                          color: AppColors.greenColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Obx(() {
            return CustomImage(
              width: width,
              height: 235.h,
              boxFit: BoxFit.fill,
              imageSrc: _controller.onboardingList[_controller.currentIndex
                  .value].image,
            );
          }),
          Obx(() {
            return CustomText(
              text: _controller.onboardingList[_controller.currentIndex.value]
                  .title,
              fontSize: 32.sp,
              // Bigger text for tablets
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
              maxLines: 2,
            );
          }),
          Obx(() {
            return CustomText(
              text: _controller.onboardingList[_controller.currentIndex.value]
                  .details,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondTextColor,
              textAlign: TextAlign.center,
              maxLines: 2,
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index, context)),
          ),

          SizedBox(height: 12.h),

          Obx(() {
            return CustomButton(
              onTap: () {
                if (_controller.currentIndex.value < 2) {
                  _controller.currentIndex.value =
                      _controller.currentIndex.value + 1;
                } else {
                  AppRouter.route.pushNamed(RoutePath.signInScreen);
                }
              },
              textColor: AppColors.blackColor,
              showIcon: true,
              title: _controller.currentIndex.value >= 2 ? "Get Started" : 'Next',
              fontSize: 20.sp,
              width: double.infinity,
              height: 60.h,
              fillColor: AppColors.primaryColor,
              iconSize: 8.sp,
            );
          }),
        ],
      ),
    );
  }

  buildDot(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Obx(() {
        return Container(
          height: 6.h,
          width: _controller.currentIndex.value == index ? 24 : 6,
          margin: EdgeInsets.only(right: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _controller.currentIndex.value == index ?
            AppColors.greenColor : AppColors.lightGray,
          ),
        );
      }),
    );
  }
}
