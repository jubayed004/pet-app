import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/custom_space.dart';

Future<void> showAddHealthDialog(BuildContext context) {
  final TextEditingController dateController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: const CustomText(text: "Add Health Update",fontSize: 16,fontWeight: FontWeight.w600,),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            spacing: 6.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///============ Treatment Name
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Treatment Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: "Treatment Name",
                fillColor: AppColors.whiteColor,
              ),

              ///============ Name
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Dr Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: " Dr name",
                fillColor: AppColors.whiteColor,
              ),

              ///====== Status
              CustomDropdown(
                borderColor: AppColors.kBlackColor,
                fillColor: AppColors.kWhiteColor,
                items: ["COMPLETED","PENDING"],
                title: "Treatment Status",
                hintText: "Treatment Status",
              ),

              ///======= Date
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: "Select date",
                fillColor: AppColors.whiteColor,
                readOnly: true, // prevents typing
                textEditingController: dateController,
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
              ),

              CustomButton(
                onTap: (){
                  AppRouter.route.pop();
                },
                title: "Submit",

              )
            ],
          ),
        ),
      ),
    ),
  );
}
Future<void> editAddHealthDialog(BuildContext context) {
  final TextEditingController dateController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: const CustomText(text: "Edit Health Update",fontWeight: FontWeight.w600,fontSize: 16,),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            spacing: 6.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///============ Treatment Name
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Treatment Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: "Treatment Name",
                fillColor: AppColors.whiteColor,
              ),

              ///============ Name
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Dr Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: " Dr name",
                fillColor: AppColors.whiteColor,
              ),

              ///====== Status
              CustomDropdown(
                borderColor: AppColors.kBlackColor,
                fillColor: AppColors.kWhiteColor,
                items: ["COMPLETED","PENDING"],
                title: "Treatment Status",
                hintText: "Treatment Status",
              ),

              ///======= Date
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: "Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              CustomTextField(
                hintText: "Select date",
                fillColor: AppColors.whiteColor,
                readOnly: true, // prevents typing
                textEditingController: dateController,
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
              ),

          CustomButton(
            onTap: (){
              AppRouter.route.pop();
            },
            title: "Update",

          )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> defaultYesNoDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onYes,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: const Text("Are you sure you want to delete this record?"),
      content: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        borderRadius: 8.r,
                        onTap: () {
                          Navigator.of(dialogCtx).pop();   // close first
                          Future.microtask(onYes);
                        },
                        title: "Yes",
                        borderColor: AppColors.kPrimaryDarkColor,
                        textColor: AppColors.kPrimaryDarkColor,

                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        borderRadius: 8.r,
                        onTap: () => Navigator.of(dialogCtx).pop(),
                        title: "No",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
