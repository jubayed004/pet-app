import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/presentation/widget/show_custom_animated_dialog/inner_widgets/primary_container.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:pet_app/presentation/widget/back_button/back_button.dart';
import 'package:url_launcher/url_launcher.dart';
class HelpCenterScreen extends StatelessWidget {
   HelpCenterScreen({super.key});
   final String phoneNumber = '12124567890';
  final profileController = GetControllers.instance.getProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Help Center",),
        SliverToBoxAdapter(
          child: Padding(
            padding: padding16H,
            child: Column(
              children: [
                 CustomAlignText(text: "Submit",fontSize: 16,fontWeight: FontWeight.w600,),
                Gap(12),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select a reason for feedback';
                    }
                    return null;
                  },
                  textEditingController: profileController.subject,
                  hintText: "Email ",
                  fieldBorderColor: AppColors.secondTextColor,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Color(0xFF767676)
                  ),
                ),
                Gap(16),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select a reason for feedback';
                    }
                    return null;
                  },
                  textEditingController: profileController.subject,
                  hintText: "Phone Number ",
                  fieldBorderColor: AppColors.secondTextColor,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                      color: Color(0xFF767676)
                  ),
                ),
                Gap(16),
                PrimaryContainer(
                  radius: 10,
                  child: TextFormField(
                    controller: profileController.feedback,
                    maxLines: 8,
                    style: const TextStyle(fontSize: 16, color:Color(0xFF767676)),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Briefly describe the issue...',
                      hintStyle: TextStyle(fontSize: 14, color: Color(0xFF767676)),
                    ),
                  ),
                ),
                Gap(16),
                CustomButton(onTap: (){
                  AppRouter.route.pop();
                },title: "Submit",textColor: Colors.black,)
              ],
            ),
          ),
        ),
          SliverToBoxAdapter(child: Gap(20)),

        ],
      ),
    );
  }

}
