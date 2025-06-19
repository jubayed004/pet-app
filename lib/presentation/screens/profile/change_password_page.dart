import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/change-pass';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Change Password",),
          SliverToBoxAdapter(child:  Padding(
            padding: paddingH16V8,
            child: Column(

              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomText(text: 'Current Password',fontWeight: FontWeight.w500,fontSize: 16,),
                CustomTextField(

                  fillColor: AppColors.whiteColor,
                  hintText: "Enter current password",
                  isPassword: true,
                  fieldBorderColor: AppColors.purple200,
                ),

                CustomText(text: 'New Password',fontWeight: FontWeight.w500,fontSize: 16,),

                CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  hintText: "Enter new password",
                  isPassword: true,
                  fieldBorderColor: AppColors.purple200,
                ),

                CustomText(text: 'Retype Password',fontWeight: FontWeight.w500,fontSize: 16,),

                CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  hintText: "Retype new password" ,
                  isPassword: true,
                  fieldBorderColor: AppColors.purple200,
                ),
                Gap(8),
                CustomButton(onTap: () {
                 AppRouter.route.pop();
                }, title: "Change Password",textColor: Colors.black,),
              ],
            ),
          ),)
        ],
      ),
    );
  }
}
