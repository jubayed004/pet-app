import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/screens/subscription/widgets/active_subscription_view.dart';

import 'package:pet_app/presentation/screens/subscription/widgets/subscription_feature_list.dart';
import 'package:pet_app/presentation/screens/subscription/widgets/subscription_header.dart';
import 'package:pet_app/presentation/screens/subscription/widgets/subscription_hero.dart';
import 'package:pet_app/presentation/screens/subscription/widgets/subscription_plan_card.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final controller = GetControllers.instance.getSubscriptionController();
  int selectedPlanIndex = 1; // Default to Yearly

  @override
  void initState() {
    super.initState();
    controller.fetchSubscription();
    controller.fetchCustomerInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.hasActiveSubscription) {
        return ActiveSubscriptionView(controller: controller);
      }

      final allOfferings = controller.allOfferings.value;
      final offering = allOfferings['default']; // Assuming 'default' offering

      if (offering == null || offering.availablePackages.isEmpty) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // Find monthly and yearly packages manually from the available packages list
      Package? monthlyPackage;
      Package? yearlyPackage;

      for (var pkg in offering.availablePackages) {
        if (pkg.packageType == PackageType.monthly) {
          monthlyPackage = pkg;
        } else if (pkg.packageType == PackageType.annual) {
          yearlyPackage = pkg;
        }
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SubscriptionHeader(
                onClose: () => Navigator.pop(context),
                controller: controller,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      const SubscriptionHero(),
                      SizedBox(height: 32.h),
                      const SubscriptionFeatureList(),
                      SizedBox(height: 48.h),
                      if (monthlyPackage != null) ...[
                        SubscriptionPlanCard(
                          title: 'Monthly',
                          price: monthlyPackage.storeProduct.priceString,
                          period: '/ month',
                          package: monthlyPackage,
                          isSelected: selectedPlanIndex == 0,
                          onTap: () => setState(() => selectedPlanIndex = 0),
                        ),
                      ],
                      if (yearlyPackage != null) ...[
                        SizedBox(height: 16.h),
                        SubscriptionPlanCard(
                          title: 'Yearly',
                          price: yearlyPackage.storeProduct.priceString,
                          period: '/ year',
                          package: yearlyPackage,
                          savings: 'Save 50%',
                          isPopular: true,
                          isSelected: selectedPlanIndex == 1,
                          onTap: () => setState(() => selectedPlanIndex = 1),
                        ),
                      ],
                      SizedBox(height: 32.h),
                      _buildBottomSection(monthlyPackage, yearlyPackage),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomSection(Package? monthlyPackage, Package? yearlyPackage) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20.r,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed:
                  controller.isPurchasing.value
                      ? null
                      : () => _handlePurchase(monthlyPackage, yearlyPackage),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
                shadowColor: Colors.blue.withValues(alpha: 0.4),
              ),
              child:
                  controller.isPurchasing.value
                      ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                      : Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
          SizedBox(height: 20.h),
          // Legal Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink(
                text: 'Privacy Policy',
                onTap: () => AppRouter.route.pushNamed(RoutePath.privacyPolicy),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "•",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              _buildLink(
                text: 'Terms of Use',
                onTap:
                    () => AppRouter.route.pushNamed(RoutePath.termsOfCondition),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Store Compliance Text
          Text(
            'Payment will be charged to your iTunes/Google Play Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Your account will be charged for renewal within 24-hours prior to the end of the current period. You can manage your subscription and turn off auto-renewal by going to your Account Settings after purchase. Any unused portion of a free trial period, if offered, will be forfeited when you purchase a subscription.',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey.shade500,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLink({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _handlePurchase(Package? monthlyPackage, Package? yearlyPackage) async {
    final selectedPackage =
        selectedPlanIndex == 1 ? yearlyPackage : monthlyPackage;

    if (selectedPackage == null) {
      Get.snackbar(
        'Error',
        'Selected plan is not available',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final success = await controller.purchasePackage(selectedPackage);
    if (success == true) {
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }
}
