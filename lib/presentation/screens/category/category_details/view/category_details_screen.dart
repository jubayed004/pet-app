import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen(
      {super.key, required this.showWebsite, required this.id,});

  final bool showWebsite;
  final String id;


  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final controller = GetControllers.instance.getCategoryDetailsController();
  @override
  void initState() {
    controller.getCategoryDetails(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCategoryDetails(id: widget.id);
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(
              title: "Category Details ",
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
                      final image = controller.categoryDetails.value.service
                          ?.servicesImages;
                      return image != null && image.isNotEmpty ? Image.network(
                        "${ApiUrl.imageBase}$image",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ) : CustomNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                        width: double.infinity,
                        height: 250,
                      );
                    }),
                    /*    Positioned(
                       top: 30,
                         left: 30,
                         child: IconButton(onPressed: (){
                          AppRouter.route.pop();
                         }, icon: Icon(Icons.arrow_back,color: Colors.black,))),*/
                    // Card positioned below image, no fixed height, mainAxisSize.min ensures height matches content
                    Positioned(
                      top: 180,
                      left: 30,
                      right: 30,
                      child: Card(
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
                                final serviceName = controller.categoryDetails.value.service?.serviceType;
                                return CustomText(text: serviceName ?? "",
                                  fontWeight: FontWeight.w600, fontSize: 14,

                                );
                              }),
                              SizedBox(height: 8),
                              Obx(() {
                                final item = controller.categoryDetails.value.service;
                                return Row(
                                  spacing: 8,
                                  children: [
                                    Icon(Icons.access_time, size: 24),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            text: "Open day - ${
                                                controller.getOpenDaysTextComplete(
                                              offDay: item?.offDay ?? "",
                                              openingTime: item?.openingTime ?? "",
                                              closingTime: item?.closingTime ?? "",
                                            )}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          CustomText(
                                            fontSize: 14,fontWeight: FontWeight.w500,
                                            text: "Off day - ${item?.offDay ?? ""}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*  Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppRouter.route.pushNamed(
                          RoutePath.businessEditServiceScreen,
                          extra: {
                            'id': item.id ?? "",
                            'serviceName': item.serviceName ?? "",
                            'location': item.location ?? "",
                            'websiteLink': item.websiteLink ?? "",
                            'phoneNumber': item.phone ?? "",
                            'serviceController': providerList,
                          },
                        );
                      },
                      child: Assets.icons.editico.svg(width: 26),
                    ),
                    GestureDetector(
                      onTap: () {
                        defaultDeletedYesNoDialog(
                          context: context,
                          title: 'Are you sure you want to delete this Service?',
                          onYes: () {
                            businessServiceController.deletedService(id: item.id ?? "");
                          },
                        );
                      },
                      child: Assets.icons.deletedicon.svg(
                        width: 36,
                        colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),*/
                                  ],
                                );
                              }),
                              Gap(16),
                              widget.showWebsite ?  CustomButton(
                                onTap: () async {
                                  // Get the website URL
                                  String? websiteUrl = controller
                                      .categoryDetails.value.service
                                      ?.websiteLink;
                                  // If website URL is null or empty, use a fallback URL
                                  if (websiteUrl == null ||
                                      websiteUrl.isEmpty) {
                                    websiteUrl =
                                    "https://www.defaultwebsite.com"; // Provide a default URL
                                  }
                                  // Ensure the URL starts with 'http://' or 'https://'
                                  if (!websiteUrl.startsWith('http://') &&
                                      !websiteUrl.startsWith('https://',)) {
                                    websiteUrl =
                                    'https://$websiteUrl'; // Prepend 'https://' if not present
                                  }
                                  final Uri url = Uri.parse(websiteUrl,
                                  ); // Convert the string to Uri
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
                                textColor: Colors.white,
                                height: 30.h,
                                width: 140.w,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fillColor:  AppColors.purple500,
                                borderColor: Colors.transparent,
                                borderWidth: 1,
                                isBorder: true,
                              ):SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Floating avatar/logo overlapping the card
                    Positioned(
                      top: 120,
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
                              final logo = controller.categoryDetails.value.service?.shopLogo;
                              return logo != null && logo.isNotEmpty ?
                              CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 10,
                                imageUrl:
                                "${ApiUrl.imageBase}${logo.replaceAll("\\", "/")}",
                              )
                                  : CustomImage(
                                imageSrc: "assets/images/petshoplogo.png",
                                sizeWidth: 50,
                              );
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomText(text: "Rating"),
                              Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 18,)),
                                  ),
                                  Gap(6),
                                  CustomText(text: "5.0 ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                            final businessType = controller.categoryDetails
                                .value
                                .service?.serviceName;
                            return CustomText(
                              text: businessType ?? "",
                              maxLines: 4,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
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
                            final address = controller.categoryDetails.value
                                .service?.location;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.businessPhone,
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: Obx(() {
                            final phoneNum = controller.categoryDetails.value
                                .service?.phone;
                            return CustomText(
                              text: phoneNum ?? "",
                              maxLines: 4,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                        ),
                      ],
                    ),

                    Gap(24),
                    CustomButton(onTap: () {
                      final businessID = controller.categoryDetails.value.service?.businessId;
                      final id = controller.categoryDetails.value.service?.id;

                      if (id == null || id.isEmpty || businessID == null || businessID.isEmpty) {
                        debugPrint("🚫 Navigation prevented: id or businessId is null/empty");
                        return;
                      }

                      if(!widget.showWebsite){
                        debugPrint("🚫 Navigation prevented: isPetHotel is ${widget.showWebsite}");
                      }

                      final extraData = {
                        'isHotel': widget.showWebsite,
                        'id': id,
                        'businessId': businessID,
                      };

                      AppRouter.route.pushNamed(
                        RoutePath.serviceScreen,
                        extra: extraData,
                      );

                    },
                      title: "What service do you want?",
                      textColor: Colors.black,),
                    Gap(24),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
