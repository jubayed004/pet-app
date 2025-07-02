import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    this.onChat,
    this.onWebsite,
    this.onAddReview,
    this.onApprove,
    this.onReject,
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
  final VoidCallback? onChat;
  final VoidCallback? onWebsite;
  final VoidCallback? onAddReview;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(logoPath, width: 30),
                  const Gap(6),
                  CustomText(
                    text: topTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              Image.asset(logoPath, width: 50),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
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
                    const Gap(4),
                    Row(
                      children: [
                        ...List.generate(5, (i) => Icon(Icons.star, color: i < rating.round() ? Colors.amber : Colors.grey[300], size: 18)),
                        const Gap(6),
                        CustomText(text: "$rating", fontWeight: FontWeight.w500, fontSize: 12),
                      ],
                    ),
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

          /// Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  onTap: (){},
                  title: "Chat Now",
                  height: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fillColor: AppColors.whiteColor,
                  textColor: Colors.black,
                  borderWidth: 1,
                  showIcon: true,
                ),
              ),
              const Gap(6),
              Expanded(
                child: CustomButton(
                  onTap: (){},
                  title: "Website",
                  height: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fillColor: AppColors.purple500,
                  textColor: Colors.black,
                ),
              ),
              const Gap(6),
              Expanded(
                child: TextButton(
                  onPressed: onAddReview,
                  child: const CustomText(
                    text: "Add Review",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const Gap(10),

          /// Approve / Reject Section based on index
          if (index == 0 || index == 1 || index == 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: [
                  if (index == 0 || index == 2)
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
                  if (index == 0) const Gap(12),
                  if (index == 0 || index == 1)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.blueColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: CustomText(
                          text: index == 1 ? "Removed" : "Rejected",
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),

          if (index == 0 || index == 1) const Gap(12),
        ],
      ),
    );
  }
}
