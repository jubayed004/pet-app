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
      appBar: AppBar(
        title: CustomText(
          text: "Booking",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _TopTabs(controller: controller),
          Expanded(
            child: Obx(() {
              final tab = controller.selectedTabIndex.value;
              // Build only the current tab => true lazy load
              switch (tab) {
                case 0:
                  return _PendingTab(controller: controller);
                case 1:
                  return _OngoingTab(controller: controller);
                case 2:
                  return _CompletedTab(controller: controller);
                case 3:
                  return _RejectedTab(controller: controller);
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

class _TopTabs extends StatelessWidget {
  const _TopTabs({required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: const Color(0xFFecfaf3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Obx(() {
        final sel = controller.selectedTabIndex.value;
        return Row(
          children: [
            _TabButton(
              label: 'PENDING',
              isActive: sel == 0,
              onTap: () => controller.selectTab(0),
            ),
            _TabButton(
              label: 'Ongoing',
              isActive: sel == 1,
              onTap: () => controller.selectTab(1),
            ),
            _TabButton(
              label: 'Completed',
              isActive: sel == 2,
              onTap: () => controller.selectTab(2),
            ),
            _TabButton(
              label: 'Rejected',
              isActive: sel == 3,
              onTap: () => controller.selectTab(3),
            ),
          ],
        );
      }),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.purple500 : null,
            borderRadius: BorderRadius.circular(25),
          ),
          child: CustomText(
            text: label,
            color: AppColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

/// ---------- Helpers ----------
String _formatDate(DateTime? dt) =>
    DateFormat('dd MMM yyyy').format(dt ?? DateTime.now());

String _firstImage(dynamic servicesImages) {
  if (servicesImages == null) return '';
  if (servicesImages is String) return servicesImages;
  if (servicesImages is List && servicesImages.isNotEmpty) {
    final first = servicesImages.first;
    if (first is String) return first;
  }
  return '';
}

/// ---------- Tabs ----------
class _PendingTab extends StatelessWidget {
  const _PendingTab({required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.pendingController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: controller.pendingController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        builderDelegate: PagedChildBuilderDelegate<BookingItem>(
          itemBuilder: (context, item, index) {
            final addr = item.serviceId?.location ?? '';
            final service = item.serviceType ?? '';
            final selectedService = item.selectedService ?? '';
            final phone = item.serviceId?.phone ?? '';
            final shopLogo = item.serviceId?.shopLogo;
            final servicesImages = item.serviceId?.servicesImages;
            final img = _firstImage(servicesImages);
            final date = _formatDate(item.bookingDate);

            // Prefer shopLogo if available, else pass service type to map icon
            final logoKeyOrUrl =
            (shopLogo != null && shopLogo.toString().isNotEmpty)
                ? shopLogo.toString()
                : service;

            return CustomBookingCard(
              index: 0,
              showApproveButton: true,
              showRejectButton: true,
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: date,
              mainTitle: selectedService,
              subTitle: "Pet Grooming",
              rating: 5.0,
              phoneNumber: phone,
              address: addr,
              onApprove: () => controller.updateItemStatus(
                id: item.id ?? '',
                status: 'APPROVED',
                originTab: 0,
              ),
              onReject: () => controller.updateItemStatus(
                id: item.id ?? '',
                status: 'REJECTED',
                originTab: 0,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OngoingTab extends StatelessWidget {
  const _OngoingTab({required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.ongoingController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: controller.ongoingController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        builderDelegate: PagedChildBuilderDelegate<BookingItem>(
          itemBuilder: (context, item, index) {
            final addr = item.serviceId?.location ?? '';
            final service = item.serviceType ?? '';
            final phone = item.serviceId?.phone ?? '';
            final shopLogo = item.serviceId?.shopLogo;
            final servicesImages = item.serviceId?.servicesImages;
            final img = _firstImage(servicesImages);
            final date = _formatDate(item.bookingDate);
            final logoKeyOrUrl =
            (shopLogo != null && shopLogo.toString().isNotEmpty)
                ? shopLogo.toString()
                : service;

            return CustomBookingCard(
              index: 1,
              showApproveButton: true,   // approve acts as "Complete"
              showRejectButton: false,
              approveText: 'Complete',
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: date,
              mainTitle: item.selectedService ?? service,
              subTitle: "Pet Grooming",
              rating: 5.0,
              phoneNumber: phone,
              address: addr,
              onApprove: () => controller.updateItemStatus(
                id: item.id ?? '',
                status: 'COMPLETED',
                originTab: 1,
              ),
              onReject: null,
            );
          },
        ),
      ),
    );
  }
}

class _CompletedTab extends StatelessWidget {
  const _CompletedTab({required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.approvedController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: controller.approvedController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        builderDelegate: PagedChildBuilderDelegate<BookingItem>(
          itemBuilder: (context, item, index) {
            final addr = item.serviceId?.location ?? '';
            final service = item.serviceType ?? '';
            final selectedService = item.selectedService ?? '';
            final phone = item.serviceId?.phone ?? '';
            final shopLogo = item.serviceId?.shopLogo;
            final servicesImages = item.serviceId?.servicesImages;
            final img = _firstImage(servicesImages);
            final date = _formatDate(item.bookingDate);
            final logoKeyOrUrl =
            (shopLogo != null && shopLogo.toString().isNotEmpty)
                ? shopLogo.toString()
                : service;

            return CustomBookingCard(
              index: 2,
              showApproveButton: false,
              showRejectButton: false,
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: date,
              mainTitle: selectedService,
              subTitle: "Pet Grooming",
              rating: 5.0,
              phoneNumber: phone,
              address: addr,
            );
          },
        ),
      ),
    );
  }
}

class _RejectedTab extends StatelessWidget {
  const _RejectedTab({required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.rejectedController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: controller.rejectedController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        builderDelegate: PagedChildBuilderDelegate<BookingItem>(
          itemBuilder: (context, item, index) {
            final addr = item.serviceId?.location ?? 'address';
            final phone = item.serviceId?.phone ?? 'phone';
            final service = item.serviceType ?? 'Vets';
            final shopLogo = item.serviceId?.shopLogo;
            final servicesImages = item.serviceId?.servicesImages;
            final img = _firstImage(servicesImages);
            final date = _formatDate(item.bookingDate);
            final logoKeyOrUrl =
            (shopLogo != null && shopLogo.toString().isNotEmpty)
                ? shopLogo.toString()
                : service;

            return CustomBookingCard(
              index: 3,
              showApproveButton: false,
              showRejectButton: false,
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: date,
              mainTitle: "Pet Food & Supplies Sales",
              subTitle: "Pet Grooming",
              rating: 5.0,
              phoneNumber: phone,
              address: addr,
            );
          },
        ),
      ),
    );
  }
}
