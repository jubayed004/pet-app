import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';

class CompletedTab extends StatelessWidget {
  const CompletedTab({super.key, required this.controller});
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
            final logoKeyOrUrl = (shopLogo != null && shopLogo.toString().isNotEmpty) ? shopLogo.toString() : service;
            // ✅ Convert all server dates to local timezone before formatting
            final bookingDate = DateFormat("dd MMMM yyyy").format(
              (item.bookingDate ?? DateTime.now()).toLocal(),
            );
            final bookingTime = item.bookingTime ?? "";

            final checkInDate = DateFormat("dd MMMM yyyy").format(
              (item.checkInDate ?? DateTime.now()).toLocal(),
            );
            final checkInTime = item.checkInTime ?? "";

            final checkOutDate = DateFormat("dd MMMM yyyy").format(
              (item.checkOutDate ?? DateTime.now()).toLocal(),
            );
            final checkOutTime = item.checkOutTime ?? "";
            return CustomBookingCard(
              index: 2,
              showApproveButton: false,
              showRejectButton: false,
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: bookingDate,
              mainTitle: selectedService,
              phoneNumber: phone,
              address: addr,
              bookingTime: bookingTime,
              checkInTime: checkInTime,
              checkInDate: checkInDate,
              checkOutDate: checkOutDate,
              checkOutTime: checkOutTime,


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