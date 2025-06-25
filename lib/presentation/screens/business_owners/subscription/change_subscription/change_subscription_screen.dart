/*

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/change_subscription/widgets/custom_tabbar.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/change_subscription/widgets/subscription_plan_view.dart';
import 'package:pet_app/presentation/widget/back_button/back_button.dart';

import '../../../../../core/route/routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ChangeSubscriptionScreen extends StatefulWidget {
  const ChangeSubscriptionScreen({super.key});

  @override
  _ChangeSubscriptionScreenState createState() =>
      _ChangeSubscriptionScreenState();
}

class _ChangeSubscriptionScreenState extends State<ChangeSubscriptionScreen> with TickerProviderStateMixin {
  final controller = GetControllers.instance.getSubscriptionController();
  late TabController _tabController;
  late TabController _tabController1;
  late TabController _tabController2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController1 = TabController(length: 2, vsync: this);
    _tabController2 = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: CustomText(
            text: "Change Subscription Status ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          leading: CustomBackButton(
            onTap: () {
              AppRouter.route.pop();
            },
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Making the entire body scrollable
        child: Padding(
          padding:
          const EdgeInsets.only(top: 24.0, left: 14, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading and description at the top
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabbar(
                    tabController: _tabController1,
                    tabLabels: [
                      "Daily",
                      "Monthly"
                      */
/*    (controller.typeModel.value.data?.subscriptionPlans?[0].subscriptionType ?? ""),
                              (controller.typeModel.value.data?.subscriptionPlans?[1].subscriptionType ?? ""),*//*

                    ],
                  ),
                  Gap(40),
                  Text(
                    "Choose Your Plan",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Gap(10),
                  Text(
                    "Smart Picks. Smarter Bets.",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.secondTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height /
                    2)+100,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController1,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height /
                          2)+100,
                      child: Column(
                        children: [
                          Gap(24),
                          CustomTabbar(
                            tabController: _tabController2,
                            tabLabels: [
                              (controller.typeModel.value.data?.subscriptionPlans?[0].subscriptionType ?? ""),
                              (controller.typeModel.value.data?.subscriptionPlans?[1].subscriptionType ?? ""),
                              (controller.typeModel.value.data?.subscriptionPlans?[2].subscriptionType ?? ""),
                            ],
                          ),
                          Gap(24),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController2,
                              children: [
                                SubscriptionPlanViewTwo(
                                  id: data?[0].id ?? "",
                                  planName: data?[0].duration ?? "",
                                  price: data?[0].price ?? 0,
                                  color: Colors.black,
                                  containerColor: const Color(0xFFAFF9BA),
                                  features: data?[0].features ?? [],
                                ),
                                SubscriptionPlanViewTwo(
                                  id: data?[1].id ?? "",
                                  planName: data?[1].duration ?? "",
                                  price: data?[1].price ?? 0,
                                  color: Colors.black,
                                  containerColor: Color(0xFFAFF9BA),
                                  features: data?[1].features ?? [],
                                ),
                                SubscriptionPlanViewTwo(
                                  planName: data?[2].duration ?? "",
                                  price: data?[2].price ?? 0,
                                  color: Colors.black,
                                  containerColor: Color(0xFFAFF9BA),
                                  id: data?[2].id ?? "",
                                  features: data?[2].features ?? [],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height /
                          2)+100,
                      child: Column(
                        children: [
                          Gap(24),
                          CustomTabbar(
                            tabController: _tabController,
                            tabLabels: [
                              (controller.typeModel.value.data?.subscriptionPlans?[3].subscriptionType ?? ""),
                              (controller.typeModel.value.data?.subscriptionPlans?[4].subscriptionType ?? ""),
                              (controller.typeModel.value.data?.subscriptionPlans?[5].subscriptionType ?? ""),
                            ],
                          ),
                          Gap(24),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                SubscriptionPlanViewTwo(
                                  id: data?[3].id ?? "",
                                  planName: data?[3].duration ?? "",
                                  price: data?[3].price ?? 0,
                                  color: Colors.black,
                                  containerColor: const Color(0xFFAFF9BA),
                                  features: data?[3].features ?? [],
                                ),
                                SubscriptionPlanViewTwo(
                                  id: data?[4].id ?? "",
                                  planName: data?[4].duration ?? "",
                                  price: data?[4].price ?? 0,
                                  color: Colors.black,
                                  containerColor: Color(0xFFAFF9BA),
                                  features: data?[4].features ?? [],
                                ),
                                SubscriptionPlanViewTwo(
                                  planName: data?[5].duration ?? "",
                                  price: data?[5].price ?? 0,
                                  color: Colors.black,
                                  containerColor: Color(0xFFAFF9BA),
                                  id: data?[5].id ?? "",
                                  features: data?[5].features ?? [],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      */
/*Obx(
        () {
          switch (controller.subscription.value) {
            case Status.loading:
              return Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 40.0,
                ),
              );
            case Status.internetError:
              return NoInternetCard(onTap: () => controller.getSubscription());
            case Status.noDataFound:
              return Center(
                  child: NoDataCard(onTap: () => controller.getSubscription()));
            case Status.error:
              return ErrorCard(onTap: () => controller.getSubscription());

            case Status.completed:
              final data = controller.typeModel.value.data?.subscriptionPlans;
              return
          }
        },
      ),*//*

    );
  }
}
*/
