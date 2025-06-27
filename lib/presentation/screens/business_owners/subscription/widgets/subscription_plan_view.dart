
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:flutter/material.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/dialog/show_custom_animated_dialog.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';


class SubscriptionPlanView extends StatefulWidget {
  final String planName;
  final double price;

  final Color color;
  final Color containerColor;
  final String id;
  final List<String> features;

  // Ensure the constructor accepts both parameters
  const SubscriptionPlanView({super.key, required this.planName, required this.price, required this.color, required this.containerColor, required this.id, required this.features});

  @override
  State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
}

class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
  final subscriptionController = GetControllers.instance.getSubscriptionController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.blackColor.withValues(alpha: 0.1),
              )),
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Monthly Plan Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.planName} Plan",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Gap(10),
                // Plan Price
                Text.rich(
                  TextSpan(
                    text: widget.price.toString()??
                        "",
                    // Fixed this
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: AppColors.greenColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' / month',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Gap(15),
                // Features List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.features.length, (index){
                    print(widget.features.length);
                    return  _buildFeature(widget.features[index]);
                  }),
                ),
                Gap(20),
                // Subscribe Now Button
                CustomButton(
                  onTap: () {
                    showCustomAnimatedDialog(
                      context: context,
                      title: "Success",
                      subtitle:
                      "Your subscription plan has been changed successfully.",
                      animationSrc: "assets/animation/success.json",
                      // Path to your Lottie animation
                      isDismissible: true,
                      actionButton: [
                        CustomButton(
                          height: 36,
                          width: 100,
                          onTap: () {
                       AppRouter.route.goNamed(RoutePath.businessNavigationPage,); // Navigate
                          },
                          title: "Confirm",
                          fontSize: 14,
                        ),
                      ],
                    );
                    showCustomAnimatedDialog(
                      animationSrc: "assets/images/warning.png",
                      context: context,
                      title: "Warning",
                      subtitle: "Are you sure you want to change your subscription plan?",
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
                          onTap: ()async{

                            AppRouter.route.pop();
                           // subscriptionController.paymentUrl(subscriptionId: widget.id);
                            AppRouter.route.goNamed(RoutePath.businessNavigationPage,); // N
                          },
                          title: " Confirm",
                          fontSize: 14,

                        ),
                      ],
                    );
                  },
                  title: "Subscription Now",
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeature(String feature) {
    return Row(
      children: [
        Icon(Icons.check, color: Color(0xFF22C55E), size: 20),
        Gap(8),
        Text(feature),
      ],
    );
  }
}

