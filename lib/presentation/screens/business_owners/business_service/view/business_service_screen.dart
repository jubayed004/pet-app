import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessServiceScreen extends StatelessWidget {
  BusinessServiceScreen({super.key});

  final businessServiceController = GetControllers.instance.getBusinessServiceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          businessServiceController.getBusinessService();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            CustomDefaultAppbar(title: "Services"),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.icons.animalshelter.svg(),
                  GestureDetector(
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.businessAddServiceScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 26, color: const Color(0xff3F5332)),
                        const Gap(6),
                        const CustomText(text: "Add Service", fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff3F5332)),
                      ],
                    ),
                  ),
                  const Gap(16),
                ],
              ),
            ),
            Obx(() {
              final services = businessServiceController.service.value.services ?? [];
              if (services.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.animalshelter.svg(width: 120),
                        const SizedBox(height: 20),
                        const CustomText(text: "No Services Added Yet!", fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        const CustomText(
                          text: "Start by tapping the + icon above to add your first service and let your customers find you easily.",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = services[index];
                  final serviceImage = item.servicesImages ?? "";
                  final serviceLogo = item.shopLogo ?? "";
                  final logo = serviceLogo.isNotEmpty ? serviceLogo : "";
                  final image = serviceImage.isNotEmpty ? serviceImage : "";
                  final provider = item.providings ?? [];
                  final stringProvider = provider.isNotEmpty ? provider.first : "";
                  final List<String> providerList = stringProvider.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2.r, blurRadius: 5, offset: const Offset(0, 3))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(6),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    image.isNotEmpty
                                        ? CustomNetworkImage(
                                          borderRadius: BorderRadius.circular(6),
                                          height: MediaQuery.of(context).size.height / 10,
                                          width: MediaQuery.of(context).size.width,
                                          imageUrl: image.replaceAll("\\", "/"),
                                        )
                                        : const CustomImage(imageSrc: "assets/images/womandogimage.png", boxFit: BoxFit.cover),
                                    Gap(6),
                                    CustomText(text: "Open", color: AppColors.primaryColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                  ],
                                ),
                              ),
                              Gap(6),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: item.serviceName ?? "", fontSize: 18.sp, fontWeight: FontWeight.w500),
                                    CustomText(text: item.serviceType ?? "", overflow: TextOverflow.ellipsis),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_sharp, size: 18.sp),
                                        Expanded(
                                          child: CustomText(text: item.location ?? "", overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.phone, size: 18.sp),
                                        Expanded(
                                          child: CustomText(text: item.phone ?? "", overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
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
                                    imageUrl: logo.replaceAll("\\", "/"),
                                  )
                                  : CustomImage(imageSrc: "assets/images/petshoplogo.png", sizeWidth: 50.w),
                            ],
                          ),
                          Gap(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Service Provided :", fontSize: 14.sp, fontWeight: FontWeight.w600),
                              ...List.generate(providerList.length, (subIndex) {
                                return CustomText(
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.start,
                                  maxLines: 5,
                                  text: "${subIndex + 1}.  ${providerList[subIndex]} ",
                                );
                              }),
                            ],
                          ),
                          Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.access_time, size: 24.sp),
                              Flexible(
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
                              Row(
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
                                      width: 36.w,
                                      colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gap(8),
                          if (["SHOP", "HOTEL"].contains(item.serviceType))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: SizedBox()),
                                Expanded(
                                  child: CustomButton(
                                    onTap: () async {
                                      String? websiteUrl = item.websiteLink;
                                      if (websiteUrl == null || websiteUrl.isEmpty) {
                                        websiteUrl = "https://www.defaultwebsite.com";
                                      }
                                      if (!websiteUrl.startsWith('http')) {
                                        websiteUrl = 'https://$websiteUrl';
                                      }
                                      final Uri url = Uri.parse(websiteUrl);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    title: "Website",
                                    height: 24,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fillColor: AppColors.purple500,
                                    textColor: Colors.black,
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                }, childCount: services.length),
              );
            }),
          ],
        ),
      ),
    );
  }
}
