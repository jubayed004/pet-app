import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/details_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/health_card.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessPetsDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessPetsDetailsScreen({super.key, required this.id});

  @override
  State<BusinessPetsDetailsScreen> createState() =>
      _BusinessPetsDetailsScreenState();
}

class _BusinessPetsDetailsScreenState extends State<BusinessPetsDetailsScreen> {
  final controller = GetControllers.instance.getMyPetsProfileController();

  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();

  @override
  void initState() {
    businessAllPetController.businessPetDetails(id: widget.id);
    businessAllPetController.getHealthHistoryUpdate(id: widget.id, status: '', page: 1);
    businessAllPetController.pagingController.refresh();
    businessAllPetController.pagingController.addPageRequestListener((pageKey) {
      businessAllPetController.getHealthHistoryUpdate(id: widget.id, status: 'COMPLETED', page: pageKey);
    });
    businessAllPetController.pagingController1.refresh();
    businessAllPetController.pagingController1.addPageRequestListener((pageKey) {
      businessAllPetController.getHealthHistoryUpdate1(id: widget.id, status: 'PENDING', page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: RefreshIndicator(
        onRefresh: () async{
          businessAllPetController.pagingController.refresh();
          businessAllPetController.pagingController1.refresh();
        },
        child: CustomScrollView(
          slivers: [
            Obx(() {
              return CustomDefaultAppbar(
                title: businessAllPetController.details.value.pet?.name ?? "",
              );
            }),
            SliverToBoxAdapter(
              child: Obx(() {
                final pet = businessAllPetController.details.value.pet?.petPhoto;
                final image =
                    pet != null && pet.isNotEmpty ? pet.first ?? "" : "";
                return image.isNotEmpty
                    ? Image.network(ApiUrl.imageBase + image,height: 100,)
                    : Image.network(
                      'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    );
              }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return CustomText(
                                    text:
                                        businessAllPetController
                                            .details
                                            .value
                                            .pet
                                            ?.name ??
                                        "",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  );
                                }),
                                Gap(6),
                                CustomText(
                                  text:
                                      businessAllPetController
                                          .details
                                          .value
                                          .pet
                                          ?.gender ??
                                      "",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purple500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(8),
                    Row(
                      children: [
                        Icon(Icons.account_box_outlined),
                        Gap(6),
                        Obx(() {
                          return CustomText(
                            text:
                                "About ${businessAllPetController.details.value.pet?.name ?? ""}",
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
                        final pet = businessAllPetController.details.value.pet;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            DetailsCard(
                              age: "Age",
                              date: pet?.age.toString() ?? "",
                            ),
                            DetailsCard(age: "Gender", date: pet?.gender ?? ""),
                            DetailsCard(
                              age: "Height",
                              date: pet?.height.toString() ?? "",
                            ),
                            DetailsCard(
                              age: "Weight",
                              date: pet?.weight.toString() ?? "",
                            ),
                            DetailsCard(age: "Color", date: pet?.color ?? ""),
                            DetailsCard(age: "Breed", date: pet?.breed ?? ""),
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
                              "${businessAllPetController.details.value.pet?.name ?? ""} ’s Status",
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
                              radius: 24,
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
                        GestureDetector(
                          onTap: () {
                            showAddHealthDialog(context,widget.id); // 👈 Show the dialog
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFE54D4D),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CustomText(
                                  text: "Add Health Update ",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: padding14H,
                child: Text(
                  "Past vaccinations",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
            SliverGap(16),
            SliverPadding(
              padding:padding14H,
              sliver: PagedSliverGrid<int, PetMedicalHistoryByTreatmentStatus>(
                  pagingController: businessAllPetController.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PetMedicalHistoryByTreatmentStatus>(
                    itemBuilder: (_, item, _){
                      return HealthCard(
                        title: item.treatmentName ?? "",
                        dateOfMonth: DateFormat("dd MMMM yyyy").format(item.treatmentDate ?? DateTime.now()),
                        drName: item.doctorName?? "",
                        status: item.treatmentStatus?? "",
                        statusColor: Colors.green, id: item.id ?? "",
                      );
                    }
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 2,
                    crossAxisCount: 2,
                    mainAxisExtent: 140,
                  ),
              )
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: padding16H,
                child: Text(
                  "Next vaccinations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverGap(16),
            SliverPadding(
                padding:padding14H,
                sliver: PagedSliverGrid<int, PetMedicalHistoryByTreatmentStatus>(
                  pagingController: businessAllPetController.pagingController1,
                  builderDelegate: PagedChildBuilderDelegate<PetMedicalHistoryByTreatmentStatus>(
                      itemBuilder: (_, item, _){
                        return HealthCard(
                          title: item.treatmentName ?? "",
                          dateOfMonth: DateFormat("dd MMMM yyyy").format(item.treatmentDate ?? DateTime.now()),
                          drName: item.doctorName?? "",
                          status: item.treatmentStatus?? "",
                          statusColor: Colors.cyan, id: item.id ?? "",
                        );
                      }
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 140,
                  ),
                )
            ),/*
            SliverPadding(
              padding:padding14H,
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => HealthCard(
                    title: 'Rabies vaccination',
                    dateOfMonth: 'Mon 24 Jan',
                    drName: 'Dr. Green',
                    status: 'PENDING',
                    statusColor: AppColors.purple500,
                  ),
                  childCount: 5,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 140,
                ),
              ),
            ),*/
        
            /*      SliverToBoxAdapter(
              child:      Container(
                margin: paddingH16V8,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.purple500)
                ),
                child:CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ",fontSize: 16,fontWeight: FontWeight.w400,maxLines: 6,textAlign: TextAlign.start,),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
