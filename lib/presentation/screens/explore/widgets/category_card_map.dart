import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

    return Container(
      width: 300.w,
      height: 120.h, // Fixed height to prevent overflow
      padding: EdgeInsets.all(12),
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
          // Image Section
          SizedBox(
            width: 70.w, // Fixed width for image column
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                image.isNotEmpty
                    ? CustomNetworkImage(
                  imageUrl: "${ApiUrl.imageBase}$image",
                  fit: BoxFit.cover,
                  boxShape: BoxShape.circle,
                  height: 50.h,
                  width: 50.w,
                )
                    : CustomImage(
                  imageSrc: "assets/images/womandogimage.png",
                  boxFit: BoxFit.cover,
                  height: 50.h,
                  width: 50.w,
                ),
                Gap(4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    color: shop ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: shop ? "Open" : "Closed",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Service Name
                CustomText(
                  text: item.serviceName ?? "Unknown Service",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(2),
                // Service Type
                CustomText(
                  text: item.serviceType ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(6),
                // Location
                Row(
                  children: [
                    Icon(Icons.location_on_sharp, size: 14, color: Colors.blue),
                    Gap(4),
                    Expanded(
                      child: CustomText(
                        text: item.location ?? "No location",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Gap(4),
                // Phone
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: Colors.green),
                    Gap(4),
                    Expanded(
                      child: CustomText(
                        text: item.phone ?? "No phone",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}