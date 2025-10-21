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
  const ServiceScreen({
    super.key,
    required this.showWebsite,
    required this.id,
    required this.businessId,
  });
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
  void dispose() {
    extraInformationController.dispose();
    super.dispose();
  }

  String? _validateBookingTime() {
    if (serviceController.bookingTime.value == null) {
      return 'Please select booking time';
    }
    return null;
  }

  String? _validateCheckInTime() {
    if (!widget.showWebsite) return null;
    if (serviceController.checkingTime.value == null) {
      return 'Please select check-in time';
    }
    return null;
  }

  String? _validateCheckOutTime() {
    if (!widget.showWebsite) return null;
    if (serviceController.checkoutTime.value == null) {
      return 'Please select check-out time';
    }

    // Validate check-out is after check-in
    final checkIn = serviceController.checkingDate.value;
    final checkOut = serviceController.checkoutDate.value;
    final checkInTime = serviceController.checkingTime.value;
    final checkOutTime = serviceController.checkoutTime.value;

    if (checkInTime != null && checkOutTime != null) {
      final checkInDateTime = DateTime(
        checkIn.year, checkIn.month, checkIn.day,
        checkInTime.hour, checkInTime.minute,
      );
      final checkOutDateTime = DateTime(
        checkOut.year, checkOut.month, checkOut.day,
        checkOutTime.hour, checkOutTime.minute,
      );

      if (checkOutDateTime.isBefore(checkInDateTime) ||
          checkOutDateTime.isAtSameMomentAs(checkInDateTime)) {
        return 'Check-out must be after check-in';
      }
    }
    return null;
  }

  bool _validateAllFields() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    final timeError = _validateBookingTime();
    final checkInError = _validateCheckInTime();
    final checkOutError = _validateCheckOutTime();

    if (timeError != null) {
      toastMessage(message: timeError);
      return false;
    }
    if (checkInError != null) {
      toastMessage(message: checkInError);
      return false;
    }
    if (checkOutError != null) {
      toastMessage(message: checkOutError);
      return false;
    }

    // Validate booking date is not in the past
    final now = DateTime.now();
    final booking = serviceController.bookingDate.value;
    if (booking.isBefore(DateTime(now.year, now.month, now.day))) {
      toastMessage(message: 'Booking date cannot be in the past');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: RefreshIndicator(
          onRefresh: () async {
            serviceController.appointmentLoading.value = false;
          },
          child: CustomScrollView(
            slivers: [
              const CustomDefaultAppbar(title: "Book Service"),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        _buildSectionHeader(
                          icon: Iconsax.pet,
                          title: "Pet & Service Selection",
                        ),
                        Gap(16.h),

                        // Pet Selection Card
                        _buildCard(
                          child: Obx(() {
                            final List<Pet>? pets = myPetsController.profile.value.pet;
                            final Map<String, Pet> petMap = {
                              for (var pet in pets ?? [])
                                if (pet.name != null) pet.name!: pet
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
                              title: "Select Your Pet",
                              items: petMap.keys.toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a pet';
                                }
                                return null;
                              },
                            );
                          }),
                        ),
                        Gap(12.h),

                        // Service Selection Card
                        _buildCard(
                          child: Obx(() {
                            final provider = controller.categoryDetails.value.service?.providings ?? [];
                            final stringProvider = provider.isNotEmpty ? provider.first : "";
                            final List<String> providerList = stringProvider
                                .split(',')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();

                            return CustomDropdown(
                              onChanged: (v) {
                                if (v != null && v.isNotEmpty) {
                                  serviceController.selectedService.value = v;
                                }
                              },
                              title: "Select Service",
                              items: providerList,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a service';
                                }
                                return null;
                              },
                            );
                          }),
                        ),

                        Gap(32.h),

                        // Booking Date & Time Section
                        _buildSectionHeader(
                          icon: Iconsax.calendar,
                          title: "Booking Schedule",
                        ),
                        Gap(16.h),

                        _buildCard(
                          child: Column(
                            children: [
                              _buildDateTimePicker(
                                label: "Booking Date",
                                dateValue: serviceController.bookingDate,
                                timeValue: serviceController.bookingTime,
                                onDateTap: () => _selectDate(
                                  context,
                                  serviceController.bookingDate,
                                  minDate: DateTime.now(),
                                ),
                                onTimeTap: () => serviceController.pickBookingTime(context),
                                isRequired: true,
                              ),
                            ],
                          ),
                        ),

                        // Check-in/Check-out Section (conditional)
                        if (widget.showWebsite) ...[
                          Gap(32.h),
                          _buildSectionHeader(
                            icon: Iconsax.login,
                            title: "Check-In & Check-Out",
                          ),
                          Gap(16.h),

                          _buildCard(
                            child: Column(
                              children: [
                                _buildDateTimePicker(
                                  label: "Check-In",
                                  dateValue: serviceController.checkingDate,
                                  timeValue: serviceController.checkingTime,
                                  onDateTap: () => _selectDate(
                                    context,
                                    serviceController.checkingDate,
                                    minDate: serviceController.bookingDate.value,
                                  ),
                                  onTimeTap: () => serviceController.pickCheckingTime(context),
                                  isRequired: true,
                                ),
                                Divider(height: 32.h, color: Colors.grey.shade200),
                                _buildDateTimePicker(
                                  label: "Check-Out",
                                  dateValue: serviceController.checkoutDate,
                                  timeValue: serviceController.checkoutTime,
                                  onDateTap: () => _selectDate(
                                    context,
                                    serviceController.checkoutDate,
                                    minDate: serviceController.checkingDate.value,
                                  ),
                                  onTimeTap: () => serviceController.pickCheckoutTime(context),
                                  isRequired: true,
                                ),
                              ],
                            ),
                          ),
                        ],

                        Gap(32.h),

                        // Additional Information Section
                        _buildSectionHeader(
                          icon: Iconsax.note,
                          title: "Additional Information",
                          isRequired: false,
                        ),
                        Gap(16.h),

                        _buildCard(
                          child: CustomTextField(
                            textEditingController: extraInformationController,
                            fillColor: Colors.white,
                            hintText: "Any special requests or information...",
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                          ),
                        ),

                        Gap(40.h),

                        // Book Appointment Button
                        Obx(() {
                          return CustomButton(
                            isLoading: serviceController.appointmentLoading.value,
                            onTap: () {
                              if (!_validateAllFields()) return;

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
                                "bookingTime": bookingTime != null
                                    ? "${bookingTime.hour.toString().padLeft(2, '0')}:${bookingTime.minute.toString().padLeft(2, '0')}"
                                    : "",
                                "checkInTime": checkInTime != null
                                    ? "${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}"
                                    : "",
                                "checkOutTime": checkOutTime != null
                                    ? "${checkOutTime.hour.toString().padLeft(2, '0')}:${checkOutTime.minute.toString().padLeft(2, '0')}"
                                    : "",
                                "bookingDate": bookingDate.toUtc().toIso8601String(),
                                "checkInDate": checkingDate.toUtc().toIso8601String(),
                                "checkOutDate": checkoutDate.toUtc().toIso8601String(),
                                "selectedService": selectedService,
                                "petId": selectedPet,
                                "notes": extraInformationController.text.trim(),
                              };

                              serviceController.bookingAppointmentService(body: body);
                            },
                            title: "Book Appointment",
                            textColor: Colors.white,
                            icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
                            showIcon: true,
                          );
                        }),
                        Gap(20.h),
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    bool isRequired = true,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: Colors.blue.shade700),
        ),
        Gap(12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        if (isRequired) ...[
          Gap(4.w),
          Text(
            '*',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required Rx<DateTime> dateValue,
    required Rx<TimeOfDay?> timeValue,
    required VoidCallback onDateTap,
    required VoidCallback onTimeTap,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            if (isRequired) ...[
              Gap(4.w),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ],
        ),
        Gap(12.h),
        Row(
          children: [
            // Date Picker
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: onDateTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        DateFormat('MMM dd, yyyy').format(dateValue.value),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      )),
                      Icon(Iconsax.calendar_1, size: 20.sp, color: Colors.blue.shade700),
                    ],
                  ),
                ),
              ),
            ),
            Gap(12.w),
            // Time Picker
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTimeTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        timeValue.value?.format(context) ?? "Time",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: timeValue.value != null
                              ? Colors.grey.shade800
                              : Colors.grey.shade400,
                        ),
                      )),
                      Icon(Iconsax.clock, size: 20.sp, color: Colors.blue.shade700),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      Rx<DateTime> dateValue, {
        DateTime? minDate,
      }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateValue.value.isBefore(minDate ?? DateTime.now())
          ? (minDate ?? DateTime.now())
          : dateValue.value,
      firstDate: minDate ?? DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade700,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dateValue.value = pickedDate;
    }
  }
}