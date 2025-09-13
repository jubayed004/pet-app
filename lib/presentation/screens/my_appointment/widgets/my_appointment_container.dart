import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class MyAppointmentContainer extends StatelessWidget {
  final String id;
  final Widget petLogo;
  final String serviceType;
  final String shopLogo;
  final String serviceImage;
  final String bookingDate;
  final String bookingTime;
  final String selectedService;
  final String address;
  final String phone;
  final String bookingStatus;
  final VoidCallback  deletedOnTab;


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
     required this.deletedOnTab,
     required this.id,
     required this.bookingTime,
     required this.bookingStatus,


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
        AppRouter.route.pushNamed(RoutePath.myAppointmentDetailsScreen,extra: id);
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
          spacing: 12,
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
                if(["PENDING", "COMPLETED","CANCELLED"].contains(bookingStatus))Container(
                  padding: padding8,
                  decoration: BoxDecoration(
                    color: bookingStatus == "PENDING" ? Color(0xffE0F2FE) :  Color(0xffDCFCE7),
                   borderRadius: BorderRadius.circular(10)
                  ),
                  child: CustomText(text: bookingStatus,fontWeight: FontWeight.w500,fontSize: 12,color:bookingStatus == "COMPLETED" ? Color(0xff22C55E) :Color(0xff0EA5E9),),
                )
              ],
            ),

            Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 6.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      imageUrl: "${ApiUrl.imageBase}$serviceImage",
                      height: 70.h,
                      width: 100.w,
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ],
                ),
                Gap(6),
                Expanded(
                  flex: 2,
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: serviceType,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: selectedService,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),

         /*             Gap(4),
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
                      ),*/

                      Row(
                        spacing: 6,
                        children: [
                          Icon(Icons.call, size: 18),
                          CustomText(
                            text: phone,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
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
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Booking Date : ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: bookingDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Booking Time : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: bookingTime,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: (){
                      AppRouter.route.pushNamed(RoutePath.myAppointmentDetailsScreen,extra: id);
                    },
                    child: CustomText(text: "View Details",fontSize: 12,fontWeight: FontWeight.w400,)
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(
                      BorderSide(color: Colors.red, width: 1), // Set the border color here
                    ),
                  ),
                  onPressed: deletedOnTab,
                  child: CustomText(
                    text: "Cancel",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                )

                /* IconButton(onPressed: deletedOnTab, icon: Icon(Iconsax.trush_square,color: Colors.red,size: 28,)),*/
              ],
            )
          ],
        ),
      ),
    );
  }
}
