import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/custom_tab_bar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/presentation/screens/my_appointment/widgets/my_appointment_container.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/app_images/app_images.dart' show AppImages;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = GetControllers.instance.getHomeController();
  final controller = GetControllers.instance.getProfileController();
  final _controller = GetControllers.instance.getOnboardingController();
  final navController = GetControllers.instance.getNavigationControllerMain();
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.appBackgroundColor,
              elevation: 0,
              toolbarHeight: 56,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Obx(() {
                                final imageFile = controller.selectedImage
                                    .value;
                                if (imageFile != null) {
                                  return ClipOval(
                                    child: Image.file(
                                      File(imageFile.path),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.blackColor.withAlpha(
                                        50),
                                    highlightColor: AppColors.blackColor
                                        .withAlpha(100),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),

                          Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  AppRouter.route.pushNamed(
                                      RoutePath.searchScreen);
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteColor,
                                      border: Border.all(
                                        color: AppColors.purple500,
                                      ),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Center(
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        text: AppStrings.searchForServices,
                                      )
                                  ),
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: badges.Badge(
                              onTap: () {
                                AppRouter.route.pushNamed(
                                    RoutePath.notifyScreen);
                                //AppRouter.route.pushNamed(RoutePath.textScreen);
                              },
                              badgeContent: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: AppColors.purple500,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                elevation: 2,
                              ),
                              position: badges.BadgePosition.topStart(
                                start: 10,
                                top: -20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  AppRouter.route.pushNamed(
                                      RoutePath.notifyScreen);
                                },
                                child: const Icon(
                                  CupertinoIcons.bell,
                                  size: 24,
                                  color: AppColors.purple500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(AppStrings.activePetProfiles, style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                        Gap(4),
                        CircleAvatar(
                          radius: 10,
                          child: CustomText(text: "1",
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,),
                        ),

                      ],
                    ),
                    Gap(16),
                    Obx(() {
                      return Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: _controller.onboardingList[_controller
                                      .currentIndex.value]
                                      .title,),
                                CustomText(
                                  text: _controller.onboardingList[_controller
                                      .currentIndex
                                      .value]
                                      .details,)
                              ],
                            ),
                            CustomImage(
                              imageSrc: "assets/images/petkalloimage.png",
                              sizeWidth: 80,)
                          ],
                        ),
                      );
                    }),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3, (index) => buildDot(index, context)),
                    ),
                  ],
                ),
              ),
            ),
            SliverGap(8),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: CustomText(text: AppStrings.findWhatYouNeed,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,)),
            ),
            SliverGap(8),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  padding: EdgeInsets.only(left: 16, right: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //homeController.selectedIndex.value = index;
                              AppRouter.route.pushNamed(
                                  RoutePath.categoryScreen, extra: index);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 3,
                              child: CircleAvatar(
                                backgroundColor: /* isSelected ? AppColors.primaryColor :*/ Colors
                                    .white,
                                radius: 40,
                                child: homeController.iconList[index],
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          CustomText(text: homeController.stringList[index],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      CustomImage(imageSrc: "assets/images/adshome.png"),
                    ],
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: AppStrings.upcomingAppointments,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,),
                      TextButton(onPressed: () {
                        AppRouter.route.pushNamed(
                            RoutePath.myAppointmentScreen);
                      },
                          child: CustomText(text: AppStrings.seeAll,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,))
                    ],
                  )),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Obx(() {
                  // final time = GetTimeAgo.parse(item.updatedAt ?? DateTime.now());
                  final item =myAppointmentController.appointmentBookingDetails.value.booking;
                  final appointmentId = item?.id;
                  final bookingTime = item?.bookingTime;
                  final serviceType = item?.serviceId;
                  final shopLogo = serviceType?.shopLogo;
                  final serviceImage = serviceType?.servicesImages;
                  final phone = serviceType?.phone;
                  final address = serviceType?.location;
                  final bookingStatus = item?.bookingStatus;
                  final selectedService = item?.selectedService ?? "";
                  final bookingDate = DateFormat(
                    "dd MMMM yyyy",
                  ).format(item?.bookingDate ?? DateTime.now());
                  return MyAppointmentContainer(
                    id: appointmentId ?? "",
                    petLogo: Assets.images.vet.image(width: 24),
                    serviceType: serviceType?.serviceType ?? "",
                    shopLogo: (shopLogo != null && shopLogo.isNotEmpty)
                        ? shopLogo
                        : "",
                    serviceImage: (serviceImage != null &&
                        serviceImage.isNotEmpty) ? serviceImage : "",
                    bookingDate: bookingDate,
                    bookingTime: bookingTime ?? "",
                    bookingStatus: bookingStatus ?? "",
                    selectedService: selectedService,
                    address: address ?? "",
                    phone: phone ?? "",
                    /*         chatOnTab: () {
                          final navController =
                          GetControllers.instance.getNavigationControllerMain();
                          navController.selectedNavIndex.value = 2;
                        },
                        websiteOnTab: () async{
                          String? websiteUrl = serviceType?.websiteLink ?? "";
                          if (websiteUrl.isEmpty) {
                            websiteUrl = "https://www.defaultwebsite.com";
                          }
                          if (!websiteUrl.startsWith('http://') &&
                              !websiteUrl.startsWith('https://')) {
                            websiteUrl = 'https://$websiteUrl';
                          }
                          final Uri url = Uri.parse(websiteUrl);
                          if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                          } else {
                          throw 'Could not launch $url';
                          }
                        },
                        addReviewOnnTab: () {
                          AppRouter.route.pushNamed(RoutePath.reviewScreen);
                          },*/
                    deletedOnTab: () {
                      defaultDeletedYesNoDialog(
                        context: context,
                        title: 'Are you sure you want to Cancel this Appointment?',


                        onYes: () {
                          myAppointmentController.deletedBookingAppointment(
                              id: appointmentId ?? "");
                        },

                      );
                    },


                  );
                }),
              ),
            ),
            SliverGap(16),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: AppStrings.topBrands,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,),

                    // Image Carousel with finite size
                    CarouselSlider(
                      options: CarouselOptions(
                        // Set the height of the carousel
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 8,
                        viewportFraction: 1.0,
                      ),
                      items: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: CustomImage(
                                imageSrc: "assets/images/topbrandsimage.png",
                                fit: BoxFit.cover)),
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: CustomImage(
                                imageSrc: "assets/images/topbrandsimage.png",
                                fit: BoxFit.cover)),
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: CustomImage(
                                imageSrc: "assets/images/topbrandsimage.png",
                                fit: BoxFit.cover)),
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: CustomImage(
                                imageSrc: "assets/images/topbrandsimage.png",
                                fit: BoxFit.cover)),
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: CustomImage(
                                imageSrc: "assets/images/topbrandsimage.png",
                                fit: BoxFit.cover)),

                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverGap(24),


          ],
        ),
      ),
    );
  }


  buildDot(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Obx(() {
        return Container(
          height: 6,
          width: _controller.currentIndex.value == index ? 24 : 6,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _controller.currentIndex.value == index ?
            AppColors.primaryColor : AppColors.lightGray,
          ),
        );
      }),
    );
  }
}
