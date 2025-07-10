import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class BusinessBookingScreen extends StatelessWidget {
   BusinessBookingScreen({super.key});
  final controller = GetControllers.instance.getBusinessBookingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text:"Booking",fontSize: 16,fontWeight: FontWeight.w600,),centerTitle: true,),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Color(0xFFecfaf3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedTabIndex.value = 0;
                    },
                    child: Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedTabIndex.value == 0 ? AppColors.purple500 : null,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: CustomText(text: "Upcoming".tr, color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedTabIndex.value = 1;
                    },
                    child: Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedTabIndex.value == 1 ?AppColors.purple500 : null,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: CustomText(text: "Ongoing ".tr, color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedTabIndex.value = 2;

                    },
                    child: Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedTabIndex.value == 2 ? AppColors.purple500: null,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: CustomText(text: "Completed", color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedTabIndex.value = 3;
                    },
                    child: Obx(() {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedTabIndex.value == 3 ? AppColors.purple500 : null,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: CustomText(text: "Rejected", color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return IndexedStack(
                index: controller.selectedTabIndex.value,
                children: [
                  // ✅ Pending Tab
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.upcomingController.refresh();
                    },
                    child: PagedListView<int, Widget>(
                      pagingController: controller.upcomingController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<Widget>(
                        itemBuilder: (context, item, index) {
                          return CustomBookingCard(
                            index: 0,
                            showApproveButton: true,
                            showRejectButton: true, // ✅ Show both
                            logoPath: "assets/images/vet.png",
                            topTitle: "Vets",
                            imagePath: "assets/images/womandogimage.png",
                            visitingDate: "25/11/2022",
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: "(406) 555-0120",
                            address: "4517 Washington Ave.",
                            onChat: () => print("Chat tapped"),
                            onWebsite: () => print("Website tapped"),
                            onAddReview: () => print("Review tapped"),
                            onApprove: () => print("Approved"),
                            onReject: () => print("Rejected"),
                          )
                          ;
                        },
                      ),
                    ),
                  ),

                  // ✅ Approved Tab
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.ongoingController.refresh();
                    },
                    child: PagedListView<int, Widget>(
                      pagingController: controller.ongoingController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<Widget>(
                        itemBuilder: (context, item, index) {
                          return CustomBookingCard(
                            index: 1,
                            showApproveButton: true,
                            showRejectButton: true, // ✅ Show both
                            logoPath: "assets/images/vet.png",
                            topTitle: "Vets",
                            imagePath: "assets/images/womandogimage.png",
                            visitingDate: "25/11/2022",
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 4.5,
                            phoneNumber: "(406) 555-0120",
                            address: "4517 Washington Ave.",
                            onChat: () => print("Chat tapped"),
                            onWebsite: () => print("Website tapped"),
                            onAddReview: () => print("Review tapped"),
                            onApprove: () => print("Approved"),
                            onReject: () => print("Rejected"),
                          )
                          ;

                        },
                      ),
                    ),
                  ),

                  // ✅ completed Tab
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.completedController.refresh();
                    },
                    child: PagedListView<int, Widget>(
                      pagingController: controller.completedController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<Widget>(
                        itemBuilder: (context, item, index) {
                          return CustomBookingCard(
                            index: 0,
                            showApproveButton: false,
                            showRejectButton: true, // ✅ Only reject
                            logoPath: "assets/images/vet.png",
                            topTitle: "Vets",
                            imagePath: "assets/images/womandogimage.png",
                            visitingDate: "25/11/2022",
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: "(406) 555-0120",
                            address: "4517 Washington Ave.",
                            onChat: () => print("Chat tapped"),
                            onWebsite: () => print("Website tapped"),
                            onAddReview: () => print("Review tapped"),
                            onApprove: () => print("Approved"),
                            onReject: () => print("Rejected"),
                          )

                          ;
                        },
                      ),
                    ),
                  ),

                  // ✅ Rejected Tab
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.rejectedController.refresh();
                    },
                    child: PagedListView<int, Widget>(
                      pagingController: controller.rejectedController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<Widget>(
                        itemBuilder: (context, item, index) {
                          return CustomBookingCard(
                            index: 0,
                            showApproveButton: true, // ✅ Only approve
                            showRejectButton: false,
                            logoPath: "assets/images/vet.png",
                            topTitle: "Vets",
                            imagePath: "assets/images/womandogimage.png",
                            visitingDate: "25/11/2022",
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: "(406) 555-0120",
                            address: "4517 Washington Ave.",
                            onChat: () => print("Chat tapped"),
                            onWebsite: () => print("Website tapped"),
                            onAddReview: () => print("Review tapped"),
                            onApprove: () => print("Approved"),
                            onReject: () => print("Rejected"),
                          )
                          ;
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

        ],
      ),
    );
  }
}
