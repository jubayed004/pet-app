import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';

class SubscriptionBottomAction extends StatelessWidget {
  final VoidCallback onSubscribe;
  final bool isPurchasing;

  const SubscriptionBottomAction({
    super.key,
    required this.onSubscribe,
    required this.isPurchasing,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: isPurchasing ? null : onSubscribe,
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
                  isPurchasing
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
}
