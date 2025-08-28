import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/my_appointment/model/appointment_booking_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class MyAppointmentController extends GetxController {
  final navController = GetControllers.instance.getNavigationControllerMain();



  final ApiClient apiClient = serviceLocator();
  final PagingController<int, Booking>pagingController1 = PagingController(firstPageKey: 1);

  Future<void> getAppointmentBooking({required int page}) async {
    final response = await apiClient.get(
      url: ApiUrl.getBookingAppointment(page: page),
    );
    if (response.statusCode == 200) {
      final newData = AppointmentBookingModel.fromJson(response.body);
      final newItems = newData.bookings ?? [];
      if (newItems.isEmpty) {
        pagingController1.appendLastPage(newItems);
      } else {
        pagingController1.appendPage(newItems, page + 1);
      }
    } else {
      pagingController1.error = 'An error occurred';
    }
  }



  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<AppointmentBookingModel> appointmentDetails = AppointmentBookingModel().obs;

  ///===================== Category details ====================
  Future<void> getAppointmentBookingDetails() async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getBookingAppointmentDetails());
      if (response.statusCode == 200) {
        final newData = AppointmentBookingModel.fromJson(response.body);
        appointmentDetails.value = newData;
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


}
