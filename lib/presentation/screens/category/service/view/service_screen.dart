import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/toast_message/toast_message.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

import '../../../my_pets/model/my_all_pet_model.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen(
      {super.key, required this.showWebsite, required this.id, required this.businessId});

  final bool showWebsite;
  final String id;
  final String businessId;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final controller = GetControllers.instance.getCategoryDetailsController();
  final serviceController = GetControllers.instance.getServiceController();
  final myPetsController = GetControllers.instance.getMyPetsProfileController();
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "Service"),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
          child: Form(
            key: _formKey,  // Form key for validation
            child: Column(
              spacing: 12,
              children: [
                CustomAlignText(
                  text: "Select your service",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),

                // Pet Dropdown with validation
                Obx(() {
                  final List<Pet>? pets = myPetsController.profile.value.pet;

                  final Map<String, Pet> petMap = {
                    for (var pet in pets ?? []) if (pet.name != null) pet.name!: pet
                  };

                  return CustomDropdown(
                    onChanged: (v) {
                      if (v != null && v.isNotEmpty && petMap.containsKey(v)) {
                        final selectedPet = petMap[v]!;
                        if (selectedPet.id != null) {
                          serviceController.selectedPet.value = selectedPet.id ?? "";
                        }
                      }
                    },
                    title: "Select your Pet",
                    items: petMap.keys.toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a pet';
                      }
                      return null;
                    },
                  );
                }),

                // Service Dropdown with validation
                Obx(() {
                  return CustomDropdown(
                    onChanged: (v) {
                      if (v != null && v.isNotEmpty) {
                        serviceController.selectedService.value = v;
                      }
                    },
                    title: "Select your services",
                    items: controller.categoryDetails.value.service?.providings ?? [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a service';
                      }
                      return null;
                    },
                  );
                }),

                // Date picker with validation
                CustomAlignText(
                  text: "Choose a booking date",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return CustomText(
                          text: DateFormat('yyyy-MM-dd').format(serviceController.selectedDate.value),
                        );
                      }),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            serviceController.selectedDate.value = pickedDate;
                          }
                        },
                        child: Icon(Iconsax.calendar_1),
                      ),
                    ],
                  ),
                ),


                CustomAlignText(text: "Pick a Time", fontWeight: FontWeight.w500, fontSize: 16,),
                Obx(() =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAlignText(
                              text: "Booking time",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            GestureDetector(
                              onTap: () => serviceController.pickOpeningTime(context),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: CustomText(
                                  text: serviceController.openingTime.value == null
                                      ? "Select arrival time"
                                      : serviceController.openingTime.value!.format(context),
                                ),
                              ),
                            ),
                          ],
                        ),


                        if (widget.showWebsite) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAlignText(
                                text: "CheckOut time",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              GestureDetector(
                                onTap: () => serviceController.pickClosingTime(context),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black, width: 1),
                                  ),
                                  child: CustomText(
                                    text: serviceController.closingTime.value == null
                                        ? "Select receipt time"
                                        : serviceController.closingTime.value!.format(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                ),

                Gap(24),
                // Submit Button with validation
                Obx(() {
                  return CustomButton(
                    isLoading: serviceController.appointmentLoading.value,
                    onTap: () {
                      final bookingTime = serviceController.openingTime.value;
                      final bookingDate = serviceController.selectedDate.value;
                      final selectedService = serviceController.selectedService.value;
                      final selectedPet = serviceController.selectedPet.value;
                      final body = {
                        "serviceId": widget.id,
                        "businessId": widget.businessId,
                        "bookingTime": bookingTime != null
                            ? "${bookingTime.hour.toString().padLeft(2, '0')}:${bookingTime.minute.toString().padLeft(2, '0')}"
                            : "",
                        "bookingDate": bookingDate.toUtc().toIso8601String(),
                        "selectedService": selectedService,
                        "petId": selectedPet,
                      };
                      if (_formKey.currentState!.validate()) {
                        serviceController.bookingAppointmentService(body: body);
                      }else{
                        toastMessage(message: "Select Your All Services",);
                      }
                    },
                    title: "Book an Appointment",
                    textColor: Colors.black,
                    icon: Icon(Icons.calendar_month_outlined, color: Colors.black),
                    showIcon: true,
                  );
                }),
              ],
            ),
          ),
        ),
      )
        ],
      ),
    );
  }
}

