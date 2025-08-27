import 'package:flutter/material.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';

class MyAppointmentDetailsScreen extends StatelessWidget {
  const MyAppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "My Appointment Details",
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage(
                          'assets/images/womandogimage.png', // Make sure this matches your image path
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child:   CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/petshoplogo.png', // Make sure this matches your image path
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Sandal  Land",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 /* Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "📅 Upcoming Appointment",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("Pet Name: Bella"),
                        const Text("Vet Name: Dr. Emily Harper"),
                        const Text("Clinic: Sansal Land – Pixel Posse"),
                        const Text("Service: General Veterinary Checkup"),
                        const Text("Date: 25/11/2022"),
                        const Text("Time: 11:00 AM"),
                        const Text("Location: 4517 Washington Ave. (2.5 km)"),
                        const Text("Phone: (406) 555-0120"),
                        const Text("Status: ✅ Confirmed"),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.chat, size: 16, color: Colors.green),
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
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("Cancel"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),*/
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
                            TextSpan(text: "Pet Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Bella"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Vet Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "pullo"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Clinic: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "sansal"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Service: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "general vetenrinary checkup"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Date: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "25/12/2025"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Time: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "11: 00 PM"),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Location: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "24542 Wastonishington Ave "),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
                              AppRouter.route.pushNamed(RoutePath.reviewScreen);
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
                            icon: Icon(Icons.chat, size: 16, color: Colors.green),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
