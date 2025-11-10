import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/helper/date_converter/date_converter.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';

import '../model/business_booking_model.dart';

class RejectedTab extends StatelessWidget {
  const RejectedTab({super.key, required this.controller});
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
            final img = firstImage(servicesImages);
            final date = DateConverter.formatDate(item.bookingDate);
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

              phoneNumber: phone,
              address: addr,
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