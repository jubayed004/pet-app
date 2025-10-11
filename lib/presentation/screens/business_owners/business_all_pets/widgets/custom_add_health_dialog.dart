import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
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
  businessAllPetController.selectedDate.value = DateTime.now();
  businessAllPetController.statusValue.value = "COMPLETED";

  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE54D4D),
                    const Color(0xFFE54D4D).withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: Text(
                      "Add Health Update",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Treatment Name
                      _buildLabel("Treatment Name *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: treatmentName,
                        hintText: "e.g., Rabies Vaccine",
                        fillColor: Colors.grey[50],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Treatment name is required";
                          }
                          if (value.trim().length < 3) {
                            return "Treatment name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Doctor Name
                      _buildLabel("Doctor Name *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: drName,
                        hintText: "e.g., Dr. Smith",
                        fillColor: Colors.grey[50],
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
                      const Gap(16),

                      // Treatment Status
                      CustomDropdown(
                        onChanged: (v) {
                          if (v != null) {
                            businessAllPetController.statusValue.value = v;
                          }
                        },
                        borderColor: Colors.grey[300]!,
                        fillColor: Colors.grey[50]!,
                        items: const ["COMPLETED", "PENDING"],
                        title: "Treatment Status *",
                        hintText: "Select status",
                      ),
                      const Gap(16),

                      // Date
                      _buildLabel("Treatment Date *"),
                      const Gap(8),
                      Obx(() {
                        return CustomTextField(
                          hintText: DateFormat("dd MMMM yyyy").format(
                            businessAllPetController.selectedDate.value,
                          ),
                          fillColor: Colors.grey[50],
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month,
                              color: const Color(0xFFE54D4D),
                            ),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: dialogContext,
                                initialDate: businessAllPetController.selectedDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFFE54D4D),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                businessAllPetController.selectedDate.value = pickedDate;
                              }
                            },
                          ),
                        );
                      }),
                      const Gap(16),

                      // Treatment Description
                      _buildLabel("Treatment Description *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: treatmentDescription,
                        hintText: "Describe the treatment details...",
                        fillColor: Colors.grey[50],
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Treatment description is required";
                          }
                          if (value.trim().length < 10) {
                            return "Description must be at least 10 characters";
                          }
                          return null;
                        },
                      ),
                      const Gap(24),

                      // Submit Button
                      Obx(() {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: businessAllPetController.isUpdateLoading.value
                                ? null
                                : () {
                              if (formKey.currentState!.validate()) {
                                final body = {
                                  "treatmentName": treatmentName.text.trim(),
                                  "doctorName": drName.text.trim(),
                                  "treatmentDescription": treatmentDescription.text.trim(),
                                  "treatmentDate": businessAllPetController.selectedDate.value.toUtc().toIso8601String(),
                                  "treatmentStatus": businessAllPetController.statusValue.value,
                                };

                                if (kDebugMode) {
                                  print('Add Health Body: $body');
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE54D4D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: businessAllPetController.isUpdateLoading.value
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
  final TextEditingController dateController = TextEditingController(text: date);
  final TextEditingController treatmentName = TextEditingController(text: title);
  final TextEditingController treatmentDescription = TextEditingController(text: description);
  final TextEditingController drName = TextEditingController(text: name);

  // Parse the date string to DateTime
  DateTime? parsedDate;
  try {
    parsedDate = DateFormat('dd MMMM yyyy').parse(date);
  } catch (e) {
    parsedDate = DateTime.now();
  }
  businessAllPetController.selectedDate.value = parsedDate;

  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE54D4D),
                    const Color(0xFFE54D4D).withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: Text(
                      "Edit Health Update",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Treatment Name
                      _buildLabel("Treatment Name *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: treatmentName,
                        hintText: "Treatment Name",
                        fillColor: Colors.grey[50],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Treatment name is required";
                          }
                          if (value.trim().length < 3) {
                            return "Treatment name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      const Gap(16),

                      // Doctor Name
                      _buildLabel("Doctor Name *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: drName,
                        hintText: "Dr name",
                        fillColor: Colors.grey[50],
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
                      const Gap(16),

                      // Treatment Status
                      CustomDropdown(
                        onChanged: (v) {
                          if (v != null) {
                            businessAllPetController.statusValue.value = v;
                          }
                        },
                        borderColor: Colors.grey[300]!,
                        fillColor: Colors.grey[50]!,
                        items: const ["COMPLETED", "PENDING"],
                        title: "Treatment Status *",
                        hintText: "Treatment Status",
                      ),
                      const Gap(16),

                      // Date
                      _buildLabel("Treatment Date *"),
                      const Gap(8),
                      Obx(() {
                        return CustomTextField(
                          hintText: DateFormat("dd MMMM yyyy").format(
                            businessAllPetController.selectedDate.value,
                          ),
                          fillColor: Colors.grey[50],
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month,
                              color: const Color(0xFFE54D4D),
                            ),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: dialogContext,
                                initialDate: businessAllPetController.selectedDate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFFE54D4D),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                businessAllPetController.selectedDate.value = pickedDate;
                              }
                            },
                          ),
                        );
                      }),
                      const Gap(16),

                      // Treatment Description
                      _buildLabel("Treatment Description *"),
                      const Gap(8),
                      CustomTextField(
                        textEditingController: treatmentDescription,
                        hintText: "Treatment Description",
                        fillColor: Colors.grey[50],
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Treatment description is required";
                          }
                          if (value.trim().length < 10) {
                            return "Description must be at least 10 characters";
                          }
                          return null;
                        },
                      ),
                      const Gap(24),

                      // Update Button
                      Obx(() {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: businessAllPetController.isEditLoading.value
                                ? null
                                : () {
                              if (formKey.currentState!.validate()) {
                                final body = {
                                  "treatmentName": treatmentName.text.trim(),
                                  "doctorName": drName.text.trim(),
                                  "treatmentDescription": treatmentDescription.text.trim(),
                                  "treatmentDate": businessAllPetController.selectedDate.value.toUtc().toIso8601String(),
                                  "treatmentStatus": businessAllPetController.statusValue.value,
                                };

                                if (kDebugMode) {
                                  print('Edit Health Body: $body');
                                }

                                businessAllPetController.editHealth(
                                  body: body,
                                  id: id,
                                  status: businessAllPetController.statusValue.value,
                                  pagingController: pagingController,
                                  pagingController1: pagingController1,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE54D4D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: businessAllPetController.isEditLoading.value
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : const Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
    barrierDismissible: false,
    builder: (dialogContext) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                size: 48,
                color: Colors.red[400],
              ),
            ),
            const Gap(20),
            const Text(
              'Delete Record?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            const Gap(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[300]!),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onYes();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE54D4D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF2C3E50),
    ),
  );
}