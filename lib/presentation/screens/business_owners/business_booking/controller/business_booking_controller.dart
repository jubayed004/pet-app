import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/business_owners/business_booking/model/business_booking_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

import '../../../../../utils/variable/variable.dart';

/// Tab indices
const int kTabPending = 0;   // PENDING
const int kTabOngoing = 1;   // APPROVED
const int kTabCompleted = 2; // COMPLETED
const int kTabRejected = 3;  // REJECTED

class BusinessBookingController extends GetxController {
  final RxInt selectedTabIndex = kTabPending.obs;

  final PagingController<int, BookingItem> pendingController =
  PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> ongoingController =
  PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> approvedController =
  PagingController(firstPageKey: 1);
  final PagingController<int, BookingItem> rejectedController =
  PagingController(firstPageKey: 1);

  final ApiClient apiClient = serviceLocator();

  // Loading guards
  RxBool isLoadingPending = false.obs;
  RxBool isLoadingOngoing = false.obs;
  RxBool isLoadingApproved = false.obs;
  RxBool isLoadingRejected = false.obs;

  // Lazy-load helpers
  final List<bool> _listenerAdded = [false, false, false, false];
  final List<bool> _firstLoadTriggered = [false, false, false, false];

  /// ---------------- API loads per status ----------------
  Future<void> getPending(int pageKey) async {
    if (isLoadingPending.value) return;
    isLoadingPending.value = true;
    try {
      final response = await apiClient.get(
        url: ApiUrl.getAllBooking(
          status: "PENDING",
          page: pageKey,
        ),
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
        final data = BusinessBookingModel.fromJson(response.body);
        final newItems = data.bookings ?? [];
        if (newItems.isEmpty) {
          pendingController.appendLastPage([]);
        } else {
          pendingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pendingController.error = 'Error fetching data (Code: ${response.statusCode})';
      }

    } catch (e, stack) {
      logger.e("PENDING API ERROR", error: e, stackTrace: stack);
      pendingController.error = e.toString();
    } finally {
      isLoadingPending.value = false;
    }
  }


  Future<void> getOngoing(int pageKey) async {
    if (isLoadingOngoing.value) return;
    isLoadingOngoing.value = true;
    try {
      final response = await apiClient.get(
        url: ApiUrl.getAllBooking(status: "APPROVED", page: pageKey),
      );
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
      final response = await apiClient.get(
        url: ApiUrl.getAllBooking(status: "COMPLETED", page: pageKey),
      );
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
      final response = await apiClient.get(url: ApiUrl.getAllBooking(status: "REJECTED", page: pageKey),);
      logger.d(response.body);
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

  Future<void> updateItemStatus({
    required String id,
    required String status,
    required int originTab,
  }) async {
    try {
      final response = await apiClient.put(url: ApiUrl.updateStatus(id: id), body: {'status': status},);
      if (response.statusCode == 200) {
        _refreshForStatusChange(status);
        _refreshTab(originTab);
        toastMessage(message: response.body?["message"]);
      } else {
        toastMessage(message: response.body?["message"] ?? 'Update failed');
      }
    } catch (e) {
      toastMessage(message: e.toString());
    }
  }

  void _refreshForStatusChange(String status) {
    switch (status) {
      case 'APPROVED':   // now item lives in Ongoing
        _refreshTab(kTabPending);
        _refreshTab(kTabOngoing);
        break;
      case 'COMPLETED':  // now item lives in Completed
        _refreshTab(kTabOngoing);
        _refreshTab(kTabCompleted);
        break;
      case 'REJECTED':   // now item lives in Rejected (from Pending/Ongoing)
        _refreshTab(kTabPending);
        _refreshTab(kTabOngoing);
        _refreshTab(kTabRejected);
        break;
      default:
        _refreshAll();
    }
  }

  void _refreshAll() {
    pendingController.refresh();
    ongoingController.refresh();
    approvedController.refresh();
    rejectedController.refresh();
  }

  void _refreshTab(int tab) {
    switch (tab) {
      case kTabPending:
        pendingController.refresh();
        break;
      case kTabOngoing:
        ongoingController.refresh();
        break;
      case kTabCompleted:
        approvedController.refresh();
        break;
      case kTabRejected:
        rejectedController.refresh();
        break;
    }
  }

  /// -------------- Lazy load on tab selection --------------
  void selectTab(int tabIndex) {
    if (selectedTabIndex.value == tabIndex) return;
    selectedTabIndex.value = tabIndex;
    _ensureListenerFor(tabIndex);
    _triggerFirstLoadIfNeeded(tabIndex);
  }

  void _ensureListenerFor(int tabIndex) {
    if (_listenerAdded[tabIndex]) return;

    switch (tabIndex) {
      case kTabPending:
        pendingController.addPageRequestListener(getPending);
        break;
      case kTabOngoing:
        ongoingController.addPageRequestListener(getOngoing);
        break;
      case kTabCompleted:
        approvedController.addPageRequestListener(getApproved);
        break;
      case kTabRejected:
        rejectedController.addPageRequestListener(getRejected);
        break;
    }
    _listenerAdded[tabIndex] = true;
  }

  void _triggerFirstLoadIfNeeded(int tabIndex) {
    if (_firstLoadTriggered[tabIndex]) return;

    switch (tabIndex) {
      case kTabPending:
        pendingController.refresh();
        break;
      case kTabOngoing:
        ongoingController.refresh();
        break;
      case kTabCompleted:
        approvedController.refresh();
        break;
      case kTabRejected:
        rejectedController.refresh();
        break;
    }
    _firstLoadTriggered[tabIndex] = true;
  }

  @override
  void onInit() {
    super.onInit();
    // Attach/Load only for the initial tab (lazy for others)
    _ensureListenerFor(selectedTabIndex.value);
    _triggerFirstLoadIfNeeded(selectedTabIndex.value);
  }

  @override
  void onClose() {
    pendingController.dispose();
    ongoingController.dispose();
    approvedController.dispose();
    rejectedController.dispose();
    super.onClose();
  }
}
