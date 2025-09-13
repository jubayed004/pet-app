import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class BusinessBookingController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  final PagingController<int, BookingItem> pendingController = PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> ongoingController = PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> approvedController = PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> rejectedController = PagingController(firstPageKey: 1);

  final ApiClient apiClient = serviceLocator();

  RxBool isLoadingPending = false.obs;
  RxBool isLoadingOngoing = false.obs;
  RxBool isLoadingApproved = false.obs;
  RxBool isLoadingRejected = false.obs;

  Future<void> getPending(int pageKey) async {
    if (isLoadingPending.value) return;
    isLoadingPending.value = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getAllBooking(status: "PENDING", page: pageKey));

      if (response.statusCode == 200) {
        final data = BusinessBookingModel.fromJson(response.body);
        final newItems = data.bookings ?? [];
        if (newItems.isEmpty) {
          pendingController.appendLastPage(newItems);
        } else {
          pendingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pendingController.error = 'Error fetching data';
      }
    } catch (e) {
      pendingController.error = e.toString();
    } finally {
      isLoadingPending.value = false;
    }
  }

  Future<void> getOngoing(int pageKey) async {
    if (isLoadingOngoing.value) return;
    isLoadingOngoing.value = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getAllBooking(status: "ONGOING", page: pageKey));

      if (response.statusCode == 200) {
        final data = BusinessBookingModel.fromJson(response.body);
        final newItems = data.bookings ?? [];
        if (newItems.isEmpty) {
          ongoingController.appendLastPage(newItems);
        } else {
          ongoingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        ongoingController.error = 'Error fetching data';
      }
    } catch (e) {
      ongoingController.error = e.toString();
    } finally {
      isLoadingOngoing.value = false;
    }
  }

  Future<void> getApproved(int pageKey) async {
    if (isLoadingApproved.value) return;
    isLoadingApproved.value = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getAllBooking(status: "COMPLETED", page: pageKey));
      if (response.statusCode == 200) {
        final data = BusinessBookingModel.fromJson(response.body);
        final newItems = data.bookings ?? [];
        if (newItems.isEmpty) {
          approvedController.appendLastPage(newItems);
        } else {
          approvedController.appendPage(newItems, pageKey + 1);
        }
      } else {
        approvedController.error = 'Error fetching data';
      }
    } catch (e) {
      approvedController.error = e.toString();
    } finally {
      isLoadingApproved.value = false;
    }
  }

  Future<void> getRejected(int pageKey) async {
    if (isLoadingRejected.value) return;
    isLoadingRejected.value = true;
    try {
      final response = await apiClient.get(url: ApiUrl.getAllBooking(status: "REJECTED", page: pageKey));
      if (response.statusCode == 200) {
        final data = BusinessBookingModel.fromJson(response.body);
        final newItems = data.bookings ?? [];
        if (newItems.isEmpty) {
          rejectedController.appendLastPage(newItems);
        } else {
          rejectedController.appendPage(newItems, pageKey + 1);
        }
      } else {
        rejectedController.error = 'Error fetching data';
      }
    } catch (e) {
      rejectedController.error = e.toString();
    } finally {
      isLoadingRejected.value = false;
    }
  }

  Future<void> updateItemStatus({required String id, required String status}) async {
    final response = await apiClient.put(url: ApiUrl.updateStatus(id: id), body: {'status': status});

    if (response.statusCode == 200) {
      if (status == "Approved") {
        pendingController.refresh();
        ongoingController.refresh();
        approvedController.refresh();
        rejectedController.refresh();
      } else if (status == "Rejected") {
        pendingController.refresh();
        ongoingController.refresh();
        rejectedController.refresh();
        approvedController.refresh();
      }
      toastMessage(message: response.body?["message"]);
    } else {
      toastMessage(message: response.body?["message"]);
    }
  }

  @override
  void onInit() {
    pendingController.addPageRequestListener(getPending);
    ongoingController.addPageRequestListener(getOngoing);
    approvedController.addPageRequestListener(getApproved);
    rejectedController.addPageRequestListener(getRejected);
    super.onInit();
  }
}
