import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/presentation/widget/card/dashboard_store_card.dart';

class PendingTab extends StatefulWidget {
  const PendingTab({super.key, required this.controller});
  final dynamic controller;

  @override
  State<PendingTab> createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  void initState() {
    super.initState();
    widget.controller.pendingController.refresh();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.controller.pendingController.refresh(),
      child: PagedListView<int, BookingItem>(
        pagingController: widget.controller.pendingController,
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
            final bookingTime  = item.bookingTime ?? "";
            final checkInDate = DateFormat("dd MMMM yyyy").format((item.checkInDate ?? DateTime.now()).toLocal(),);
            final checkInTime = item.checkInTime ?? "";
            final checkOutDate = DateFormat("dd MMMM yyyy").format((item.checkOutDate ?? DateTime.now()).toLocal(),);
            final checkOutTime = item.checkOutTime ?? "";
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
              bookingTime: bookingTime,
              checkInDate:checkInDate ,
              checkInTime: checkInTime,
              checkOutDate: checkOutDate,
              checkOutTime: checkOutTime,
              mainTitle: selectedService,

              phoneNumber: phone,
              address: addr,
              onApprove: () => widget.controller.updateItemStatus(
                id: item.id ?? '',
                status: 'APPROVED',
                originTab: 0,
              ),
              onReject: () => widget.controller.updateItemStatus(
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