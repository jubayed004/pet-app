import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';

class ReviewController extends GetxController {
  ///================================= AddHealth Update
  final ApiClient apiClient = serviceLocator();
  RxBool isUpdateLoading = false.obs;
  RxString statusValue = "COMPLETED".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> addReview({required Map<String, Object> body}) async {
    try {
      isUpdateLoading.value = true;
      final response = await apiClient.post(url: ApiUrl.addReview(), body: body,);

      if (response.statusCode == 201) {
        isUpdateLoading.value = false;
        AppRouter.route.pop();
      } else {
        isUpdateLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isUpdateLoading.value = false;
      toastMessage(message: 'An error occurred while adding the review.');
    }
  }
}
