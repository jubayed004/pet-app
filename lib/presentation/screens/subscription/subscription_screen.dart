import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late final controller;
  int selectedPlanIndex = 1;

  @override
  void initState() {
    super.initState();
    controller = GetControllers.instance.getSubscriptionController();
    _initializeSubscription();
  }

  Future<void> _initializeSubscription() async {
    await controller.fetchCustomerInfo();
    await controller.fetchSubscription();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        // Show loading state
        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading subscription plans...'),
              ],
            ),
          );
        }

        // Check if user already has active subscription
        if (controller.hasActiveSubscription) {
          return _buildActiveSubscriptionView(context, theme);
        }

        // Get the default offering
        final offering = controller.allOfferings.value['default'];

        if (offering == null || offering.availablePackages.isEmpty) {
          return _buildErrorView(context);
        }

        // Filter packages for monthly and yearly
        final packages = offering.availablePackages;
        Package? monthlyPackage;
        Package? yearlyPackage;

        for (var pkg in packages) {
          if (pkg.packageType == PackageType.monthly) {
            monthlyPackage = pkg;
          } else if (pkg.packageType == PackageType.annual) {
            yearlyPackage = pkg;
          }
        }

        return _buildSubscriptionView(
          context,
          size,
          theme,
          monthlyPackage,
          yearlyPackage,
        );
      }),
    );
  }

  Widget _buildSubscriptionView(
      BuildContext context,
      Size size,
      ThemeData theme,
      Package? monthlyPackage,
      Package? yearlyPackage,
      ) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          _buildHeader(context),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Hero Image/Icon
                  _buildHeroSection(),

                  const SizedBox(height: 24),

                  // Title and Description
                  Text(
                    'Unlock Premium Features',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Get unlimited access to all premium features',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Features List
                  _buildFeaturesList(),

                  const SizedBox(height: 32),

                  // Subscription Plans
                  if (yearlyPackage != null)
                    _buildSubscriptionCard(
                      index: 1,
                      title: 'Yearly',
                      price: yearlyPackage.storeProduct.priceString,
                      period: 'per year',
                      savings: _calculateSavings(monthlyPackage, yearlyPackage),
                      package: yearlyPackage,
                      isPopular: true,
                    ),

                  if (yearlyPackage != null && monthlyPackage != null)
                    const SizedBox(height: 16),

                  if (monthlyPackage != null)
                    _buildSubscriptionCard(
                      index: 0,
                      title: 'Monthly',
                      price: monthlyPackage.storeProduct.priceString,
                      period: 'per month',
                      package: monthlyPackage,
                    ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom CTA Section
          _buildBottomSection(context, monthlyPackage, yearlyPackage),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Obx(() {
            if (controller.isRestoring.value) {
              return const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            }
            return TextButton(
              onPressed: () => controller.restorePurchases(),
              child: const Text('Restore'),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.workspace_premium,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.check_circle, 'text': 'Unlimited access to all features'},
      {'icon': Icons.check_circle, 'text': 'Ad-free experience'},
      {'icon': Icons.check_circle, 'text': 'Priority customer support'},
      {'icon': Icons.check_circle, 'text': 'Regular updates and new features'},
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Icon(
                feature['icon'] as IconData,
                color: Colors.green.shade600,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  feature['text'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubscriptionCard({
    required int index,
    required String title,
    required String price,
    required String period,
    required Package package,
    String? savings,
    bool isPopular = false,
  }) {
    final isSelected = selectedPlanIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlanIndex = index;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Radio button
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade400,
                      width: 2,
                    ),
                    color: isSelected ? Colors.blue : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                      : null,
                ),
                const SizedBox(width: 16),

                // Plan details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (savings != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            savings,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style:  TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Popular badge
          if (isPopular)
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.deepOrange.shade400],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Text(
                    'BEST VALUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
      BuildContext context,
      Package? monthlyPackage,
      Package? yearlyPackage,
      ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: controller.isPurchasing.value
                    ? null
                    : () => _handlePurchase(monthlyPackage, yearlyPackage),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: controller.isPurchasing.value
                    ?  SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    :  Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: ()=>AppRouter.route.pushNamed(RoutePath.privacyPolicy),
            child: Text(
              'Cancel anytime. Terms and privacy policy apply.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubscriptionView(BuildContext context, ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  'Subscription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),

            const SizedBox(height: 40),

            // Success Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 60,
                color: Colors.green.shade600,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Premium Active',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Obx(() {
              return Text(
                controller.getDaysRemaining(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
              );
            }),

            const SizedBox(height: 32),

            // Subscription Details Card
            Obx(() {
              final entitlement = controller.activeEntitlement;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      'Product',
                      entitlement?.productIdentifier ?? 'Unknown',
                    ),
                    const Divider(height: 24),
                    _buildDetailRow(
                      'Started',
                      controller.getFormattedDate(
                        entitlement?.originalPurchaseDate,
                      ),
                    ),
                    const Divider(height: 24),
                    _buildDetailRow(
                      'Renews',
                      controller.getFormattedDate(
                        entitlement?.expirationDate,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Spacer(),

            // Manage Subscription Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  // Open subscription management (App Store/Play Store)
                  // This typically opens the system subscription settings
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Manage Subscription',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Manage your subscription in App Store or Play Store settings',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            const Text(
              'Unable to Load Subscriptions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Please check your connection and try again',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _initializeSubscription(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  String? _calculateSavings(Package? monthlyPackage, Package? yearlyPackage) {
    if (monthlyPackage == null || yearlyPackage == null) return null;

    try {
      final monthlyPrice = monthlyPackage.storeProduct.price;
      final yearlyPrice = yearlyPackage.storeProduct.price;

      final yearlyEquivalent = monthlyPrice * 12;
      final savings = ((yearlyEquivalent - yearlyPrice) / yearlyEquivalent * 100).round();

      if (savings > 0) {
        return 'Save $savings%';
      }
    } catch (e) {
      // If calculation fails, don't show savings
    }

    return null;
  }

  void _handlePurchase(Package? monthlyPackage, Package? yearlyPackage) {
    final selectedPackage = selectedPlanIndex == 1 ? yearlyPackage : monthlyPackage;

    if (selectedPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected plan is not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    controller.purchasePackage(selectedPackage);
  }
}