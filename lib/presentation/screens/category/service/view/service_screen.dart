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
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

import '../../../my_pets/model/my_all_pet_model.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.showWebsite, required this.id, required this.businessId});
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
  final TextEditingController extraInformationController = TextEditingController();
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: ()async{
            serviceController.appointmentLoading.value;
          },
          child: CustomScrollView(
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

                    Obx(() {
                      final provider = controller.categoryDetails.value.service?.providings ?? [];
                      final stringProvider = provider.isNotEmpty ? provider.first : "";
                      final List<String> providerList = stringProvider.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                      return CustomDropdown(
                        onChanged: (v) {
                          if (v != null && v.isNotEmpty) {
                            serviceController.selectedService.value = v;
                          }
                        },
                        title: "Select your services",
                        items: providerList,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a service';
                          }
                          return null;
                        },
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomAlignText(
                              text: "Booking date",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 6),
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
                                      text: DateFormat('yyyy-MM-dd').format(serviceController.bookingDate.value),
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
                                        serviceController.bookingDate.value = pickedDate;
                                      }
                                    },
                                    child: Icon(Iconsax.calendar_1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Obx(() =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAlignText(
                                  text: "Booking time",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                GestureDetector(
                                  onTap: () => serviceController.pickBookingTime(context),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    padding: EdgeInsets.all(13),
                                    margin: EdgeInsets.only(top: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black, width: 1),
                                    ),
                                    child: CustomText(
                                      text: serviceController.bookingTime.value == null
                                          ? "Booking time"
                                          : serviceController.bookingTime.value!.format(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                  if (widget.showWebsite) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomAlignText(
                                  text: "Check in date",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  margin: EdgeInsets.only(top: 6),
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
                                          text: DateFormat('yyyy-MM-dd').format(serviceController.checkingDate.value),
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
                                            serviceController.checkingDate.value = pickedDate;
                                          }
                                        },
                                        child: Icon(Iconsax.calendar_1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(() =>
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomAlignText(
                                      text: "Check in time",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    GestureDetector(
                                      onTap: () => serviceController.pickCheckingTime(context),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/3,
                                        padding: EdgeInsets.all(14),
                                        margin: EdgeInsets.only(top: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black, width: 1),
                                        ),
                                        child: CustomText(
                                          text: serviceController.checkingTime.value == null
                                              ? "Check in time"
                                              : serviceController.checkingTime.value!.format(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomAlignText(
                                  text: "Check out date",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  margin: EdgeInsets.only(top: 6),
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
                                          text: DateFormat('yyyy-MM-dd').format(serviceController.checkoutDate.value),
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
                                            serviceController.checkoutDate.value = pickedDate;
                                          }
                                        },
                                        child: Icon(Iconsax.calendar_1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(() =>
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomAlignText(
                                      text: "Check out time",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    GestureDetector(
                                      onTap: () => serviceController.pickCheckoutTime(context),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/3,
                                        padding: EdgeInsets.all(14),
                                        margin: EdgeInsets.only(top: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black, width: 1),
                                        ),
                                        child: CustomText(
                                          text: serviceController.checkoutTime.value == null
                                              ? "Check out time"
                                              : serviceController.checkoutTime.value!.format(context),
                                        ),
                                      ),
                                    ),
      
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ],
                    CustomAlignText(text: "Extra information",fontWeight: FontWeight.w600,fontSize: 14),
                    CustomTextField(
                      textEditingController: extraInformationController,
                      fillColor: Colors.white,
                      hintText: "Type here",
                      keyboardType: TextInputType.text,
             /*         validator: (v){
                        if(v == null || v.isEmpty){
                          return "Please type extra info ";
                        }
                        return null;
                      },*/
                    ),
                    Gap(24),
                    Obx(() {
                      return CustomButton(
                        isLoading: serviceController.appointmentLoading.value,
                        onTap: () {
                          final bookingTime = serviceController.bookingTime.value;
                          final checkInTime = serviceController.checkingTime.value;
                          final checkOutTime = serviceController.checkoutTime.value;
                          final bookingDate = serviceController.bookingDate.value;
                          final checkingDate = serviceController.checkingDate.value;
                          final checkoutDate = serviceController.checkoutDate.value;
                          final selectedService = serviceController.selectedService.value;
                          final selectedPet = serviceController.selectedPet.value;
                          final body = {
                            "serviceId": widget.id,
                            "businessId": widget.businessId,
                            "bookingTime": bookingTime != null ?
                            "${bookingTime.hour.toString().padLeft(2, '0')}:${bookingTime.minute.toString().padLeft(2, '0')}" : "",
                            "checkInTime": checkInTime != null ?
                            "${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}" : "",
                            "checkOutTime": checkOutTime != null ?
                            "${checkOutTime.hour.toString().padLeft(2, '0')}:${checkOutTime.minute.toString().padLeft(2, '0')}" : "",
                            "bookingDate": bookingDate.toUtc().toIso8601String(),
                            "checkInDate": checkingDate.toUtc().toIso8601String(),
                            "checkOutDate": checkoutDate.toUtc().toIso8601String(),
                            "selectedService": selectedService,
                            "petId": selectedPet,
                            "notes" : extraInformationController.text
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
        ),
      ),
    );
  }
}

