import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class VendorSelectionScreen extends StatefulWidget {
  const VendorSelectionScreen({super.key});

  @override
  State<VendorSelectionScreen> createState() => _VendorSelectionScreenState();
}

class _VendorSelectionScreenState extends State<VendorSelectionScreen> {
  final _authController = GetControllers.instance.getAuthController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Assets.images.onbordingone.image(),

                 ],
               ),
            CustomText(text: AppStrings.wherePet,fontSize: 24,fontWeight : FontWeight.w400,maxLines: 2,),
            CustomButton(
              onTap: (){
                _authController.isUser.value = true;
                AppRouter.route.goNamed(RoutePath.signUpScreen);
              },
              title: AppStrings.petOwner,
              textColor: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w600,
               showIcon: true,
               icon: Assets.icons.petowner.svg(),
            ),
            CustomButton(
              onTap: (){
                _authController.isUser.value = false;
                AppRouter.route.goNamed(RoutePath.signUpScreen);
              },
              fillColor: Colors.white,

              borderColor: AppColors.primaryColor,
              isBorder: true,
              title: AppStrings.businessOwners,
              textColor: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w600,
               showIcon: true,
               icon: Assets.icons.businessowner.svg(),
            ),
          ],
        ),
      ),
    );
  }
}
