import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionController extends GetxController {
  final DBHelper dbHelper = serviceLocator<DBHelper>();

  // Observable States
  final RxBool isLoading = false.obs;
  final RxBool isPurchasing = false.obs;
  final RxBool isRestoring = false.obs;
  final Rx<Map<String, Offering>> allOfferings = Rx<Map<String, Offering>>({});
  final Rx<CustomerInfo?> customer = Rx<CustomerInfo?>(null);

  // Getters
  bool get hasActiveSubscription =>
      customer.value?.entitlements.active.isNotEmpty ?? false;

  EntitlementInfo? get activeEntitlement {
    final entitlements = customer.value?.entitlements.active.values;
    if (entitlements == null || entitlements.isEmpty) return null;
    return entitlements.first;
  }

  /// Check if service type is "Friendly Place" (FREE)
  bool isFriendlyPlace(String? serviceType) {
    if (serviceType == null) return false;
    return serviceType.toLowerCase().trim() == "friendly";
  }

  /// Fetch subscription offerings
  Future<void> fetchSubscription() async {
    isLoading.value = true;
    try {
      final offerings = await Purchases.getOfferings();
      allOfferings.value = offerings.all;

      if (kDebugMode) {
        offerings.all.forEach((key, offering) {
          debugPrint("📦 Offering: $key");
          for (final pkg in offering.availablePackages) {
            debugPrint("  ├─ Package: ${pkg.identifier}");
            debugPrint("  ├─ Product: ${pkg.storeProduct.identifier}");
            debugPrint("  └─ Price: ${pkg.storeProduct.priceString}");
          }
        });
      }
    } catch (e) {
      debugPrint("❌ Error fetching subscriptions: $e");
      toastMessage(message: "Failed to load subscription plans");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch customer info
  Future<void> fetchCustomerInfo() async {
    try {
      final info = await Purchases.getCustomerInfo();
      customer.value = info;

      if (kDebugMode) {
        debugPrint("👤 Customer Info Updated");
        debugPrint(
          "Active Subscriptions: ${info.entitlements.active.keys.join(", ")}",
        );
      }
    } catch (e) {
      debugPrint("❌ Error fetching customer info: $e");
    }
  }

  /// Purchase package - Returns true if successful
  Future<bool> purchasePackage(Package package) async {
    isPurchasing.value = true;

    try {
      final PurchaseResult result = await Purchases.purchasePackage(package);
      customer.value = result.customerInfo;

      if (kDebugMode) {
        debugPrint("✅ Purchase Successful!");
        debugPrint(
          "Active Entitlements: ${result.customerInfo.entitlements.active.keys.join(", ")}",
        );
      }

      toastMessage(message: "Subscription activated successfully!");
      return true;
    } on PlatformException catch (e) {
      _handlePurchaseError(e);
      return false;
    } catch (e) {
      debugPrint("❌ Purchase Error: $e");
      toastMessage(message: "Purchase failed. Please try again.");
      return false;
    } finally {
      isPurchasing.value = false;
    }
  }

  /// Handle purchase errors
  void _handlePurchaseError(PlatformException e) {
    switch (e.code) {
      case '1':
        debugPrint("ℹ️ User cancelled purchase");
        break;
      case '2':
        toastMessage(message: "Store unavailable. Try again later.");
        break;
      case '3':
        toastMessage(message: "Purchase not allowed on this device");
        break;
      case '4':
        toastMessage(message: "Invalid purchase");
        break;
      case '5':
        toastMessage(message: "Product not available");
        break;
      default:
        toastMessage(message: "Purchase failed: ${e.message}");
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    isRestoring.value = true;

    try {
      final CustomerInfo customerInfo = await Purchases.restorePurchases();
      customer.value = customerInfo;

      if (customerInfo.entitlements.active.isNotEmpty) {
        toastMessage(message: "Purchases restored successfully!");
        debugPrint(
          "✅ Restored: ${customerInfo.entitlements.active.keys.join(", ")}",
        );
      } else {
        toastMessage(message: "No active purchases found");
      }
    } catch (e) {
      debugPrint("❌ Restore Error: $e");
      toastMessage(message: "Failed to restore purchases");
    } finally {
      isRestoring.value = false;
    }
  }

  /// Launch subscription management
  Future<void> launchManageSubscriptions(BuildContext context) async {
    try {
      final uri =
          Platform.isAndroid
              ? Uri.parse('https://play.google.com/store/account/subscriptions')
              : Uri.parse('https://apps.apple.com/account/subscriptions');

      final canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        toastMessage(message: "Opening subscription settings...");
      } else {
        _showManualInstructions(context);
      }
    } catch (e) {
      debugPrint("❌ Error: $e");
      _showManualInstructions(context);
    }
  }

  /// Show manual instructions
  void _showManualInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Manage Subscription"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("To manage your subscription:"),
                const SizedBox(height: 16),
                if (Platform.isAndroid) ...[
                  const Text("1. Open Google Play Store"),
                  const Text("2. Tap profile icon → Subscriptions"),
                ] else ...[
                  const Text("1. Open Settings app"),
                  const Text("2. Tap your name → Subscriptions"),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Got it"),
              ),
            ],
          ),
    );
  }

  /// Get remaining days
  String getDaysRemaining() {
    final entitlement = activeEntitlement;
    if (entitlement?.expirationDate == null) return "Unknown";

    try {
      final expirationDate = DateTime.parse(entitlement!.expirationDate!);
      final now = DateTime.now();
      final difference = expirationDate.difference(now).inDays;

      if (difference < 0) return "Expired";
      if (difference == 0) return "Expires today";
      if (difference == 1) return "1 day remaining";
      return "$difference days remaining";
    } catch (e) {
      return "Unknown";
    }
  }

  /// Format date
  String getFormattedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "Unknown";

    try {
      final date = DateTime.parse(dateString);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }

  /// Main method: Check if user can add service
  Future<bool> checkBeforeAddService(
    String serviceType,
    BuildContext context,
  ) async {
    // If "Friendly Place", allow directly
    if (isFriendlyPlace(serviceType)) {
      debugPrint("✅ Friendly Place - FREE service, no subscription needed");
      return true;
    }

    // Check existing subscription
    await fetchCustomerInfo();

    if (hasActiveSubscription) {
      debugPrint("✅ Active subscription found - Service allowed");
      return true;
    }

    // No subscription - show dialog and wait for result
    // If dialog returns true, it means user wants to subscribe
    final bool shouldSubscribe =
        await _showSubscriptionDialog(context, serviceType) ?? false;

    if (shouldSubscribe) {
      // Navigate to subscription screen and wait for result
      // Ensure SubscriptionScreen returns true on success
      final result = await AppRouter.route.pushNamed(
        RoutePath.subscriptionScreen,
      );

      if (result == true) {
        // Double check to be sure
        await fetchCustomerInfo();
        return hasActiveSubscription;
      }
    }

    return false;
  }

  /// Show subscription required dialog and return true if user wants to subscribe
  Future<bool?> _showSubscriptionDialog(
    BuildContext context,
    String serviceType,
  ) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: Colors.orange[700],
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "Premium Subscription Required",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This service requires an active premium subscription.",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue[700],
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Service: $serviceType",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[700],
                      size: 18,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "💡 'Friendly Place' is always FREE!",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.star, size: 18.sp),
              label: const Text("Subscribe Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchCustomerInfo();
    fetchSubscription();
  }
}
