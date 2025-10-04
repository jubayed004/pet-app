import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final profileController = GetControllers.instance.getProfileController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController feedback = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.text;
    phoneNumberController.text;
    feedback.text;
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomAlignText(text: "Submit",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,),
                    Gap(12),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Please enter your email address';
                        }
                        final emailRegExp = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegExp.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textEditingController: emailController,
                      hintText: "Email",
                      fieldBorderColor: AppColors.secondTextColor,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(
                        color: Color(0xFF767676),
                      ),
                    ),
                    Gap(16),
                    CustomTextField(
                      hintText: "Phone Number",
                      validator: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Please enter your phone number';
                        }
                        // Basic phone number pattern (allows spaces, dashes, parentheses, and starts with + or digit)
                        final phoneRegExp = RegExp(r'^\+?[0-9\s\-\(\)]{7,15}$');
                        if (!phoneRegExp.hasMatch(value.trim())) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      textEditingController: phoneNumberController,
                      fieldBorderColor: AppColors.secondTextColor,
                      fillColor: Colors.white,
                      keyboardType: TextInputType.phone,
                    ),
                    Gap(16),
                    PrimaryContainer(
                      radius: 10,
                      child: TextFormField(
                        controller: feedback,
                        maxLines: 8,
                        style: const TextStyle(fontSize: 16, color: Color(
                            0xFF767676)),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10,
                              right: 10,
                              bottom: 10,
                              top: 10),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Briefly describe the issue...',
                          hintStyle: TextStyle(fontSize: 14,
                              color: Color(0xFF767676)),
                        ),
                      ),
                    ),
                    Gap(16),
                    Obx(() {
                      return CustomButton(
                        isLoading: profileController.feedbackLoading.value,
                        onTap: () {
                          final body = {
                            "email": emailController.text,
                            "phone": phoneNumberController.text,
                            "message": feedback.text,
                          };
                          if (_formKey.currentState!.validate()) {
                            profileController.giveFeedback(body: body);
                          }
                        }, title: "Submit", textColor: Colors.black,);
                    })
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Gap(20)),

        ],
      ),
    );
  }
}
