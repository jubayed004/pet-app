import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/components/custom_text_field/description_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
Future<void> showAddReviewDialog(BuildContext context, String id, String ownerId, String serviceId) {
  final TextEditingController comments = TextEditingController();
  final reviewController = GetControllers.instance.getReviewController();
  final formKey = GlobalKey<FormState>();
  double rating = 3;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: const CustomText(
        text: "Add Review",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 6.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Rating Bar
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    rating = newRating;
                  },
                ),

                // Comment Section
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    text: "Share more about your experience",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DescriptionTextField(
                  hintText: "Share details of your own experience at this place",
                  backgroundColor: Colors.white,
                  radius: 20,
                  contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  controller: comments,
                  maxLines: 10,

                ),

                CustomButton(
                  onTap: () {

                    final body = {
                      "comment": comments.text,
                      "rating": rating.toString(),
                      "businessId": id,
                      "ownerId": ownerId,
                      "serviceId": serviceId,
                    };

                    if (formKey.currentState!.validate()) {
                      reviewController.addReview(
                        body: body,
                      );
                    }
                  },
                  title: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}



Future<void> editAddReviewDialog(BuildContext context, String date,
    String title, String name, String id) {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  TextEditingController dateController = TextEditingController(text: date);
  TextEditingController treatmentName = TextEditingController(text: title);
  TextEditingController drName = TextEditingController(text: name);
  final formKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: const CustomText(text: "Edit Health Update",
            fontWeight: FontWeight.w600,
            fontSize: 16,),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Form(
                key: formKey,
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
                      textEditingController: treatmentName,
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
                      textEditingController: drName,
                      hintText: " Dr name",
                      fillColor: AppColors.whiteColor,
                    ),
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
                            dateController.text = "${pickedDate
                                .year}/${pickedDate.month}/${pickedDate.day}";
                          }
                        },
                      ),
                    ),

                    CustomButton(
                      onTap: () {
                        final body = {
                          "treatmentName": treatmentName.text,
                          "doctorName": drName.text,
                          "treatmentDate": dateController.text,
                          "treatmentStatus": businessAllPetController.statusValue.value,
                        };
                        if (kDebugMode) {
                          print(body);
                        }
                        if (formKey.currentState!.validate()) {
                          businessAllPetController.editHealth(body: body,
                              id: id,
                              status: businessAllPetController.statusValue.value);
                        }
                      },


                      title: "Update",

                    )
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}
