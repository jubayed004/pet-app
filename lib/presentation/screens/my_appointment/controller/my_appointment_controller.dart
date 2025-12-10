import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/my_appointment/model/appointment_booking_details_model.dart';
import 'package:pet_app/presentation/screens/my_appointment/model/appointment_booking_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

import '../../../../utils/variable/variable.dart';

class MyAppointmentController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final PagingController<int, BookingItem> pagingController1 = PagingController(
    firstPageKey: 1,
  );
  final Rx<BookingItem?> firstBooking = Rx(null);
  bool isRunning = false;

  Future<void> getAppointmentBooking({required int page}) async {
    if (isRunning) return;
    isRunning = true;

    try {
      final response = await apiClient.get(
        url: ApiUrl.getBookingAppointment(page: page),
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
        final newData = AppointmentBookingModel.fromJson(response.body);
        final newItems = newData.bookings ?? [];
        if (page == 1 && newItems.isNotEmpty) {
          firstBooking.value = newItems.first;
        }
        if (newItems.isEmpty) {
          pagingController1.appendLastPage(newItems);
        } else {
          pagingController1.appendPage(newItems, page + 1);
        }
      } else {
        pagingController1.error =
            response.body?['message'] ??
            "No internet connection. \nPlease check your connection and try again.";
      }
    } catch (_) {
      pagingController1.error = 'An error occurred';
    } finally {
      isRunning = false;
    }
  }

  // In your MyAppointmentController
  var singleAppointmentBookingLoading =
      Status.completed.obs; // <-- dedicated loading

  Future<void> getSingleAppointmentBooking() async {
    singleAppointmentBookingLoading.value = Status.loading; // Start loading
    try {
      final response = await apiClient.get(
        url: ApiUrl.getBookingAppointment(page: 1),
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
        final newData = AppointmentBookingModel.fromJson(response.body);
        final newItems = newData.bookings ?? [];

        if (newItems.isNotEmpty) {
          firstBooking.value = newItems.first;
          singleAppointmentBookingLoading.value = Status.completed;
        } else {
          firstBooking.value = null;
          singleAppointmentBookingLoading.value = Status.noDataFound;
        }
      } else if (response.statusCode == 503) {
        singleAppointmentBookingLoading.value = Status.internetError;
      } else {
        singleAppointmentBookingLoading.value = Status.error;
      }
    } catch (e) {
      firstBooking.value = null;
      singleAppointmentBookingLoading.value = Status.error;
    }
  }

  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<AppointmentBookingDetailsModel> appointmentBookingDetails =
      AppointmentBookingDetailsModel().obs;

  ///===================== Appointment Booking Details ====================
  Future<void> getAppointmentBookingDetails({required String id}) async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(
        url: ApiUrl.getBookingAppointmentDetails(id: id),
      );
      logger.d(response.body);
      if (response.statusCode == 200) {
        final newData = AppointmentBookingDetailsModel.fromJson(response.body);
        appointmentBookingDetails.value = newData;
        loadingMethod(Status.completed);
      } else {
        if (response.statusCode == 503) {
          loadingMethod(Status.internetError);
        } else if (response.statusCode == 404) {
          loadingMethod(Status.noDataFound);
        } else {
          loadingMethod(Status.error);
        }
      }
    } catch (e) {
      loadingMethod(Status.error);
    }
  }

  ///=================== Deleted Booking Appointment
  /*
  Future<void> deletedBookingAppointment({required String id})async {
    try {
      final response = await apiClient.delete(
          url: ApiUrl.deletedBookingAppointment(id: id));

      if (response.statusCode == 200) {
         pagingController1.refresh();
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.pop();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }  */
  Future<void> cencelBookingAppointment({
    required String id,
    required Map<String, String> body,
  }) async {
    try {
      final response = await apiClient.put(
        url: ApiUrl.cencelBookingAppointment(id: id),
        body: body,
      );
      if (response.statusCode == 200) {
        pagingController1.refresh();
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.pop();
        await getSingleAppointmentBooking();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
