import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/screens/review/model/review_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class ReviewController extends GetxController {


  ///================================= Add Review ========================================
  final ApiClient apiClient = serviceLocator();
  RxBool isLoading = false.obs;
  RxString statusValue = "COMPLETED".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> addReview({required Map<String, Object> body, required String id}) async {
    try {
      isLoading.value = true;
      final response = await apiClient.post(url: ApiUrl.addReview(), body: body,);

      if (response.statusCode == 201) {
        await getReviewByService(id: id);
        isLoading.value = false;
        AppRouter.route.pop();
      } else {
        isLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isLoading.value = false;
      toastMessage(message: 'An error occurred while adding the review.');
    }
  }
/*
  ///====================Get Review 
  RxBool isGetLoading = false.obs;
  Future<void> getReview({required String id}) async {
    try {
      isGetLoading.value = true;
      final response = await apiClient.get(url: ApiUrl.getReview(id: id), );

      if (response.statusCode == 200) {
        isGetLoading.value = false;
        AppRouter.route.pop();
      } else {
        isGetLoading.value = false;
        toastMessage(message: response.body?['message']?.toString());
      }
    } catch (error) {
      isGetLoading.value = false;
      toastMessage(message: 'An error occurred while adding the review.');
    }
  }*/
  var loading = Status.completed.obs;

  loadingMethod(Status status) => loading.value = status;
  final Rx<ReviewModel> review = ReviewModel().obs;

  ///===================== getReviewByService ====================
  Future<void> getReviewByService({required String id}) async {
    loadingMethod(Status.completed);
    try {
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getReview(id: id));
      if (response.statusCode == 200) {
        final newData = ReviewModel.fromJson(response.body);
        review.value = newData;
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