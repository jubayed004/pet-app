import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessShopProfileScreen extends StatelessWidget {
  BusinessShopProfileScreen({super.key});

  final shopProfileController = GetControllers.instance.getBusinessShopProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await shopProfileController.getBusinessShopProfile();
        },
        child: CustomScrollView(
          slivers: [
            const CustomDefaultAppbar(title: "Business Profile"),

            /// ---------- Main Profile Section ----------
            SliverToBoxAdapter(
              child: Obx(() {
                final businesses = shopProfileController.shopProfile.value.business ?? [];

                if (businesses.isEmpty) {
                  return const Center(child: Padding(padding: EdgeInsets.only(top: 80), child: CircularProgressIndicator()));
                }

                final business = businesses.first; // Display first one

                final shopPic =
                    business.shopPic?.isNotEmpty == true
                        ? business.shopPic!.first
                        : 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80';

                final shopLogo = business.shopLogo ?? 'https://via.placeholder.com/150x150.png?text=Pet+Shop';

                return Column(
                  children: [
                    SizedBox(
                      height: 380,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          /// Background Image
                          CustomNetworkImage(imageUrl: shopPic, width: double.infinity, height: 250),

                          /// Card
                          Positioned(
                            top: 200,
                            left: 24,
                            right: 24,
                            child: Card(
                              color: AppColors.kWhiteColor,
                              elevation: 6,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: business.businessName ?? "Unknown Business",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                    ),
                                    const Gap(8),
                                    CustomText(text: business.address ?? "", fontSize: 14.sp, color: Colors.grey[600], textAlign: TextAlign.center),
                                    const Gap(16),

                                    /// Visit Website Button
                                    CustomButton(
                                      onTap: () async {
                                        String websiteUrl = business.website ?? "";

                                        if (websiteUrl.isEmpty) {
                                          websiteUrl = "https://www.defaultwebsite.com";
                                        }

                                        if (!websiteUrl.startsWith('http')) {
                                          websiteUrl = 'https://$websiteUrl';
                                        }

                                        final Uri url = Uri.parse(websiteUrl);

                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        } else {
                                          Get.snackbar("Error", "Could not launch website", backgroundColor: Colors.redAccent.shade100);
                                        }
                                      },
                                      title: "Visit Website",
                                      textColor: Colors.black,
                                      height: 40,
                                      width: 150,
                                      fontWeight: FontWeight.w500,
                                      fillColor: Colors.white,
                                      borderColor: Colors.black,
                                      borderWidth: 1,
                                      isBorder: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          /// Floating Shop Logo
                          Positioned(
                            top: 150,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4))],
                                ),
                                child: ClipOval(child: CustomNetworkImage(imageUrl: shopLogo)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(20),

                    /// ---------- Business Details ----------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          _buildRow(
                            title: AppStrings.businessType,
                            contentWidget: Wrap(
                              children: List.generate((business.servicesType ?? []).length, (index) {
                                final text = business.servicesType![index] ?? '';
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: CustomText(text: text + (index != business.servicesType!.length - 1 ? ',' : ''), fontSize: 14),
                                );
                              }),
                            ),
                          ),
                          const Gap(16),
                          _buildRow(title: AppStrings.businessAddress, content: business.address ?? "Not Available"),
                          const Gap(16),
                       /*   _buildRow(
                            title: "More Info",
                            content: business.moreInfo?.isNotEmpty == true ? business.moreInfo! : "No additional info available",
                          ),*/
                          const Gap(24),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Row Builder
  Widget _buildRow({required String title, String? content, Widget? contentWidget}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: CustomText(text: title, fontWeight: FontWeight.w600, color: Colors.black87)),
        Expanded(
          flex: 4,
          child: contentWidget ?? CustomText(text: content ?? "", maxLines: 4, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
