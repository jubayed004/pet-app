import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

Future<void> showAddHealthDialog(
  BuildContext context,
  String id,
  PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
  PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
) {
  final TextEditingController treatmentName = TextEditingController();
  final TextEditingController treatmentDescription = TextEditingController();
  final TextEditingController drName = TextEditingController();

  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: CustomText(text: "Add Health Update", fontSize: 16.sp, fontWeight: FontWeight.w600),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7, maxWidth: MediaQuery.of(context).size.width * 0.11),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 6.h,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///============ Treatment Name ============
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Treatment Name", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(
                      textEditingController: treatmentName,
                      hintText: "Treatment Name",
                      fillColor: AppColors.whiteColor,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Treatment Name is required";
                        }
                        return null;
                      },
                    ),

                    ///============ Name ==============
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Dr Name", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(
                      textEditingController: drName,
                      hintText: "Dr name",
                      fillColor: AppColors.whiteColor,
                      validator: (value) {
                        final v = value?.trim() ?? "";
                        if (v.isEmpty) return "Doctor name is required";
                        if (v.length < 2) {
                          return "Doctor name must be at least 2 characters";
                        }
                        final nameOk = RegExp(r"^[A-Za-z .'-]+$").hasMatch(v);
                        if (!nameOk) {
                          return "Use letters, spaces, and . ' - only";
                        }
                        return null;
                      },
                    ),

                    ///========== Status ==========
                    CustomDropdown(
                      onChanged: (v) {
                        if (v != null) {
                          businessAllPetController.statusValue.value = v;
                        }
                      },
                      borderColor: AppColors.kBlackColor,
                      fillColor: AppColors.kWhiteColor,
                      items: ["COMPLETED", "PENDING"],
                      title: "Treatment Status",
                      hintText: "Treatment Status",
                    ),

                    ///========== Date ===========
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Date", fontSize: 14, fontWeight: FontWeight.w600)),

                    Obx(() {
                      return CustomTextField(
                        hintText: DateFormat("dd MMMM yyyy").format(businessAllPetController.selectedDate.value),
                        fillColor: AppColors.whiteColor,
                        readOnly: true,
                        // prevents typing
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
                              businessAllPetController.selectedDate.value = pickedDate;
                            }
                          },
                        ),
                      );
                    }),

                    ///========== Treatment Description ===========
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Treatment Description", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(
                      textEditingController: treatmentDescription,
                      hintText: "Treatment Description",
                      fillColor: AppColors.whiteColor,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Treatment Description is required";
                        }
                        return null;
                      },
                    ),

                    Obx(() {
                      return CustomButton(
                        isLoading: businessAllPetController.isUpdateLoading.value,
                        onTap: () {
                          final body = {
                            "treatmentName": treatmentName.text,
                            "doctorName": drName.text,
                            "treatmentDescription": treatmentDescription.text,
                            "treatmentDate": businessAllPetController.selectedDate.value.toUtc().toIso8601String(),
                            "treatmentStatus": businessAllPetController.statusValue.value,
                          };

                          if (formKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print(body);
                            }
                            businessAllPetController.addHealth(
                              body: body,
                              id: id,
                              status: businessAllPetController.statusValue.value,
                              pagingController1: pagingController1,
                              pagingController: pagingController,
                            );
                          }
                        },
                        title: "Submit",
                      );
                    }),
                    Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}

Future<void> editAddHealthDialog({
  required BuildContext context,
  required String date,
  required String description,
  required String title,
  required String name,
  required String id,
  required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1,
  required PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController,
}) {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  TextEditingController dateController = TextEditingController(text: date);
  TextEditingController treatmentName = TextEditingController(text: title);
  final TextEditingController treatmentDescription = TextEditingController(text: description);
  TextEditingController drName = TextEditingController(text: name);
  print(name);
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: const CustomText(text: "Edit Health Update", fontWeight: FontWeight.w600, fontSize: 16),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6, maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 8.h,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///============ Treatment Name
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Treatment Name", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(textEditingController: treatmentName, hintText: "Treatment Name", fillColor: AppColors.whiteColor),

                    ///============ Name
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Dr Name", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(textEditingController: drName, hintText: " Dr name", fillColor: AppColors.whiteColor),

                    ///====== Status
                    CustomDropdown(
                      onChanged: (v) {
                        if (v != null) {
                          businessAllPetController.statusValue.value = v;
                        }
                      },
                      borderColor: AppColors.kBlackColor,
                      fillColor: AppColors.kWhiteColor,
                      items: ["COMPLETED", "PENDING"],
                      title: "Treatment Status",
                      hintText: "Treatment Status",
                    ),

                    ///======= Date
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Date", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(
                      hintText: "Select date",
                      fillColor: AppColors.whiteColor,
                      readOnly: true,
                      // prevents typing
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
                            dateController.text = "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                          }
                        },
                      ),
                    ),

                    ///========== Treatment Description ===========
                    Align(alignment: Alignment.topLeft, child: CustomText(text: "Treatment Description", fontSize: 14, fontWeight: FontWeight.w600)),

                    CustomTextField(
                      textEditingController: treatmentDescription,
                      hintText: "Treatment Description",
                      fillColor: AppColors.whiteColor,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Treatment Description is required";
                        }
                        return null;
                      },
                    ),

                    Obx(() {
                      return CustomButton(
                        isLoading: businessAllPetController.isUpdateLoading.value,
                        onTap: () {
                          final body = {
                            "treatmentName": treatmentName.text,
                            "doctorName": drName.text,
                            "treatmentDescription": treatmentDescription.text,
                            "treatmentDate": dateController.text,
                            "treatmentStatus": businessAllPetController.statusValue.value,
                          };
                          print(body);

                          if (formKey.currentState!.validate()) {
                            businessAllPetController.editHealth(
                              body: body,
                              id: id,
                              status: businessAllPetController.statusValue.value,
                              pagingController: pagingController,
                              pagingController1: pagingController1,
                            );
                          }
                        },

                        title: "Update",
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}

Future<void> defaultYesNoDialog({required BuildContext context, required String message, required VoidCallback onYes}) {
  return showDialog<void>(
    context: context,
    builder:
        (dialogCtx) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: const Text("Are you sure you want to delete this record?"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6, maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          borderRadius: 8.r,
                          onTap: onYes,
                          title: "Yes",
                          isBorder: true,
                          textColor: AppColors.blackColor,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(borderRadius: 8.r, onTap: () => Navigator.of(dialogCtx).pop(), title: "No", textColor: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
