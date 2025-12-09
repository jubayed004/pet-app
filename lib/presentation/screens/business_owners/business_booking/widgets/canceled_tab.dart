import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/helper/date_converter/date_converter.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';

import '../model/business_booking_model.dart';

class CanceledTab extends StatelessWidget {
  const CanceledTab({super.key, required this.controller});
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.canceledController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: controller.canceledController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        builderDelegate: PagedChildBuilderDelegate<BookingItem>(
          itemBuilder: (context, item, index) {
            final addr = item.serviceId?.location ?? 'address';
            final phone = item.serviceId?.phone ?? 'phone';
            final service = item.serviceType ?? 'Vets';
            final shopLogo = item.serviceId?.shopLogo;
            final bookingTime = item.bookingTime ?? "";
            final servicesImages = item.serviceId?.servicesImages;
            final img = firstImage(servicesImages);
            final date = DateConverter.formatDate(item.bookingDate);
            final logoKeyOrUrl =
                (shopLogo != null && shopLogo.toString().isNotEmpty)
                    ? shopLogo.toString()
                    : service;

            return CustomBookingCard(
              index: 4, // Index for Canceled
              showApproveButton: false,
              showRejectButton: false,
              logoPath: logoKeyOrUrl,
              topTitle: service,
              imagePath: img,
              visitingDate: date,
              mainTitle: "Pet Food & Supplies Sales",
              bookingTime: bookingTime,
              phoneNumber: phone,
              address: addr,
              cancellationReason: item.cancellationReason,
            );
          },
        ),
      ),
    );
  }
}

String firstImage(dynamic servicesImages) {
  if (servicesImages == null) return '';
  if (servicesImages is String) return servicesImages;
  if (servicesImages is List && servicesImages.isNotEmpty) {
    final first = servicesImages.first;
    if (first is String) return first;
  }
  return '';
}
