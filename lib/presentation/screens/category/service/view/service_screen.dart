import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_dropdown/custom_drop_down_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

import '../../../my_pets/model/my_all_pet_model.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.bookingTime, required this.showWebsite});

  final bool bookingTime;
  final bool showWebsite;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final controller = GetControllers.instance.getCategoryDetailsController();
  final serviceController = GetControllers.instance.getServiceController();
  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  DateTime? selectedDate;

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
              child: Column(
                spacing: 12,
                children: [
                  CustomAlignText(
                    text: "Selected your service",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),

                  Obx(() {
                    final List<Pet>? items = myPetsController.profile.value.pet;
                    final List<String?> itemList = items != null && items.isNotEmpty
                        ? items.map((pet) => pet.name).toList()
                        : [];
                    return CustomDropdown(
                      title: "Select your Pet ",
                      items: itemList,
                    );
                  }),

                  Obx(() {
                    return CustomDropdown(
                      title: "Select your services ",
                      items: controller.categoryDetails.value.service?.providings ?? [],
                    );
                  }),
                  CustomAlignText(
                    text: "Choose a date",
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
                        CustomText(
                          text: selectedDate == null ? "Select date" : DateFormat('yyyy-MM-dd',).format(selectedDate!),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Icon(Iconsax.calendar_1),
                        ),
                      ],
                    ),
                  ),
                  CustomAlignText(text: " Pick a Time",fontWeight: FontWeight.w500,fontSize: 16,),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAlignText(
                            text: "Arrival time",
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

                      // ✅ Conditional receipt time column
                      ...widget.showWebsite
                          ? [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAlignText(
                              text: "Receipt time",
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
                      ]
                          : [],
                    ],
                  )),


                  /*     ...List.generate(
              choiceOfTopCookies.length,
              (index) => RoundedCheckboxListTile(
              isActive: index == choiceOfTopCookie,
              text: choiceOfTopCookies[index],
              press: () {
                setState(() {
                  choiceOfTopCookie = index;
                });
              },
            )),*/
                  Gap(24),
                  CustomButton(
                    onTap: () {
                      AppRouter.route.pushNamed(
                        RoutePath.bookAnAppointmentScreen,
                        extra: widget.bookingTime,
                      );
                    },
                    title: "Book an Appointment ",
                    textColor: Colors.black,
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                    ),
                    showIcon: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallDot extends StatelessWidget {
  const SmallDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}

class RoundedCheckboxListTile extends StatelessWidget {
  const RoundedCheckboxListTile({
    super.key,
    this.isActive = false,
    required this.press,
    required this.text,
  });

  final bool isActive;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                CircleCheckBox(isActive: isActive),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF010F07).withOpacity(0.84),
                      height: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 24,
      width: 24,
      padding: EdgeInsets.all(isActive ? 3 : 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              isActive
                  ? const Color(0xFF22A45D).withOpacity(0.54)
                  : const Color(0xFF868686).withOpacity(0.54),
          width: 0.8,
        ),
      ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFF22A45D),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
