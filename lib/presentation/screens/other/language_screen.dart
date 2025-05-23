   /*
import 'package:colab/controller/language_controller.dart';
import 'package:colab/presentation/widget/align/custom_align_text.dart';
import 'package:colab/utils/app_colors/app_colors.dart';
import 'package:colab/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int? groupValue = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([getSelectedValue()]);
    });
  }

  Future<void> getSelectedValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? value = sharedPreferences.getInt(AppConstants.selectedValue);
    if(value != null){
      setState(() {
        groupValue = value;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("languages".tr),
        centerTitle: true,
      ),
      body: GetBuilder<LanguageController>(builder: (logic) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              CustomAlignText(text: "select_your_language".tr),
              Column(
                children: List.generate(logic.languages.length, (index){
                  return ListTile(
                    title: Text(logic.languages[index].languageName),
                    leading: Radio(
                        value: index+1,
                        groupValue: groupValue,
                        activeColor: AppColors.primaryColor,
                        onChanged: (int? value) {
                          logic.setLanguage(Locale(logic.languages[index].languageCode, logic.languages[index].countryCode),index+1);
                          setState(() {
                            groupValue = index+1;
                          });
                        },
                    ),
                    onTap: () {
                      logic.setLanguage(Locale(logic.languages[index].languageCode, logic.languages[index].countryCode),index+1);
                      setState(() {
                        groupValue = index+1;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
*/
