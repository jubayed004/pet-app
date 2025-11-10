import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/completed_tab.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/ongoing_tab.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/pending_tab.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/rejected_tab.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/widgets/top_tabs.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class BusinessBookingScreen extends StatelessWidget {
  BusinessBookingScreen({super.key});
  final controller = GetControllers.instance.getBusinessBookingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: CustomText(
          text: "Booking",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TopTabs(controller: controller),
          Expanded(
            child: Obx(() {
              final tab = controller.selectedTabIndex.value;
              switch (tab) {
                case 0:
                  return PendingTab(controller: controller);
                case 1:
                  return OngoingTab(controller: controller);
                case 2:
                  return CompletedTab(controller: controller);
                case 3:
                  return RejectedTab(controller: controller);
                default:
                  return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}








