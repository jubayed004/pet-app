/*
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
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
        child: Column(
          children: [
            CustomText(
              maxLines: 20,
                text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
          ],
        )
        
        
        */
/*Obx(() {
          switch (controller.termsLoading.value) {
            case Status.loading:
              return Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 40.0,
                ),
              );
            case Status.internetError:
              return NoInternetCard(onTap: ()=>controller.getTermsCondition());
            case Status.noDataFound:
              return Center(child: NoDataCard(onTap: ()=>controller.getPrivacyPolicy()));
            case Status.error:
              return ErrorCard(onTap: ()=>controller.getTermsCondition());

            case Status.completed:
              return  HtmlWidget(controller.termsData.value.data?.description ?? "");
          }
        },
      ),*//*

    )
    );
  }
}
*/
