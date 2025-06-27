import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
class BusinessBookingController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  final PagingController<int, Widget> pendingController = PagingController(firstPageKey: 1);
  final PagingController<int, Widget> approvedController = PagingController(firstPageKey: 1);
  final PagingController<int, Widget> rejectedController = PagingController(firstPageKey: 1);

  RxBool isLoadingPending = false.obs;
  RxBool isLoadingApproved = false.obs;
  RxBool isLoadingRejected = false.obs;

  Future<void> getPending(int pageKey) async {
    final mockPending = List.generate(10, (index) => CustomText(text: "Pending $index"));
    pendingController.appendLastPage(mockPending);
  }

  Future<void> getApproved(int pageKey) async {
    final mockApproved = List.generate(10, (index) => CustomText(text: "Approved $index"));
    approvedController.appendLastPage(mockApproved);
  }

  Future<void> getRejected(int pageKey) async {
    final mockRejected = List.generate(10, (index) => CustomText(text: "Rejected $index"));
    rejectedController.appendLastPage(mockRejected);
  }

  @override
  void onInit() {
    pendingController.addPageRequestListener((pageKey) {
      getPending(pageKey);
    });
    approvedController.addPageRequestListener((pageKey) {
      getApproved(pageKey);
    });
    rejectedController.addPageRequestListener((pageKey) {
      getRejected(pageKey);
    });
    super.onInit();
  }
}

/*
class BusinessBookingController extends GetxController{
  final RxInt selectedTabIndex = 0.obs;
  final PagingController<int, Widget> pendingController = PagingController(firstPageKey: 1);
  final PagingController<int, Widget> approvedController = PagingController(firstPageKey: 1);
  final PagingController<int, Widget> rejectedController = PagingController(firstPageKey: 1);
  final ApiClient apiClient = serviceLocator();
  RxBool isLoadingPending = false.obs;
  RxBool isLoadingApproved = false.obs;
  RxBool isLoadingRejected = false.obs;



  Future<void> getPending(int pageKey) async {
    pendingController.appendLastPage(pendingController.firstPageKey);
*/
/*    if (isLoadingPending.value) return;
    isLoadingPending.value = true;
    try {

      final response = await apiClient.get(url: ApiUrl.getDashboard(status: "Pending", page: pageKey));

      if (response.statusCode == 200) {
        final userServiceAll = HomeModel.fromJson(response.body);
        final newItems = userServiceAll.data?.result ?? [];

        if (newItems.isEmpty) {
          pendingController.appendLastPage(newItems);
        } else {
          pendingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pendingController.error = 'Error fetching data';
      }

    } catch (e) {
      pendingController.error = 'An error occurred';
    } finally {
      isLoadingPending.value = false;
    }*//*

  }

  Future<void> getApproved(int pageKey) async {
    pendingController.appendLastPage(approvedController);
*/
/*    if (isLoadingApproved.value) return;
    isLoadingApproved.value = true;

    try {
      final response = await apiClient.get(url: ApiUrl.getDashboard(page: pageKey,status: "Approved"));

      if (response.statusCode == 200) {
        final userServiceAll = HomeModel.fromJson(response.body);
        final newItems = userServiceAll.data?.result ?? [];

        if (newItems.isEmpty) {
          approvedController.appendLastPage(newItems);
        } else {
          approvedController.appendPage(newItems, pageKey + 1);
        }
      } else {
        approvedController.error = 'Error fetching data';
      }

    } catch (e) {
      approvedController.error = 'An error occurred';
    } finally {
      isLoadingApproved.value = false;
    }*//*

  }

  Future<void> getRejected(int pageKey) async {
    pendingController.appendLastPage(rejectedController);
*/
/*    if (isLoadingRejected.value) return;
    isLoadingRejected.value = true;

    try {
      final response = await apiClient.get(url: ApiUrl.getDashboard(page: pageKey, status: "Rejected"));

      if (response.statusCode == 200) {
        final userServiceAll = HomeModel.fromJson(response.body);
        final newItems = userServiceAll.data?.result ?? [];

        if (newItems.isEmpty) {
          rejectedController.appendLastPage(newItems);
        } else {
          rejectedController.appendPage(newItems, pageKey + 1);
        }
      } else {
        rejectedController.error = 'Error fetching data';
      }

    } catch (e) {
      rejectedController.error = 'An error occurred';
    } finally {
      isLoadingRejected.value = false;
    }*//*

  }

  Future<void> updateItemStatus({ required String id , required String status, }) async {
*/
/*    try {
      final response = await apiClient.patch(
        url: ApiUrl.updateStatus( id: id),
        body: {'status': status},
      );

      if (response.statusCode == 200) {
        if (status == "Approved") {
          pendingController.refresh();
          approvedController.refresh();
          rejectedController.refresh();
        } else if (status == "Rejected") {
          pendingController.refresh();
          rejectedController.refresh();
          approvedController.refresh();
        }
        toastMessage(message: response.body?["message"]);
      } else {
        toastMessage(message: response.body?["message"]);
      }
    } catch (e) {
      toastMessage(message: 'An error occurred');
    }*//*

  }

  @override
  void onInit() {
    super.onInit();

    pendingController.addPageRequestListener((pageKey) {
      getPending(pageKey);
    });
    approvedController.addPageRequestListener((pageKey) {
      getApproved(pageKey);
    });
    rejectedController.addPageRequestListener((pageKey) {
      getRejected(pageKey);
    });
    super.onInit();
  }
}*/
