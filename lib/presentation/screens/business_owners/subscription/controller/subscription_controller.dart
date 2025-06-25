
import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:pet_app/presentation/screens/business_owners/subscription/model/subscription_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class SubscriptionController extends GetxController{
  final ApiClient apiClient = serviceLocator();
  final DBHelper dbHelper = serviceLocator();

  Rx<Status> subscription   = Status.loading.obs;
  Rx<SubscriptionModel> typeModel = SubscriptionModel().obs;

  void getSubscription() async {
/*    try {
      subscription(Status.loading);
      var response = await apiClient.get(url: ApiUrl.getSubscription());
      if (response.statusCode == 200) {
        typeModel.value = SubscriptionModel.fromJson(response.body);
        subscription(Status.completed);
      } else {
        subscription(Status.error);
      }
    } catch (err) {
      subscription(Status.error);
    }*/
  }
  

  RxBool isLoading = false.obs;
  
  void paymentUrl({required String subscriptionId}) async {
/*    try {
      isLoading.value = true;
      var response = await apiClient.post(url: ApiUrl.paymentUrlGet(), body: {"subscriptionId": subscriptionId});
      if (response.statusCode == 200) {

        final model = PaymentUrlModel.fromJson(response.body);
        isLoading.value = false;
        AppRouter.route.pushNamed(RoutePath.paymentWebViewScreen, extra: model.data);
      }else{
        isLoading.value = false;
      }
    } catch (err) {
      isLoading.value = false;
    }*/
  }

  @override
  void onReady() {
    super.onReady();
    getSubscription();
  }

}
class PaymentUrlModel {
  final String? data;

  PaymentUrlModel({
    this.data,
  });

  factory PaymentUrlModel.fromJson(Map<String, dynamic> json) => PaymentUrlModel(
    data: json["data"],
  );
}
