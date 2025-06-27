import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/helper/date_converter/date_converter.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class DashboardStoreCard extends StatelessWidget {
  const DashboardStoreCard({
    super.key,
    required this.index,
    required this.item,
    this.onApprove,
    this.onReject,
  });

  final int index;
  final Widget item;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFE9EFFD),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and category label
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                      child: CustomNetworkImage(
                        imageUrl: /*item.placeType?.categoryImage ??*/ "",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9e6d3e),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CustomText(text: /*item.placeType?.name ??*/ ""),
                    ),
                  ),
                ],
              ),
            ),

            // Name & address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: /*item.name ?? */"dgadg",
                    fontSize: 20,
                    color: AppColors.blackColor,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Assets.icons.logouticon.svg(),
                      const Gap(5),
                      Flexible(
                        child: CustomText(
                          text: /*item.address ?? */"dgdasg",
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomText(
                text: "${"date"} : ${DateConverter.formatDate(/*item.updatedAt ??*/ DateTime.now(), format: 'MMM dd, yyyy hh:mm a')}",
                color: AppColors.blackColor,
              ),
            ),

            const Gap(12),

            // Buttons depending on tab index
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  if (index == 0 || index == 2)
                    Expanded(
                      child: GestureDetector(
                        onTap: onApprove,
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: CustomText(text: "approve", color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  if (index == 0) const Gap(12),
                  if (index == 0 || index == 1)
                    Expanded(
                      child: GestureDetector(
                        onTap: onReject,
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blueColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: CustomText(
                            text: index == 1 ? "removed" : "rejected",
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Gap(12),
          ],
        ),
      ),
    );
  }
}
