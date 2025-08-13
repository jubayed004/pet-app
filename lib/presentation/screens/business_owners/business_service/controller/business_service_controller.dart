import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/model/business_service_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessServiceController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<BusinessServiceModel> service = BusinessServiceModel().obs;

  Future<void> getBusinessService() async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getBusinessService());
      if (response.statusCode == 200) {
        final newData = BusinessServiceModel.fromJson(response.body);
        service.value = newData;
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


  ///=================== Deleted Service

  Future<void> deletedService ({ required String id})async {
    try {
      final response = await apiClient.delete(
        url: ApiUrl.deletedService(id: id), body: {},);

      if (response.statusCode == 200) {
        await getBusinessService();
        toastMessage(message: response.body?['message']?.toString());
        AppRouter.route.pop();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void onReady() {
    getBusinessService();
    super.onReady();
  }

  String getOpenDaysTextComplete({
    required String openingTime,
    required String closingTime,
    required String offDay,
  }) {
    List<String> daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    // If an offDay is provided, remove it from the list
    if (offDay.isNotEmpty) {
      daysOfWeek.remove(offDay);
    }

    // Function to group consecutive days
    List<String> groupConsecutiveDays(List<String> days) {
      List<String> result = [];
      List<String> temp = [];

      // Go through the list of days and group consecutive ones
      for (int i = 0; i < days.length; i++) {
        if (temp.isEmpty) {
          temp.add(days[i]);
        } else {
          int prevIndex = daysOfWeek.indexOf(temp.last);
          int currentIndex = daysOfWeek.indexOf(days[i]);

          // Check if the current day is consecutive to the last one
          if (currentIndex == prevIndex + 1) {
            temp.add(days[i]);
          } else {
            // Add the group to result and start a new group
            if (temp.length > 1) {
              result.add("${temp.first} - ${temp.last}");
            } else {
              result.add(temp.first);
            }
            temp = [days[i]]; // Start a new group with the current day
          }
        }
      }
      // Add the last group
      if (temp.isNotEmpty) {
        if (temp.length > 1) {
          result.add("${temp.first} - ${temp.last}");
        } else {
          result.add(temp.first);
        }
      }

      return result;
    }

    // Call function to group consecutive days
    List<String> groupedDays = groupConsecutiveDays(daysOfWeek);

    // Return the formatted text
    return groupedDays.isEmpty
        ? "Closed"
        : "${groupedDays.join(", ")} at $openingTime - $closingTime";
  }
}
