import 'package:get/get.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/presentation/screens/home/model/home_model.dart';
import 'package:pet_app/presentation/screens/notify/model/notify_model.dart';
import 'package:pet_app/service/api_service.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class NotifyController extends GetxController{

  final ApiClient apiClient = serviceLocator();
  /// ============================= GET Notify =====================================
  var loading = Status.completed.obs;
  loadingMethod(Status status) => loading.value = status;
  final Rx<NotifyModel> notify = NotifyModel().obs;

  Future<void> getNotify() async{
    loadingMethod(Status.completed);
    try{
      loadingMethod(Status.loading);
      final response = await apiClient.get(url: ApiUrl.getNotify());
      if (response.statusCode == 200) {
        final newData = NotifyModel.fromJson(response.body);
        notify.value = newData;
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
    }catch(e){
      loadingMethod(Status.error);
    }
  }
  @override
  void onReady() {
    super.onReady();
    getNotify();
  }

}