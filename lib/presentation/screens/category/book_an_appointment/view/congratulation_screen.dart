import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class CongratulationScreen extends StatelessWidget {
   CongratulationScreen({super.key});
   final controller = GetControllers.instance.getNavigationControllerMain();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Congratulations",),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: padding16H,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.waitingforapprovel.svg(),
                    Gap(24),
                    Flexible(child: CustomText(text: "Waiting for the approval from Business Owner......",fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFFEEAB4A),)),
                    Gap(44),
                    CustomButton(onTap: (){
                      controller.selectedNavIndex.value = 0;
                      AppRouter.route.goNamed(RoutePath.navigationPage);
                      if (kDebugMode) {
                        print("object");
                      }
                    },textColor: Colors.black,title: "Go To Home Page",)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
