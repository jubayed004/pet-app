import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
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
                        child: CustomText(text: "PENDING", color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
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
                        child: CustomText(text: "Ongoing ", color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.w800,),
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

                  RefreshIndicator(
                    onRefresh: () async {
                      controller.pendingController.refresh();
                    },
                    child: PagedListView<int, BookingItem>(
                      pagingController: controller.pendingController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<BookingItem>(
                        itemBuilder: (context, item, index) {
                          final address = item.serviceId?.location ?? "";
                          final service = item.serviceType;
                          final selectedService = item.selectedService;
                          final phoneNumber = item.serviceId?.phone ?? "";
                          final bookingTime = item.bookingTime;
                          final serviceType = item.serviceId;
                          final shopLogo = serviceType?.shopLogo;
                          final serviceImage = serviceType?.servicesImages;
                          final bookingDate = DateFormat("dd mm yyyy").format(item.bookingDate ?? DateTime.now());
                          return CustomBookingCard(
                            index: 0,
                            showApproveButton: true,
                            showRejectButton: true, // ✅ Only reject
                            logoPath: shopLogo?? "",
                            topTitle: service?? "",
                            imagePath: (serviceImage != null && serviceImage.isNotEmpty) ?serviceImage : "",
                            visitingDate: bookingDate,
                            mainTitle: selectedService?? "",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: phoneNumber,
                            address: address,
                            onApprove: () {
                              controller.updateItemStatus(
                                id: item.id ?? '',
                                status: 'APPROVED',
                              );
                            },
                            onReject: () {
                              controller.updateItemStatus(
                                id: item.id ?? '',
                                status: 'REJECTED',
                              );
                            },
                          )
                          ;
                        },

                      ),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.ongoingController.refresh();
                    },
                    child: PagedListView<int, BookingItem>(
                      pagingController: controller.ongoingController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<BookingItem>(
                        itemBuilder: (context, item, index) {
                          final address = item.serviceId?.location ?? "";
                          final service = item.serviceType;
                          final phoneNumber = item.serviceId?.phone ?? "";
                          final bookingTime = item.bookingTime;
                          final serviceType = item.serviceId;
                          final shopLogo = serviceType?.shopLogo;
                          final serviceImage = serviceType?.servicesImages;
                          final bookingDate = DateFormat("dd mm yyyy").format(item.bookingDate ?? DateTime.now());
                          return CustomBookingCard(
                            index: 1,
                            showApproveButton: true,
                            showRejectButton: false, // ✅ Only reject
                            logoPath: shopLogo?? "",
                            topTitle: service?? "",
                            imagePath: (serviceImage != null && serviceImage.isNotEmpty) ?serviceImage : "",
                            visitingDate: bookingDate,
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: phoneNumber,
                            address: address,
                            onApprove: () {
                              controller.updateItemStatus(
                                id: item.id ?? '',
                                status: 'COMPLETED',
                              );
                            },
                            onReject: () {
                              controller.updateItemStatus(
                                id: item.id ?? '',
                                status: 'REJECTED',
                              );
                            },
                          )
                          ;

                        },
                      ),
                    ),
                  ),

                  // ✅ completed Tab
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.approvedController.refresh();
                    },
                    child: PagedListView<int, BookingItem>(
                      pagingController: controller.approvedController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<BookingItem>(
                        itemBuilder: (context, item, index) {
                          final address = item.serviceId?.location ?? "";
                          final service = item.serviceType;
                          final selectedService = item.selectedService;
                          final phoneNumber = item.serviceId?.phone ?? "";
                          final bookingTime = item.bookingTime;
                          final serviceType = item.serviceId;
                          final shopLogo = serviceType?.shopLogo;
                          final serviceImage = serviceType?.servicesImages;
                          final bookingDate = DateFormat("dd mm yyyy").format(item.bookingDate ?? DateTime.now());

                          return CustomBookingCard(
                            index: 2,
                            showApproveButton: false,
                            showRejectButton: false, // ✅ Only reject
                            logoPath: shopLogo?? "",
                            topTitle: service?? "",
                            imagePath: (serviceImage != null && serviceImage.isNotEmpty) ?serviceImage : "",
                            visitingDate: bookingDate,
                            mainTitle: selectedService?? "",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: phoneNumber,
                            address: address,
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
                    child: PagedListView<int, BookingItem>(
                      pagingController: controller.rejectedController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      builderDelegate: PagedChildBuilderDelegate<BookingItem>(
                        itemBuilder: (context, item, index) {
                           final address = item.serviceId?.location?? "address";
                           final phoneNumber = item.serviceId?.phone ?? "phone";
                           final bookingTime = item.bookingTime;
                           final serviceType = item.serviceId;
                           final shopLogo = serviceType?.shopLogo;
                           final serviceImage = serviceType?.servicesImages;
                           final bookingDate = DateFormat("dd mm yyyy").format(item.bookingDate ?? DateTime.now());
                           print(phoneNumber);
                           print(address);
                          return CustomBookingCard(
                            index: 3,
                            showApproveButton: false, // ✅ Only approve
                            showRejectButton: false,
                            logoPath: shopLogo ?? "",
                            topTitle: "Vets",
                            imagePath: serviceImage ?? "",
                            visitingDate: bookingDate,
                            mainTitle: "Pet Food & Supplies Sales",
                            subTitle: "Pet Grooming",
                            rating: 5.0,
                            phoneNumber: phoneNumber,
                            address: address,

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
