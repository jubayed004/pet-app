import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessShopProfileScreen extends StatelessWidget {
  BusinessShopProfileScreen({super.key});

  final controller = GetControllers.instance.getMyPetsProfileController();
  final shopProfileController = GetControllers.instance.getBusinessShopProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "Business Profile ",
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 380,
              // increased from 320 to allow for taller card content
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background Image
                  Obx(() {
                    final value = shopProfileController.shopProfile.value
                        .business?.shopPic;

                    return value != null && value.isNotEmpty ? Image.network(
                      "${ApiUrl.imageBase}${value.first}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ) : Image.network(
                      'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    );
                  }),

                  // Card positioned below image, no fixed height, mainAxisSize.min ensures height matches content
                  Positioned(
                    top: 200,
                    left: 30,
                    right: 30,
                    child: Card(
                      color: AppColors.kWhiteColor,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40, bottom: 20, left: 16, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              return Text(
                                shopProfileController.shopProfile.value.business
                                    ?.businessName ?? "",
                                style: TextStyle(fontSize: 16),
                              );
                            }),

                            Gap(16),
                            CustomButton(
                              onTap: () async {
                                // Get the website URL
                                String? websiteUrl = shopProfileController.shopProfile.value.business?.website;

                                // If website URL is null or empty, use a fallback URL
                                if (websiteUrl == null || websiteUrl.isEmpty) {
                                  websiteUrl = "https://www.defaultwebsite.com"; // Provide a default URL
                                }

                                // Ensure the URL starts with 'http://' or 'https://'
                                if (!websiteUrl.startsWith('http://') && !websiteUrl.startsWith('https://')) {
                                  websiteUrl = 'https://' + websiteUrl; // Prepend 'https://' if not present
                                }

                                final Uri url = Uri.parse(websiteUrl); // Convert the string to Uri

                                // Check if the URL can be launched
                                if (await canLaunchUrl(url)) {
                                  // Launch the URL if possible
                                  await launchUrl(url);
                                } else {
                                  // Handle error if the URL can't be launched
                                  throw 'Could not launch $url';
                                }
                              },
                              title: "Visit Website",
                              textColor: Color(0xFF1E1E1E),
                              height: 30,
                              width: 140,
                              fontWeight: FontWeight.w400,
                              fillColor: Colors.white,
                              borderColor: Colors.black,
                              borderWidth: 1,
                              isBorder: true,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  // Floating avatar/logo overlapping the card
                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Obx(() {
                            final logo = shopProfileController.shopProfile.value
                                .business?.shopLogo;
                            return logo != null && logo.isNotEmpty ?
                            CustomNetworkImage(
                              imageUrl: "${ApiUrl.imageBase}$logo",
                            )
                                : CustomImage(
                                imageSrc: "assets/images/petshoplogo.png",
                                sizeWidth: 90);
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                children: [
                  Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.businessType,
                        textAlign: TextAlign.start,
                      ),
                      Expanded(
                        child: Obx(() {
                          final List<String?> type = shopProfileController
                              .shopProfile.value.business?.servicesType ?? [];
                          return Wrap(
                            children: List.generate(type.length, (index) {
                              String text = "${type[index]}${index !=
                                  type.length - 1 ? ',' : ''}";
                              return CustomText(
                                text: text,
                                maxLines: 4,
                                right: 4,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                          );
                        }),
                      ),
                    ],
                  ),
                  Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.businessAddress,
                        textAlign: TextAlign.start,
                      ),
                      Expanded(
                        child: Obx(() {
                          final address = shopProfileController.shopProfile
                              .value.business?.address;
                          return CustomText(
                            text: address ?? "",
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                    ],
                  ),

                  Gap(16),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    child: Obx(() {
                      final moreInfo = shopProfileController.shopProfile.value
                          .business?.moreInfo;
                      return CustomText(
                        text: moreInfo ?? "",
                        maxLines: 20,
                        textAlign: TextAlign.start,);
                    }),
                  ),
                  /*         Gap(24),
                   CustomButton(onTap: (){
                     AppRouter.route.pushNamed(RoutePath.serviceScreen);
                   },title: "What service do you want?",textColor: Colors.black,),*/
                  Gap(24),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
