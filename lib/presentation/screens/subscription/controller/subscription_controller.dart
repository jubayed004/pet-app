import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Check if user can create service (has active subscription)
  bool get canCreateService {
    return hasActiveSubscription;
  }

  /// Fetch available subscription offerings from RevenueCat
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

  /// Fetch current customer subscription info
  Future<void> fetchCustomerInfo() async {
    try {
      final info = await Purchases.getCustomerInfo();
      customer.value = info;

      if (kDebugMode) {
        debugPrint("👤 Customer Info Updated");
        debugPrint("Active Subscriptions: ${info.entitlements.active.keys.join(", ")}");
      }
    } catch (e) {
      debugPrint("❌ Error fetching customer info: $e");
    }
  }

  /// Purchase a subscription package
  Future<void> purchasePackage(Package package) async {
    isPurchasing.value = true;

    try {
      final PurchaseResult result = await Purchases.purchasePackage(package);
      customer.value = result.customerInfo;

      if (kDebugMode) {
        debugPrint("✅ Purchase Successful!");
        debugPrint("Active Entitlements: ${result.customerInfo.entitlements.active.keys.join(", ")}");
      }

      toastMessage(message: "Subscription activated successfully!");

      // Navigate back or to home after successful purchase
      if (Get.isOverlaysOpen) {
        Get.back();
      }

    } on PlatformException catch (e) {
      _handlePurchaseError(e);
    } catch (e) {
      debugPrint("❌ Purchase Error: $e");
      toastMessage(message: "Purchase failed. Please try again.");
    } finally {
      isPurchasing.value = false;
    }
  }

  /// Handle purchase errors
  void _handlePurchaseError(PlatformException e) {
    switch (e.code) {
      case '1': // User cancelled
        debugPrint("ℹ️ User cancelled purchase");
        break;
      case '2': // Store problem
        toastMessage(message: "Store unavailable. Try again later.");
        break;
      case '3': // Purchase not allowed
        toastMessage(message: "Purchase not allowed on this device");
        break;
      case '4': // Invalid purchase
        toastMessage(message: "Invalid purchase");
        break;
      case '5': // Product not available
        toastMessage(message: "Product not available");
        break;
      default:
        toastMessage(message: "Purchase failed: ${e.message}");
    }
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    isRestoring.value = true;

    try {
      final CustomerInfo customerInfo = await Purchases.restorePurchases();
      customer.value = customerInfo;

      if (customerInfo.entitlements.active.isNotEmpty) {
        toastMessage(message: "Purchases restored successfully!");
        debugPrint("✅ Restored: ${customerInfo.entitlements.active.keys.join(", ")}");
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

  /// Open store subscription management
  Future<void> launchManageSubscriptions() async {
    final uri = Platform.isAndroid
        ? Uri.parse('https://play.google.com/store/account/subscriptions')
        : Uri.parse('https://apps.apple.com/account/subscriptions');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        toastMessage(message: "Unable to open subscription settings");
      }
    } catch (e) {
      debugPrint("❌ Error launching URL: $e");
      toastMessage(message: "Unable to open subscription settings");
    }
  }

  /// Get remaining days in subscription
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

  /// Format date string
  String getFormattedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "Unknown";

    try {
      final date = DateTime.parse(dateString);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }

  /// Check subscription before allowing service creation
  Future<bool> checkSubscriptionBeforeAction({
    required BuildContext context, // Add context as a parameter
    required String actionName,
  }) async {
    // Refresh customer info to get latest subscription status
    await fetchCustomerInfo();

    if (!hasActiveSubscription) {
      _showSubscriptionRequiredDialog(context, actionName); // Pass the correct context here
      return false;
    }

    return true;
  }



  /// Show dialog when subscription is required
  void _showSubscriptionRequiredDialog(BuildContext context, String actionName) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Subscription Required"),
          content: Text(
            "To $actionName, you need an active subscription. Would you like to subscribe now?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text("Later"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                AppRouter.route.pushNamed(RoutePath.subscriptionScreen); // Navigate to the subscription screen
              },
              child: const Text("Subscribe Now"),
            ),
          ],
        );
      },
    );
  }


  @override
  void onInit() {
    super.onInit();
    // Initialize subscription data
    fetchCustomerInfo();
    fetchSubscription();
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}