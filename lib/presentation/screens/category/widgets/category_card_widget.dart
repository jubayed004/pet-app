import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/star_rating_widget.dart';
import 'package:pet_app/presentation/screens/category/model/category_model.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/route/route_path.dart';
import '../../../../core/route/routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.item, this.showWebsite = false, this.isShop = true});

  final CategoryServiceItem item;
  final bool showWebsite;
  final bool isShop;

  @override
  Widget build(BuildContext context) {
    final id = item.id ?? "";
    final serviceImage = item.servicesImages ?? "";
    final shop = item.isOpenNow ?? false;
    final serviceLogo = item.shopLogo ?? "";
    final logo = serviceLogo.isNotEmpty ? serviceLogo : "";
    final image = serviceImage.isNotEmpty ? serviceImage : "";
    final provider = item.providings ?? [];
    final stringProvider = provider.isNotEmpty ? provider.first : "";
    final List<String> providerList = stringProvider.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    final rating = item.avgRating?.toStringAsFixed(2) ?? "";
    final ratingStar = item.avgRating?.toInt() ?? 0;
    final businessServiceController = GetControllers.instance.getBusinessServiceController();

    print("${ApiUrl.imageBase}${image.replaceAll("\\", "/")}");
    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(RoutePath.categoryDetailsScreen, extra: [showWebsite, id, isShop]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.greenColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      image.isNotEmpty
                          ? CustomNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(12.r),
                          )
                          : CustomImage(imageSrc: "assets/images/womandogimage.png", boxFit: BoxFit.cover),
                      Gap(6),
                      CustomText(
                        text: shop ? "Open" : "Closed",
                        color: shop ? AppColors.primaryColor : Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                ),
                Gap(6),
                Expanded(
                  flex: 2,
                  child: Column(
                    spacing: 6.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: item.serviceName ?? "", fontSize: 18.sp, fontWeight: FontWeight.w500),
                      CustomText(fontSize: 14.sp, fontWeight: FontWeight.w500, text: item.serviceType ?? "", overflow: TextOverflow.ellipsis),
                      ratingStar == 0
                          ? SizedBox()
                          : Row(
                            children: [
                              StarRating(rating: ratingStar, size: 20.sp, filledColor: Colors.amber, borderColor: Colors.amber),
                              Gap(6),
                              CustomText(text: rating, fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ],
                          ),
                      Row(
                        spacing: 6.w,
                        children: [
                          Icon(Icons.location_on_sharp, size: 18.sp),
                          Expanded(child: CustomText(textAlign: TextAlign.start, text: item.location ?? "", overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      Row(
                        spacing: 6,
                        children: [
                          Icon(Icons.phone, size: 18.sp, color: Colors.green),
                          Expanded(child: CustomText(textAlign: TextAlign.start, text: item.phone ?? "", overflow: TextOverflow.ellipsis)),
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
                      imageUrl: logo.replaceAll("\\", "/"),
                    )
                    : CustomImage(imageSrc: "assets/images/petshoplogo.png", sizeWidth: 50),
              ],
            ),
            Gap(8),
            CustomText(text: "Service Provided:", fontSize: 14.sp, fontWeight: FontWeight.w600),
            ...List.generate(providerList.length, (subIndex) {
              return CustomText(fontSize: 14.sp, textAlign: TextAlign.start, maxLines: 5, text: "${subIndex + 1}.  ${providerList[subIndex]} ");
            }),
            Gap(8),
            Row(
              spacing: 8.w,
              children: [
                Icon(Icons.access_time, size: 24.sp),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: businessServiceController.getOpenDaysTextComplete(
                          offDay: item.offDay ?? "",
                          openingTime: item.openingTime ?? "",
                          closingTime: item.closingTime ?? "",
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomText(text: "Off day - ${item.offDay ?? ""}", overflow: TextOverflow.ellipsis),
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
            ),
            Gap(8),
            if (["SHOP", "HOTEL"].contains(item.serviceType))
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        String? websiteUrl = item.websiteLink;
                        if (websiteUrl == null || websiteUrl.isEmpty) {
                          websiteUrl = "https://www.defaultwebsite.com";
                        }
                        if (!websiteUrl.startsWith('http://') && !websiteUrl.startsWith('https://')) {
                          websiteUrl = 'https://$websiteUrl';
                        }
                        final Uri url = Uri.parse(websiteUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      title: "Website",
                      height: 24.h,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      fillColor: AppColors.purple500,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
