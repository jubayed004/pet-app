import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';

class CustomBookingCard extends StatelessWidget {
  const CustomBookingCard({
    super.key,
    required this.index,
    required this.logoPath,
    required this.topTitle,
    required this.imagePath,
    required this.visitingDate,
    required this.mainTitle,
    required this.subTitle,
    required this.rating,
    required this.phoneNumber,
    required this.address,
    this.onApprove,
    this.onReject,
    this.onComplete = false,
    this.onRejected = false,
    this.showApproveButton = false,
    this.showRejectButton = false,
  });

  final int index;
  final String logoPath;
  final String topTitle;
  final String imagePath;
  final String visitingDate;
  final String mainTitle;
  final String subTitle;
  final double rating;
  final String phoneNumber;
  final String address;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final bool onComplete;
  final bool onRejected;
  final bool showApproveButton;
  final bool showRejectButton;

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          /// Logo & Top Title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  getIconByName(name: logoPath),
                  const Gap(6),
                  CustomText(
                    text: topTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),

            ],
          ),

          const Gap(6),

          /// Main Content
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      imageUrl: imagePath,
                      height: 70.h,
                      width: 100.w,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const Gap(6),
                    Row(
                      children: [
                        const Expanded(child: CustomText(text: "Visiting Date:", fontWeight: FontWeight.w400)),
                        Expanded(child: CustomText(text: visitingDate, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(6),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: mainTitle, fontSize: 18, fontWeight: FontWeight.w500),
                    const Gap(4),
                    CustomText(text: subTitle, overflow: TextOverflow.ellipsis),
             /*       const Gap(4),
                    Row(
                      children: [
                        ...List.generate(5, (i) => Icon(Icons.star, color: i < rating.round() ? Colors.amber : Colors.grey[300], size: 18)),
                        const Gap(6),
                        CustomText(text: "$rating", fontWeight: FontWeight.w500, fontSize: 12),
                      ],
                    ),*/
                    const Gap(4),
                    Row(
                      children: [
                        const Icon(Icons.call, size: 18),
                        Expanded(child: CustomText(text: phoneNumber, textAlign: TextAlign.start)),
                        const Icon(Icons.location_on, size: 18),
                        Expanded(child: CustomText(text: address, textAlign: TextAlign.start)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(10),

          /// Approve / Reject Section
          if (index == 0 || index == 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                spacing: 12,
                children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onApprove,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const CustomText(text: "Approve", color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.blueColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: CustomText(
                          text: "rejected",
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          const Gap(10),
        ],
      ),
    );
  }
}
