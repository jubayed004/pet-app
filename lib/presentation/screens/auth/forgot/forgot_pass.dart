import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';


class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});

  final _authController = GetControllers.instance.getAuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
  appBar: AppBar(
    backgroundColor: Colors.white,
    title: CustomText(text: AppStrings.forgotPasswordScreen,fontWeight: FontWeight.w500,fontSize: 18,),
    centerTitle: true,
  ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(text: "Verify Your Email",
                    fontWeight: FontWeight.w800,
                    fontSize: 24),
                Gap(8),
                CustomText(
                    text: AppStrings.enterYourEmailAnd
                        , color: AppColors.secondTextColor, maxLines: 3,fontSize: 14,fontWeight: FontWeight.w400,),
                const Gap(24),

                //=============================== Email text ==================================
                CustomAlignText(text: "Email"),
                const Gap(8),
                CustomTextField(
                  fillColor: Colors.white,
                  hintText: "Verify Your Email",
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: _authController.forgetEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email_is_required'.tr;
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter_a_valid_email'.tr;
                    }
                    return null;
                  },
                ),
                Gap(24),

                Obx(() {
                  return CustomButton(
                    textColor: Colors.black,
                    isLoading: _authController.forgetLoading.value,
                    title: "Send Code", onTap: () {

              /*      if (_formKey.currentState!.validate()) {
                      _authController.forget();
                    }*/
                    
                    AppRouter.route.pushNamed(RoutePath.verifyOtpScreen);
                  },
                  );
                }),

                Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
