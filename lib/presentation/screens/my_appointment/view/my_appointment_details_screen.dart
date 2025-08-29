import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/service/api_url.dart';

class MyAppointmentDetailsScreen extends StatefulWidget {
  final String id;

  const MyAppointmentDetailsScreen({super.key, required this.id});

  @override
  State<MyAppointmentDetailsScreen> createState() =>
      _MyAppointmentDetailsScreenState();
}

class _MyAppointmentDetailsScreenState
    extends State<MyAppointmentDetailsScreen> {
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
            CustomDefaultAppbar(
              title: "My Appointment Details",
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  final item = controller.appointmentBookingDetails.value.booking?.serviceId;
                  final serviceImage = item?.servicesImages;
                 final image = serviceImage != null && serviceImage.isNotEmpty ? serviceImage :"";
                  final serviceLogo = item?.shopLogo;
                  final logo = (serviceLogo != null && serviceLogo.isNotEmpty) ? serviceLogo : "";
                  print("===============================================${ApiUrl.imageBase}$image");
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomNetworkImage(
                            imageUrl: "${ApiUrl.imageBase}$image",
                            width: 200,
                            height: 200,
                            boxShape: BoxShape.circle,
                          ),
                          Positioned(
                              bottom: 0,
                              child:   CustomNetworkImage(
                                imageUrl: "${ApiUrl.imageBase}$logo",
                                width: 70,
                                height: 100,
                                boxShape: BoxShape.circle,
                              ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*                const Text(
                          "📅 Upcoming Appointment",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),*/

                          // Each line: Static label + Dynamic value
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Pet Name: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "Bella"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Vet Name: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "pull"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Clinic: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "sandal"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Service: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "general veterinary checkup"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Date: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "25/12/2025"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Time: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "11: 00 PM"),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Location: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "24542 Wastonishington Ave "),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Phone: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "20524524524"),
                              ],
                            ),
                          ),


                          const SizedBox(height: 16),

                          // Action buttons
                          Row(
                            spacing: 10,
                            children: [


                              ElevatedButton(
                                onPressed: () {
                                  AppRouter.route.pushNamed(
                                      RoutePath.reviewScreen);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Review"),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                    Icons.chat, size: 16, color: Colors.green),
                                label: Text(
                                  "Chat",
                                  style: TextStyle(color: Colors.green),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.green),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("Website"),
                              ),
                            ],
                          )
                        ],
                      ),

                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
