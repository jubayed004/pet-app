import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/screens/my_appointment/controller/my_appointment_controller.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

Future<void> defaultDeletedYesNoDialog({required BuildContext context, required VoidCallback onYes, required String title}) {
  return showDialog<void>(
    context: context,
    builder:
        (dialogCtx) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: CustomText(text: title, maxLines: 2, fontWeight: FontWeight.w400, fontSize: 14),
          content: SizedBox(
            height: 100.h,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6, maxWidth: MediaQuery.of(context).size.width * 0.9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: 45.h,
                            borderRadius: 8.r,
                            onTap: onYes,
                            title: "Yes",
                            fillColor: Colors.white,
                            borderColor: Colors.black,
                            isBorder: true,
                            textColor: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            height: 45.h,
                            borderRadius: 8.r,
                            onTap: () => Navigator.of(dialogCtx).pop(),
                            title: "No",
                            textColor: Colors.red,
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

Future<void> defaultDeletedYesNoCencelDialog({required BuildContext context, required String title,required String id, required MyAppointmentController controller }) {
  final TextEditingController cencelReason = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog<void>(
    context: context,
    builder:
        (dialogCtx) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: CustomText(text: title, maxLines: 2, fontWeight: FontWeight.w400, fontSize: 14),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6, maxWidth: MediaQuery.of(context).size.width * 0.9),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 8.h,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        textEditingController: cencelReason,
                        fillColor: Colors.white,
                        hintText: "Cancel Reason",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a reason for cancellation';
                          }
                          return null;  // Return null if validation passes
                        },
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              height: 45.h,
                              borderRadius: 8.r,
                              onTap: () {
                                final body = {
                                  "cancellationReason" : cencelReason.text
                                };
                                if(formKey.currentState!.validate()){
                                  controller.cencelBookingAppointment(id: id,body :body);
                                }

                              },
                              title: "Yes",
                              fillColor: Colors.white,
                              borderColor: Colors.black,
                              isBorder: true,
                              textColor: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              height: 45.h,
                              borderRadius: 8.r,
                              onTap: () => Navigator.of(dialogCtx).pop(),
                              title: "No",
                              textColor: Colors.white,
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
        ),
  );
}
