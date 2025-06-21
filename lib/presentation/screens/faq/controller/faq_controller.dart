import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/faq/model/faq_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class FaqController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  /// ============================= GET Faq Help =====================================
  final Rx<FaqModel> faqData = FaqModel().obs;
  var faqLoading = Status.completed.obs;

  // Method to update the loading status
  faqLoadingMethod(Status status) => faqLoading.value = status;

  // Fetching FAQ data from API
  Future<void> getFaq() async {
    try {
      faqLoadingMethod(Status.loading); // Show loading
      var response = await apiClient.get(url: ApiUrl.getFaq()); // API call

      // Checking if the response is successful
      int? statusCode = response.statusCode; // Nullable status code

      // Handle the response
      if (statusCode == 200) {
        faqData.value = FaqModel.fromJson(response.body); // Parsing response to FAQ model
        print(faqData.value);
        faqLoadingMethod(Status.completed); // Data loaded successfully
      } else {
        // Handling different response codes
        _handleResponseError(statusCode ?? 0);  // Provide default value if statusCode is null
      }
    } catch (e) {
      // Handle error in case of exception
      faqLoadingMethod(Status.error);
    }
  }

  // Method to handle different types of response errors
  void _handleResponseError(int statusCode) {
    if (statusCode == 503) {
      faqLoadingMethod(Status.internetError); // No internet
    } else if (statusCode == 404) {
      faqLoadingMethod(Status.noDataFound); // No data found
    } else {
      faqLoadingMethod(Status.error); // General error
    }
  }

  @override
  void onReady() {
    super.onReady();
    getFaq(); // Automatically fetch FAQs when the controller is ready
  }
}
