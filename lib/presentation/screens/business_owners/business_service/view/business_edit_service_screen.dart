import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_field.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessEditServiceScreen extends StatefulWidget {
  const BusinessEditServiceScreen({
    super.key,
    required this.serviceName,
    required this.phoneNumber,
    required this.location,
    required this.webSiteLInk,
    required this.id,
    required this.serviceList,
    required this.openingTime,
    required this.closingTime,
    required this.offDay,
    required this.serviceType,
  });

  final String serviceName;
  final String phoneNumber;
  final String location;
  final String webSiteLInk;
  final String id;
  final String openingTime;
  final String closingTime;
  final String offDay;
  final String serviceType;
  final List<String> serviceList;

  @override
  State<BusinessEditServiceScreen> createState() =>
      _BusinessEditServiceScreenState();
}

class _BusinessEditServiceScreenState extends State<BusinessEditServiceScreen> {
  final businessAddServiceController =
      GetControllers.instance.getBusinessAddServiceController();
  TextEditingController serviceName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController webSiteLInk = TextEditingController();
  ValueNotifier<List<TextEditingController>> serviceController = ValueNotifier(
    [],
  );
  final _formKey = GlobalKey<FormState>();
  final selectedLocation = ValueNotifier<RecordLocation>(
    RecordLocation(LatLng(0.0, 0.0), ""),
  );

  @override
  void initState() {
    super.initState();
    serviceName = TextEditingController(text: widget.serviceName);
    phoneNumber = TextEditingController(text: widget.phoneNumber);
    location = TextEditingController(text: widget.location);
    webSiteLInk = TextEditingController(text: widget.webSiteLInk);
    serviceController = ValueNotifier(
      widget.serviceList
          .map((service) => TextEditingController(text: service))
          .toList(),
    );

    // Defer reactive value assignments to prevent setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      businessAddServiceController.selectedAnalystType.value =
          widget.serviceType;
      businessAddServiceController.selectedWeek.value = widget.offDay;
    });
  }

  @override
  void dispose() {
    serviceName.dispose();
    phoneNumber.dispose();
    location.dispose();
    webSiteLInk.dispose();
    serviceController.dispose();
    super.dispose();
  }

  void _addBeltField() {
    serviceController.value = [
      ...serviceController.value,
      TextEditingController(),
    ];
  }

  void _removeBeltField(int index) {
    if (serviceController.value.length > 1) {
      final removed = serviceController.value[index];
      removed.dispose();
      final updated = [...serviceController.value]..removeAt(index);
      serviceController.value = updated;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: CustomText(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          text: "Edit Service",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: paddingH16V8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Service Photo",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  Gap(8),
                  GestureDetector(
                    onTap: businessAddServiceController.editPickImage,
                    child: SizedBox(
                      height: 156.h,
                      width: double.infinity,
                      child: Obx(() {
                        final image =
                            businessAddServiceController
                                .selecteImage
                                .value
                                ?.path;
                        return Stack(
                          children: [
                            Positioned.fill(
                              child:
                                  image != null && image.isNotEmpty
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.file(
                                          File(image),
                                          height: 156.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      : CustomNetworkImage(
                                        imageUrl:
                                            "https://www.rawpixel.com/image/12143311/png",
                                        height: 156.h,
                                        borderRadius: BorderRadius.circular(6),
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                            ),
                            /*       image != null && image.isNotEmpty
                                ? SizedBox()
                                : Center(
                                  child: Container(
                                    height: 30.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffC2C2C2), width: 1.w),
                                      color: AppColors.whiteColor700,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.image_outlined, size: 18.sp, color: AppColors.purple500),
                                  ),
                                ),*/
                          ],
                        );
                      }),
                    ),
                  ),
                  Gap(14),
                  CustomText(
                    text: "Service Type",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  CustomDropdownField(
                    hintText:
                        widget.serviceType.isNotEmpty
                            ? widget.serviceType
                            : "Service Type",
                    items:
                        businessAddServiceController.analystType.map((item) {
                          return item;
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        businessAddServiceController.selectedAnalystType.value =
                            value;
                      }
                    },
                  ),

                  Gap(16),
                  CustomText(
                    text: "Providing Service",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  ValueListenableBuilder<List<TextEditingController>>(
                    valueListenable: serviceController,
                    builder: (context, list, _) {
                      return Column(
                        children: List.generate(list.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    textEditingController: list[index],
                                    fieldBorderColor: AppColors.blackColor,
                                    fieldBorderRadius: 10,
                                    fillColor: Colors.white,
                                    hintText: "Enter Providing Service",
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      final v = (value ?? '').trim();
                                      if (v.isNotEmpty) {
                                        if (v.length < 3) {
                                          return 'At least 3 characters';
                                        }
                                        if (v.length > 100) {
                                          return 'Must be 100 characters or fewer';
                                        }
                                        final ok = RegExp(
                                          r"^[A-Za-z0-9&/.,\-()' ]+$",
                                        );
                                        if (!ok.hasMatch(v)) {
                                          return "Only letters, numbers, spaces, and -/.,()'& are allowed";
                                        }
                                        final hasAlnum = RegExp(
                                          r'[A-Za-z0-9]',
                                        ).hasMatch(v);
                                        if (!hasAlnum) {
                                          return 'Enter a meaningful service name';
                                        }
                                      }
                                      return null; // Valid or empty
                                    },
                                  ),
                                ),
                                const Gap(5),
                                index == 0
                                    ? IconButton(
                                      onPressed: _addBeltField,
                                      icon: const Icon(Iconsax.add_circle),
                                    )
                                    : IconButton(
                                      onPressed: () => _removeBeltField(index),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  Gap(14),
                  CustomText(
                    text: "Service Name",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter service name",
                    keyboardType: TextInputType.text,
                    textEditingController: serviceName,
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isNotEmpty && v.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),

                  Gap(14),
                  CustomText(
                    text: "Phone Number",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  CustomTextField(
                    fieldBorderColor: AppColors.blackColor,
                    fieldBorderRadius: 10,
                    fillColor: Colors.white,
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.phone,
                    textEditingController: phoneNumber,
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isNotEmpty) {
                        final phoneRegExp = RegExp(r'^\+?\d{7,15}$');
                        if (!phoneRegExp.hasMatch(v)) {
                          return "Enter a valid phone number";
                        }
                      }
                      return null;
                    },
                  ),

                  Gap(14),
                  CustomText(
                    text: "Location",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  GestureDetector(
                    onTap: () async {
                      _openLocationPicker(); // Trigger the location picker
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ValueListenableBuilder<RecordLocation>(
                        valueListenable: selectedLocation, // Listen to changes
                        builder: (_, item, _) {
                          String address =
                              item.address.isEmpty
                                  ? " selected Your Location"
                                  : item.address;
                          return Text(address);
                        },
                      ),
                    ),
                  ),

                  Gap(14),
                  CustomText(
                    text: " Time Duration",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  Gap(14),
                  CustomText(
                    text: "Opening time",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  Obx(() {
                    return GestureDetector(
                      onTap:
                          () => businessAddServiceController.pickOpeningTime(
                            context,
                          ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          businessAddServiceController.openingTime.value == null
                              ? (widget.openingTime.isEmpty
                                  ? "Select opening time"
                                  : widget.openingTime)
                              : businessAddServiceController.openingTime.value!
                                  .format(context),

                          style: TextStyle(
                            fontSize: 16,
                            color:
                                businessAddServiceController
                                            .openingTime
                                            .value ==
                                        null
                                    ? Colors.black
                                    : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                  Gap(14),
                  CustomText(
                    text: "Closing time",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  Obx(() {
                    return GestureDetector(
                      onTap:
                          () => businessAddServiceController.pickClosingTime(
                            context,
                          ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          businessAddServiceController.closingTime.value == null
                              ? (widget.openingTime.isEmpty
                                  ? "Select closing time"
                                  : widget.openingTime)
                              : businessAddServiceController.closingTime.value!
                                  .format(context),
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                businessAddServiceController
                                            .closingTime
                                            .value ==
                                        null
                                    ? Colors.black
                                    : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),

                  Gap(14),
                  CustomText(
                    text: "Off day",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Gap(8),
                  CustomDropdownField(
                    hintText:
                        widget.offDay.isNotEmpty
                            ? widget.offDay
                            : "Off Day Type",
                    items:
                        businessAddServiceController.weekly.map((item) {
                          return item;
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        businessAddServiceController.selectedWeek.value = value;
                      }
                    },
                  ),

                  Obx(() {
                    final value =
                        businessAddServiceController.selectedWeek.value;
                    if (["Pet Shops", "Pet Hotels"].contains(value)) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(14),
                          CustomText(
                            text: "Website Link",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          Gap(8),
                          CustomTextField(
                            fieldBorderColor: AppColors.blackColor,
                            fieldBorderRadius: 10,
                            fillColor: Colors.white,
                            hintText: "link here",
                            keyboardType: TextInputType.text,
                            textEditingController: webSiteLInk,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'link here';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters';
                              }
                              return null; // Valid
                            },
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  }),
                  Gap(24),
                  Obx(() {
                    return CustomButton(
                      isLoading:
                          businessAddServiceController.isEditLoading.value,
                      onTap: () {
                        print("index 1");
                        final List<String> services =
                            serviceController.value
                                .map((controller) => controller.text)
                                .toList();

                        final body = {
                          "serviceType":
                              businessAddServiceController
                                  .selectedAnalystType
                                  .value,
                          "serviceName": serviceName.text,
                          "providings": services.join(','),
                          "location": selectedLocation.value.address,
                          "phone": phoneNumber.text,
                          "openingTime":
                              businessAddServiceController.openingTime.value
                                  ?.format(context) ??
                              "",
                          "closingTime":
                              businessAddServiceController.closingTime.value
                                  ?.format(context) ??
                              "",
                          "offDay":
                              businessAddServiceController.selectedWeek.value,
                          "latitude":
                              selectedLocation.value.latLng.latitude.toString(),
                          "longitude":
                              selectedLocation.value.latLng.longitude
                                  .toString(),
                        };

                        if (_formKey.currentState!.validate()) {
                          businessAddServiceController.editService(
                            body: body,
                            id: widget.id,
                          );
                        }
                      },
                      title: "Update service",
                      textColor: Colors.black,
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

  Future<void> _openLocationPicker() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MapLocationPicker(
              config: MapLocationPickerConfig(
                apiKey: "AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4",
                initialPosition: const LatLng(37.422, -122.084),
                onNext: (result) {
                  if (result != null) {
                    selectedLocation.value = RecordLocation(
                      LatLng(
                        result.geometry.location.lat,
                        result.geometry.location.lng,
                      ),
                      result.formattedAddress ?? "Address not available",
                    );
                  }
                  if (context.mounted) {
                    Navigator.pop(context, result);
                  }
                },
              ),
              searchConfig: const SearchConfig(
                apiKey: "AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4",
                searchHintText: "Search for a location",
              ),
            ),
      ),
    );
  }
}

class RecordLocation {
  final LatLng latLng;
  final String address;

  RecordLocation(this.latLng, this.address);
}
