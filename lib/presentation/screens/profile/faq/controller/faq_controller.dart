import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/profile/faq/model/faq_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class FaqController extends GetxController {
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  /// ============================= GET Faq Help =====================================
  final Rx<FaqModel> faqData = FaqModel().obs;
  var faqLoading = Status.completed.obs;
  faqLoadingMethod(Status status) => faqLoading.value = status;
  Future<void> getFaq() async {
    try {
      faqLoadingMethod(Status.loading);
      var response = await apiClient.get(url: ApiUrl.getFaq());
      int? statusCode = response.statusCode;
      if (statusCode == 200) {
        faqData.value = FaqModel.fromJson(response.body);
        print(faqData.value);
        faqLoadingMethod(Status.completed);
      } else {
        _handleResponseError(statusCode ?? 0);
      }
    } catch (e) {
      faqLoadingMethod(Status.error);
    }
  }
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
    getFaq();
  }
}
