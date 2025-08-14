import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/presentation/widget/back_button/back_button.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class TermsOfCondition extends StatelessWidget {
  TermsOfCondition({super.key});
  final controller = GetControllers.instance.getOtherController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(text: "Terms of condition",fontSize: 16,fontWeight: FontWeight.w500,),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Obx(() {
          switch (controller.termsLoading.value) {
            case Status.loading:
              return Center(
                child: SpinKitCircle(color: Colors.white, size: 40.0,),);
            case Status.internetError:
              return NoInternetCard(onTap: ()=>controller.getTermsCondition());
            case Status.noDataFound:
              return Center(child: NoDataCard(onTap: ()=>controller.getPrivacyPolicy()));
            case Status.error:
              return ErrorCard(onTap: ()=>controller.getTermsCondition());
            case Status.completed:
              return  HtmlWidget(controller.termsData.value.termsConditions?.description ?? "");
          }
        },
      ),
    )
    );
  }
}
