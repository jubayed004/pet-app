import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/explore/model/map_category_details_model.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.item});

  final MapCategoryService item;

  @override
  Widget build(BuildContext context) {
    final serviceImage = item.servicesImages ?? "";
    final shop = item.isOpenNow ?? false;
    final image = serviceImage.isNotEmpty ? serviceImage : "";
    final distances = item.distanceKm ?? 0;

    return Container(
      width: 300.w,
padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - Made more responsive
          SizedBox(
            width: 60.w, // Fixed width for image column
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                image.isNotEmpty
                    ? CustomNetworkImage(
                  imageUrl: "${ApiUrl.imageBase}$image",
                  fit: BoxFit.cover,
                  boxShape: BoxShape.circle,
                  height: 45.h, // Slightly reduced
                  width: 45.w,
                )
                    : CustomImage(
                  imageSrc: "assets/images/womandogimage.png",
                  boxFit: BoxFit.cover,
                  height: 45.h, // Slightly reduced
                  width: 45.w,
                ),
                Gap(6.h), // Responsive gap
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: shop ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: shop ? "Open" : "Closed",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp, // Slightly smaller
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w), // Responsive gap
          // Text Section - Made flexible and responsive
          Expanded(
            child: Column(

              spacing: 6.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Important: prevents overflow
              children: [
                // Service Name
                Flexible( // Use Flexible instead of direct CustomText
                  child: CustomText(
                    text: item.serviceName ?? "Unknown Service",
                    fontSize: 15.sp, // Slightly reduced
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),

                // Service Type
                Flexible(
                  child: CustomText(
                    text: item.serviceType ?? "",
                    fontSize: 11.sp, // Slightly reduced
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Location
                Flexible(
                  child: Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: 12.sp, color: Colors.blue), // Responsive icon size
                      Gap(4.w),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: item.location ?? "No location",
                          fontSize: 11.sp, // Slightly reduced
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Phone
                Flexible(
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 12.sp, color: Colors.green), // Responsive icon size
                      Gap(4.w),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: item.phone ?? "No phone",
                          fontSize: 11.sp, // Slightly reduced
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Phone
                Flexible(
                  child: Row(
                    children: [
                      Icon(Iconsax.location, size: 12.sp, color: Colors.green), // Responsive icon size
                      Gap(4.w),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: "${distances.toStringAsFixed(2)} km away from you",
                          fontSize: 11.sp, // Slightly reduced
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}