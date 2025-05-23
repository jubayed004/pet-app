/*
import 'package:betwise_app/controller/get_controllers.dart';
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/core/route/route_path.dart';
import 'package:betwise_app/core/route/routes.dart';
import 'package:betwise_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:betwise_app/presentation/components/custom_button/custom_button.dart';
import 'package:betwise_app/presentation/components/custom_image/custom_image.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:betwise_app/presentation/screens/nav/controller/navigation_controller.dart';
import 'package:betwise_app/presentation/widget/show_custom_animated_dialog/inner_widgets/primary_container.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showCustomAnimatedDialogTwo({
  required BuildContext context,
  bool isDismissible = true,
  required NavigationControllerMain controller,
}) {
  final barrierLabel = MaterialLocalizations.of(context).modalBarrierDismissLabel;

  showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: barrierLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return Center(
        child: Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 8,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 350,
              minWidth: 350,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: CustomText(text: "Give Feedback",fontSize: 16,fontWeight: FontWeight.w500,textAlign: TextAlign.center,)),
                      GestureDetector(
                        onTap: (){
                          AppRouter.route.pop();
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.greenColor,
                          child: Icon(Icons.close,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                  Gap(16),
                  Divider(
                    height: 1,
                    color: Color(0xffEAECF0),
                  ),
                  Gap(24),
                  CustomText(text: "Reason for Feedback",fontWeight: FontWeight.w500,fontSize: 16,),
                  Gap(16),
                  CustomTextField(
                    hintText: "Select One ",
                    fieldBorderColor: AppColors.secondTextColor,
                    fillColor: Colors.white,
                  ),
                  Gap(24),
                  CustomText(text: "Description",fontWeight: FontWeight.w500,fontSize: 16,),
                  Gap(16),
                  PrimaryContainer(
                    radius: 10,
                    child: TextField(
                      onChanged: (value) {},
                      maxLines: 8,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                          border: InputBorder.none,
                          filled: false,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Briefly describe the issue...',
                          hintStyle: TextStyle(fontSize: 14, color: AppColors.blackColor)),
                    ),
                  ),
                  Gap(16),
                  CustomButton(onTap: (){
                    AppRouter.route.pop();
                    showSuccessDialog(
                      controller: controller,
                      context: context,
                      barrierLabel: barrierLabel,
                    );
                  },title: "Submit Report",)

                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      );
    },
  );
}

void showSecondDialog({required BuildContext context, required NavigationControllerMain controller, required String barrierLabel}){
  showCustomAnimatedDialog(
    animationSrc: "assets/images/warning.png",
    context: context,
    title: "Warning",
    subtitle: "Are you sure you want to change your password?",
    actionButton: [
      CustomButton(
        width: double.infinity,
        height: 36,
        fillColor: Colors.white,                 // White background
        borderWidth: 1,                          // Border width
        borderColor: AppColors.greenColor,               // Border color (black)
        onTap: () {
          AppRouter.route.pop();
        },
        textColor: AppColors.greenColor,
        title: "Cancel",
        isBorder: true,
        fontSize: 14,// Ensure the border is visible
      ),
      CustomButton(
        width: double.infinity,
        height: 36,
        onTap: (){


          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSuccessDialog(
              context: context,
              controller: controller,
              barrierLabel: barrierLabel,
            );
          });

        },
        title: " Confirm",
        fontSize: 14,

      ),
    ],
  );
}

void showSuccessDialog({required BuildContext context, required NavigationControllerMain controller, required String barrierLabel}){
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: barrierLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return Center(
        child: Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 8,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 200,
              minWidth: 150,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(
                    imageSrc: "assets/animation/success.json", // Pass dynamic image source (can be Lottie, PNG, or SVG)
                    width: 100,
                    height: 100,
                    boxFit: BoxFit.contain,
                  ),
                  Text(
                    "Success",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Thank you for your feedback!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff475569),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        height: 36,
                        width: 100,
                        onTap: () {
                          AppRouter.route.pop();
                          AppRouter.route.pop();
                          controller.selectedNavIndex.value =3;
                        },
                        title: "Confirm",
                        fontSize: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      );
    },
  );
}
*/
