/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/widget/align/custom_align_text.dart';
import 'package:betwise_app/presentation/widget/back_button/back_button.dart';
import 'package:betwise_app/presentation/widget/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/widget/text_field/custom_text_field.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


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
      leading: CustomBackButton(
        onTap: () {
          AppRouter.route.pop();
        },
      ),
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
                    text: "Access your account and stay ahead with expert picks."
                        , color: AppColors.secondTextColor, maxLines: 3),
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
                    isLoading: _authController.forgetLoading.value,
                    title: "continue", onTap: () {

                    if (_formKey.currentState!.validate()) {
                      _authController.forget();
                    }
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
*/
