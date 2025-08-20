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
  BusinessServiceScreen({super.key,});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.icons.animalshelter.svg(),
                  GestureDetector(
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.businessAddServiceScreen,);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: 26,
                          color: const Color(0xff3F5332),
                        ),
                        const Gap(6),
                        const CustomText(
                          text: "Add Service",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3F5332),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16), // spacing before list
                ],
              ),
            ),
            Obx(() {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = businessServiceController.service.value.services ?? [];
                    final serviceImage = item[index].servicesImages ?? "";
                    final serviceLogo = item[index].shopLogo ?? "";
                    final logo = serviceLogo.isNotEmpty ? serviceLogo : "";
                    final image = serviceImage.isNotEmpty ? serviceImage : "";
                    final provider = item[index].providings ?? [];
                    final stringProvider = provider.isNotEmpty ? provider.first : "";
                    final List<String> providerList = stringProvider.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                    print("${ApiUrl.imageBase}$image");
                    return GestureDetector(
                      onTap: () {
                        // Uncomment and use AppRouter to navigate
                        // AppRouter.route.pushNamed(RoutePath.categoryDetailsScreen);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                          left: 16,
                          right: 16,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      image.isNotEmpty
                                          ? CustomNetworkImage(borderRadius: BorderRadius.circular(6,),
                                            height: MediaQuery.of(context,).size.height / 10, width:
                                            MediaQuery.of(context,).size.width, imageUrl: "${ApiUrl.imageBase}${image.replaceAll("\\", "/")}",
                                          )
                                          : CustomImage(imageSrc: "assets/images/womandogimage.png", boxFit: BoxFit.cover,),
                                      Gap(6),
                                      CustomText(
                                        text: "Open",
                                        color: AppColors.primaryColor,
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
                                    spacing: 6.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: item[index].serviceName ?? "",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),

                                      CustomText(
                                        text: item[index].serviceType ?? "",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_sharp,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: item[index].location ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.phone, size: 18),
                                          Expanded(
                                            child: CustomText(
                                              text: item[index].phone ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
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
                            Gap(8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Service Provided :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                ...List.generate(providerList.length, (
                                  subIndex,
                                ) {
                                  return CustomText(
                                    fontSize: 14,
                                    textAlign: TextAlign.start,
                                    maxLines: 5,
                                    text:
                                        "${subIndex + 1}.  ${providerList[subIndex]} ",
                                  );
                                }),
                              ],
                            ),
                            Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.access_time, size: 18),
                                Gap(4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: businessServiceController
                                          .getOpenDaysTextComplete(
                                        offDay: item[index].offDay ?? "",
                                            openingTime: item[index].openingTime ?? "",
                                            closingTime: item[index].closingTime ?? "",
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    CustomText(
                                      text:
                                          "${"Off day -"}${item[index].offDay ?? ""}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        AppRouter.route.pushNamed(RoutePath.businessEditServiceScreen,
                                            extra: {
                                          'id': item[index].id ?? "",
                                          'serviceName': item[index].serviceName ?? "",
                                          'location':item[index].location ?? "",
                                          'websiteLink':item[index].websiteLink ?? "",
                                          'phoneNumber':item[index].phone ?? "",
                                          'serviceController': providerList,
                                            }

                                        );
                                      },
                                      child: Assets.icons.editico.svg(width: 26,),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        defaultDeletedYesNoDialog(
                                          context: context,
                                          title: 'Are you sure you want to delete this Service?',

                                          onYes: () {
                                            businessServiceController.deletedService(id: item[index].id ?? "",);
                                          },

                                        );
                                      },
                                      child: Assets.icons.deletedicon.svg(
                                        width: 36,
                                        colorFilter: ColorFilter.mode(
                                          Colors.red,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Gap(8),
                            if (["SHOP", "HOTEL",].contains(item[index].serviceType))
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: SizedBox()),
                                  Expanded(
                                    child: CustomButton(
                                      onTap: () async {
                                        // Get the website URL
                                        String? websiteUrl = item[index].websiteLink;
                                        // If website URL is null or empty, use a fallback URL
                                        if (websiteUrl == null ||
                                            websiteUrl.isEmpty) {websiteUrl = "https://www.defaultwebsite.com"; // Provide a default URL
                                        }
                                        // Ensure the URL starts with 'http://' or 'https://'
                                        if (!websiteUrl.startsWith('http://') &&
                                            !websiteUrl.startsWith('https://',)) {websiteUrl = 'https://' + websiteUrl; // Prepend 'https://' if not present
                                        }
                                        final Uri url = Uri.parse(websiteUrl,
                                        ); // Convert the string to Uri
                                        // Check if the URL can be launched
                                        if (await canLaunchUrl(url)) {
                                          // Launch the URL if possible
                                          await launchUrl(url);
                                        } else {
                                          // Handle error if the URL can't be launched
                                          throw 'Could not launch $url';
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
                  },
                  childCount: businessServiceController.service.value.services?.length ?? 0, // Set the number of items in your list
                ),
              );
            }),

            /*    PagedSliverList<int, Widget>(

              pagingController: categoryController.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Widget>(

                itemBuilder: (context, item, index) {

                  return item;
                },
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: ErrorCard(
                    onTap: () => categoryController.pagingController.refresh(),
                    text: categoryController.pagingController.error.toString(),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
