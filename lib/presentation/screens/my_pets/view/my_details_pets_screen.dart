import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/details_card.dart';
import 'package:pet_app/presentation/screens/my_pets/widgets/health_history_section.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class MyDetailsPetsScreen extends StatefulWidget {
  final String id;

  const MyDetailsPetsScreen({super.key, required this.id});

  @override
  State<MyDetailsPetsScreen> createState() => _MyDetailsPetsScreenState();
}

class _MyDetailsPetsScreenState extends State<MyDetailsPetsScreen> {
  final controller = GetControllers.instance.getMyPetsProfileController();

  @override
  void initState() {
    controller.myAllPetDetails(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.myAllPetDetails(id: widget.id);
        },
        child: CustomScrollView(
          slivers: [
            Obx(() {
              return CustomDefaultAppbar(
                title: controller.details.value.pet?.name ?? "",
              );
            }),
            SliverToBoxAdapter(
              child: Obx(() {
                final pet = controller.details.value.pet?.petPhoto;
                final image = pet != null && pet.isNotEmpty ? pet  : "";
                return image.isNotEmpty
                    ? Image.network(ApiUrl.imageBase + image,fit: BoxFit.cover,width: double.infinity, height: 200,)
                    : Image.network(
                  'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20,),
                child: Column(
                  children: [
                    Obx(() {
                      final profileDetails =controller.details.value.pet;
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8,),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text:
                                            profileDetails?.name ?? "",
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          Gap(6),
                                          CustomText(
                                            text:
                                            profileDetails?.gender ?? "",
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.purple500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              IconButton(
                                onPressed: () {
                                  AppRouter.route.pushNamed(
                                    RoutePath.editMyPetsScreen,
                                    extra: {
                                      "id" : profileDetails?.id ?? "",
                                      "name" : profileDetails?.name ?? "",
                                      "animalType" : profileDetails?.animalType ?? "",
                                      "breed" : profileDetails?.breed ?? "",
                                      "age" : profileDetails?.age.toString() ?? "",
                                      "gender" : profileDetails?.gender ?? "",
                                      "weight" : profileDetails?.weight.toString() ?? "",
                                      "height" : profileDetails?.height.toString() ?? "",
                                      "color" : profileDetails?.color ?? "",

                                    },
                                  );
                                },
                                icon: Icon(Iconsax.edit),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Gap(8),
                    Row(
                      children: [
                        Icon(Icons.account_box_outlined),
                        Gap(6),
                        Obx(() {
                          return CustomText(
                            text:
                            "About ${controller.details.value.pet?.name ?? ""}",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          );
                        }),
                      ],
                    ),
                    Gap(16),
                    SizedBox(
                      height: 80, // fixed height for the list items
                      child: Obx(() {
                        final pet = controller.details.value.pet;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            DetailsCard(
                              title: "Age",
                              details: pet?.age.toString() ?? "",
                            ),
                            DetailsCard(
                              title: "Pet Type",
                              details: pet?.animalType ?? "",
                            ),
                            DetailsCard(
                              title: "Gender",
                              details: pet?.gender ?? "",
                            ),
                            DetailsCard(
                              title: "Height",
                              details: pet?.height.toString() ?? "",
                            ),
                            DetailsCard(
                              title: "Weight",
                              details: pet?.weight.toString() ?? "",
                            ),
                            DetailsCard(
                              title: "Color",
                              details: pet?.color ?? "",
                            ),
                            DetailsCard(
                              title: "Breed",
                              details: pet?.breed ?? "",
                            ),
                          ],
                        );
                      }),
                    ),
                    Gap(16),
                    Row(
                      children: [
                        Icon(Icons.safety_divider_outlined),
                        Gap(6),
                        CustomText(
                          text:
                          "${controller.details.value.pet?.name ??
                              ""} ’s Status",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    Gap(16),
                    Divider(height: 1, color: Colors.grey),
                    Gap(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFE54D4D),
                              child: Icon(
                                Icons.health_and_safety,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            Gap(6),
                            CustomText(
                              text: "Health",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        TextButton(onPressed: (){ AppRouter.route.pushNamed(RoutePath.petHealthScreen,extra: widget.id);
                          },
                            child: CustomText(text: "See All",fontWeight: FontWeight.w400,fontSize: 14,))
                      ],
                    ),
                    Gap(16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        text: "Health History",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Gap(8),
              Container(
                margin: EdgeInsets.all(12.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Treatment Name
                    Text(
                      "Treatment Name: Rabies vaccination",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(4.h),

                    /// Doctor Name
                    Text(
                      "Doctor Name: Jane Cooper",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(4.h),

                    /// Treatment Date
                    Text(
                      "Treatment Date: Fri 28 Sep25/ at 11:30 am -12:00pm",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(4.h),

                    /// Location Row
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 18),
                        Gap(4.w),
                        Expanded(
                          child: Text(
                            "Oldesloer Strasse 82",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(8.h),

                    /// Treatment Description Title
                    Text(
                      "Treatment Description",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    Gap(6.h),

                    /// Description Box
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.green.withOpacity(0.4)),
                      ),
                      child: Text(
                        "My Pet offers safe and reliable treatment services to keep your pet healthy. "
                            "We provide health check-ups, vaccinations, and basic care for common issues. "
                            "Every treatment is designed with love and care for your furry friend.",
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Gap(10.h),

                    /// Completed Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.green.shade700,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

                    /*  CustomAlignText(text: "More Info",fontWeight: FontWeight.w600,fontSize: 14,),
                   Gap(8),*/
                    /*      Container(
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(color: AppColors.purple500)),
                     child:CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ",fontSize: 16,fontWeight: FontWeight.w400,maxLines: 6,textAlign: TextAlign.start,),
                   )*/
                  ],
                ),
              ),
            ),
            /*         SliverList(
             delegate: SliverChildBuilderDelegate(
                   (context, index) => ListTile(
                 title: Text('Item #$index'),
               ),
               childCount: 20,
             ),
           ),*/
          ],
        ),
      ),
    );
  }
}
