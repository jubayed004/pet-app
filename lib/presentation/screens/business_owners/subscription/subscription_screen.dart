import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/change_subscription/widgets/custom_tabbar.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/widgets/subscription_plan_view.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
  late TabController _tabControllerMain; // This is for main TabBarView (only 1 child now)
  late TabController _tabControllerPlans; // This is for Gold, Silver, Diamond tabs

  @override
  void initState() {
    super.initState();

    _tabControllerMain = TabController(length: 1, vsync: this);
    _tabControllerPlans = TabController(length: 3, vsync: this); // 3 plans
  }

  @override
  void dispose() {
    _tabControllerMain.dispose();
    _tabControllerPlans.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24, left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(40),
            const Text(
              "Choose Your Subscription Plan",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Text(
              "Get the best features to grow your business!",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.secondTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) + 100,
              child: TabBarView(
                controller: _tabControllerMain,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMonthlyPlans(), // Only one child here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyPlans() {
    return Column(
      children: [
        const Gap(24),
        CustomTabbar(
          tabController: _tabControllerPlans,
          tabLabels: ["Gold", "Silver", "Diamond"],
        ),
        const Gap(24),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: TabBarView(
            controller: _tabControllerPlans,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SubscriptionPlanView(
                id: "monthly_gold",
                planName: "Gold",
                price: 50,
                color: Colors.black,
                containerColor: const Color(0xFFAFF9BA),
                features: [
                  "Priority listing",
                  "Customer messaging",
                  "Advanced analytics",
                  "Premium support"
                ],
              ),
              SubscriptionPlanView(
                id: "monthly_silver",
                planName: "Silver",
                price: 100,
                color: Colors.black,
                containerColor: const Color(0xFFAFF9BA),
                features: [
                  "Priority listing",
                  "Customer messaging",
                  "Advanced analytics",
                  "Premium support"
                ],
              ),
              SubscriptionPlanView(
                id: "monthly_diamond",
                planName: "Diamond",
                price: 500,
                color: Colors.black,
                containerColor: const Color(0xFFAFF9BA),
                features: [
                  "Priority listing",
                  "Customer messaging",
                  "Advanced analytics",
                  "Premium support"
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
