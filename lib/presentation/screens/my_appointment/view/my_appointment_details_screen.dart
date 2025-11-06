import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointmentDetailsScreen extends StatefulWidget {
  final String id;

  const MyAppointmentDetailsScreen({super.key, required this.id});

  @override
  State<MyAppointmentDetailsScreen> createState() => _MyAppointmentDetailsScreenState();
}

class _MyAppointmentDetailsScreenState extends State<MyAppointmentDetailsScreen> {
  final controller = GetControllers.instance.getMyAppointmentController();

  @override
  void initState() {
    controller.getAppointmentBookingDetails(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getAppointmentBookingDetails(id: widget.id);
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "My Appointment Details"),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  final item = controller.appointmentBookingDetails.value.booking?.serviceId;
                  final serviceImage = item?.servicesImages;
                  final image = (serviceImage != null && serviceImage.isNotEmpty) ? serviceImage : "";
                  final serviceLogo = item?.shopLogo;
                  final logo = (serviceLogo != null && serviceLogo.isNotEmpty) ? serviceLogo : "";
                  final serviceType = item?.serviceType ?? "";
                  final location = item?.location ?? "";
                  final phone = item?.phone ?? "";
                  final website = item?.websiteLink ?? "";

                  final item1 = controller.appointmentBookingDetails.value.booking;
                  final selectedService = item1?.selectedService ?? "";
                  final bookingStatus = item1?.bookingStatus ?? "";

                  // ✅ Convert all server dates to local timezone before formatting
                  final bookingDate = DateFormat("dd MMMM yyyy").format(
                    (item1?.bookingDate ?? DateTime.now()).toLocal(),
                  );
                  final bookingTime = item1?.bookingTime ?? "";

                  final checkInDate = DateFormat("dd MMMM yyyy").format(
                    (item1?.checkInDate ?? DateTime.now()).toLocal(),
                  );
                  final checkInTime = item1?.checkInTime ?? "";

                  final checkOutDate = DateFormat("dd MMMM yyyy").format(
                    (item1?.checkOutDate ?? DateTime.now()).toLocal(),
                  );
                  final checkOutTime = item1?.checkOutTime ?? "";

                  final notes = item1?.notes ?? "";

                  print("===============================================${ApiUrl.imageBase}$image");

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomNetworkImage(
                            imageUrl: image,
                            width: 200,
                            height: 200,
                            boxShape: BoxShape.circle,
                          ),
                          Positioned(
                            bottom: 0,
                            child: CustomNetworkImage(
                              imageUrl: logo,
                              width: 70,
                              height: 100,
                              boxShape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Appointment",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Service Type : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: serviceType),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Selected Service : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: selectedService),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Booking Status : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: bookingStatus),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Booking Date : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: bookingDate),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Booking Time: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: bookingTime),
                              ],
                            ),
                          ),
                          if (["HOTEL"].contains(item?.serviceType))
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: "Check In Date : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: checkInDate),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: "Check In Time: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: checkInTime),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: "Check Out Date : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: checkOutDate),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: "Check Out Time : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: checkOutTime),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Location: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: location),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: phone),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Extra Information : ", style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: notes),
                              ],
                            ),
                          ),
                          Gap(16),
                          Row(
                            spacing: 10,
                            children: [
                              if (["COMPLETE"].contains(item1?.bookingStatus))
                             /* bookingStatus == "COMPLETE" ? SizedBox() :*/ Flexible(
                                  child: CustomButton(
                                    onTap: () {
                                      AppRouter.route.pushNamed(
                                        RoutePath.reviewScreen,
                                        extra: {
                                          "serviceId": item1?.id ?? "",
                                          "ownerId": item1?.ownerId ?? "",
                                          "businessId": item1?.businessId ?? "",
                                        },
                                      );
                                    },
                                    title: "Review",
                                    fillColor: Colors.yellow,
                                    textColor: Colors.black,
                                  ),
                                ),
                              Flexible(
                                child: CustomButton(
                                  onTap: () {
                                    AppRouter.route.pushNamed(RoutePath.chatScreen, extra: item1?.ownerId);
                                  },
                                  title: "Chat",
                                  textColor: Colors.black,
                                ),
                              ),
                              if (["HOTEL"].contains(item?.serviceType))
                                Flexible(
                                  child: CustomButton(
                                    onTap: () async {
                                      String websiteUrl = item?.websiteLink ?? "";
                                      if (websiteUrl.isEmpty) websiteUrl = "https://www.defaultwebsite.com";
                                      if (!websiteUrl.startsWith('http')) websiteUrl = 'https://$websiteUrl';
                                      final Uri url = Uri.parse(websiteUrl);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    title: "Website",
                                    fillColor: AppColors.purple500,
                                    textColor: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                })
              ),
            ),
          ],
        ),
      ),
    );
  }
}
