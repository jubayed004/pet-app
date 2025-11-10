
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';

class OngoingTab extends StatelessWidget {
  const OngoingTab({super.key, required this.controller});
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