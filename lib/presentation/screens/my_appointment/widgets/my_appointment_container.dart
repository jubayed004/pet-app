import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class MyAppointmentContainer extends StatelessWidget {
  final Widget petLogo;
  final String serviceType;
  final String shopLogo;
  final String serviceImage;
  final String bookingDate;
  final String selectedService;
  final String address;
  final String phone;
  final VoidCallback  chatOnTab;
  final VoidCallback  websiteOnTab;
  final VoidCallback  addReviewOnnTab;

   MyAppointmentContainer({
    super.key,
    required this.petLogo,
    required this.serviceType,
    required this.shopLogo,
    required this.serviceImage,
    required this.bookingDate,
    required this.selectedService,
    required this.address,
    required this.phone,
   required this.chatOnTab,
    required this.websiteOnTab,
    required this.addReviewOnnTab,
  });
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();
  @override
  Widget build(BuildContext context) {
    SvgPicture getIconByName({required String name}) {
      switch (name) {
        case "VET":
          return Assets.icons.petvets.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        case "SHOP":
          return Assets.icons.petshops.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        case "GROOMING":
          return Assets.icons.petgrooming.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        case "HOTEL":
          return Assets.icons.pethotel.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        case "TRAINING":
          return Assets.icons.pettraining.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        case "FRIENDLY":
          return Assets.icons.friendlyplace.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
        default:
          return Assets.icons.friendlyplace.svg(colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn));
      }
    }

    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(RoutePath.myAppointmentDetailsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getIconByName(name: serviceType),
                    Gap(6),
                    CustomText(
                      text: serviceType,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),

                CustomNetworkImage(
                  imageUrl: "${ApiUrl.imageBase}$shopLogo",
                  width: 50,
                  height: 50,
                  boxShape: BoxShape.circle,

                ),
              ],
            ),
            //Assets.icons.petshopimage.svg(),
            Gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    spacing: 6.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomNetworkImage(
                        imageUrl: "${ApiUrl.imageBase}$serviceImage",
                        height: 70,
                        width: 100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Booking Date : ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black, // You can customize the text color here
                              ),
                            ),
                            TextSpan(
                              text: bookingDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black, // You can customize the text color here
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(6),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: selectedService,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(4),
                      CustomText(
                        text: serviceType,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                          ),
                          Gap(6),
                          CustomText(
                            text: "5.0 ",
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Gap(4),
                      Row(
                        children: [
                          Icon(Icons.call, size: 18),
                          Expanded(
                            child: CustomText(
                              text: phone,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Icon(Icons.location_on_sharp, size: 18),
                          Expanded(
                            child: CustomText(
                              text: address,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: chatOnTab,
                    title: "Chat Now",
                    height: 24,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fillColor: AppColors.whiteColor,
                    textColor: Colors.black,
                    //borderColor: Colors.black,
                    borderWidth: 1,
                    //isBorder: true,
                    // icon: Icon(Icons.chat,color: Colors.black,size: 16,),
                    showIcon: true,
                  ),
                ),
                 Expanded(
                  child: CustomButton(
                    onTap: websiteOnTab,
                    title: " Website",
                    height: 24,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fillColor: AppColors.purple500,
                    textColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: addReviewOnnTab,
                    child: CustomText(
                      text: "Add Review",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              height: 40,
              onTap: (){},title: "PENDING",
            )
          ],
        ),
      ),
    );
  }
}
