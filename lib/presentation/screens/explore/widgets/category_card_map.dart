import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class CategoryCard extends StatelessWidget {

  CategoryCard({
    super.key,
  });

  final categoryController = GetControllers.instance.getCategoryController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final itemList = categoryController.service.value.services ?? [];

      if (itemList.isEmpty) {
        return Center(
          child: CustomText(
            text: "No services available",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        );
      }

      final item = itemList[0];
      final serviceImage = item.servicesImages ?? "";
      final shop = item.isOpenNow ?? false;
      final serviceLogo = item.shopLogo ?? "";
      final logo = serviceLogo.isNotEmpty ? serviceLogo : "";
      final image = serviceImage.isNotEmpty ? serviceImage : "";

      return Container(
        width: 120.w,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  image.isNotEmpty
                      ? Image.network(
                    "${ApiUrl.imageBase}$image",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width,
                  )
                      : CustomImage(
                    imageSrc: "assets/images/womandogimage.png",
                    boxFit: BoxFit.cover,
                  ),
                  Gap(6),
                  CustomText(
                    text: shop ? "Open" : "Closed",
                    color: shop ? AppColors.primaryColor : Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            Gap(6),
            Expanded(
              flex: 2,
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: item.serviceName ?? "",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    text: item.serviceType ?? "",
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 18)),
                      ),
                      Gap(6),
                      CustomText(text: "5.0 ", fontWeight: FontWeight.w500, fontSize: 12),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      Icon(Icons.location_on_sharp, size: 18),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: item.location ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      Icon(Icons.phone, size: 18, color: Colors.green),
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          text: item.phone ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            logo.isNotEmpty
                ? CustomNetworkImage(
              boxShape: BoxShape.circle,
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.height / 10,
              imageUrl: "${ApiUrl.imageBase}${logo.replaceAll("\\", "/")}",
            )
                : CustomImage(
              imageSrc: "assets/images/petshoplogo.png",
              sizeWidth: 50,
            ),
          ],
        ),
      );
    });
  }
}
