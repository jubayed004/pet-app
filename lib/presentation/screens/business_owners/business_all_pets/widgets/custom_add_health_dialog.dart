import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/custom_space.dart';

Future<void> showAddHealthDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Health Update"),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                  child: CustomText(text: "Type",fontSize: 14,fontWeight: FontWeight.w600,)),
             space6H,
             CustomTextField(
               hintText: "Type",
               fillColor: AppColors.whiteColor,
             ),
              space6H,
              Align(
                alignment: Alignment.topLeft,
                  child: CustomText(text: "Name",fontSize: 14,fontWeight: FontWeight.w600,)),
             space6H,
             CustomTextField(
               hintText: "Type",
               fillColor: AppColors.whiteColor,
             ),

              space6H,
              Align(
                alignment: Alignment.topLeft,
                  child: CustomText(text: "Dr.Name",fontSize: 14,fontWeight: FontWeight.w600,)),
             space6H,
             CustomTextField(
               hintText: "Type",
               fillColor: AppColors.whiteColor,
             ),


              space6H,
              Align(
                alignment: Alignment.topLeft,
                  child: CustomText(text: "Date",fontSize: 14,fontWeight: FontWeight.w600,)),
             space6H,
             CustomTextField(
               hintText: "Type",
               fillColor: AppColors.whiteColor,
               suffixIcon: Icon(Icons.calendar_month),
             ),


              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
