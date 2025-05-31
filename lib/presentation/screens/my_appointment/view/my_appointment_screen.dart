import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class MyAppointmentScreen extends StatelessWidget {
   MyAppointmentScreen({super.key});
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "My Appointment",),
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: () async {
                myAppointmentController.pagingController.refresh();
              },
              child: PagedListView<int, Widget>(
                pagingController: myAppointmentController.pagingController,
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                builderDelegate: PagedChildBuilderDelegate<Widget>(
                  itemBuilder: (context, item, index) {
                   // final time = GetTimeAgo.parse(item.updatedAt ?? DateTime.now());
                    return   item;
                  },
                  firstPageErrorIndicatorBuilder: (context) => Center(
                    child: ErrorCard(
                      onTap: () => myAppointmentController.pagingController.refresh(),
                      text: myAppointmentController.pagingController.error.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
     /*     SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomImage(imageSrc: "assets/images/vet.png",sizeWidth: 30,),
                            Gap(6),
                            CustomText(text: AppStrings.vets,textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w700,),
                          ],
                        ),

                        CustomImage(imageSrc: "assets/images/petshoplogo.png",sizeWidth: 50,),
                      ],
                    ),
                    Assets.icons.petshopimage.svg(),
                    Gap(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImage(imageSrc: "assets/images/womandogimage.png",),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(child: CustomText(text: "Visiting Date : ", fontWeight: FontWeight.w400)),
                                  Expanded(child: CustomText(text: "25/11/2022", fontWeight: FontWeight.w400)),

                                ],
                              ),
                              Gap(16),
                              CustomButton(onTap: (){

                              },
                                title: "Chat",
                                height: 24,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fillColor: AppColors.whiteColor,
                                textColor: Colors.black,
                                borderColor: Colors.black,

                                borderWidth: 1,
                                isBorder: true,
                                icon: Icon(Icons.chat,color: Colors.black,size: 18,),
                                showIcon: true,
                              ),
                            ],
                          ),
                        ),
                        Gap(6),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Pet Food & Supplies Sales",fontSize: 18,fontWeight: FontWeight.w500,),
                              Gap(4),
                              CustomText(
                                text: "Pet Grooming ",
                                overflow: TextOverflow.ellipsis,

                              ),
                              Gap(4),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber,size: 18,)),
                                  ),
                                  Gap(6),
                                  CustomText(text: "5.0 ",fontWeight: FontWeight.w500, fontSize: 12,)
                                ],
                              ),
                              Gap(4),
                              Row(
                                children: [
                                  Icon(Icons.call,size: 18,),
                                  Expanded(child: CustomText(text: "(406) 555-0120",fontWeight: FontWeight.w400,)),
                                  Icon(Icons.location_on_sharp,size: 18,),
                                  Expanded(child: CustomText(text: "4517 Washington Ave. ",overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                              Gap(4),



                              Row(
                                children: [
                                  Expanded(

                                      child: CustomButton(onTap: (){},title: " Website",height: 24,fontSize: 12,fontWeight: FontWeight.w400,fillColor: AppColors.purple500,textColor: Colors.black,)),
                                  Expanded(

                                      child: TextButton(onPressed: (){}, child: CustomText(text: "Add Review",fontSize: 12,fontWeight: FontWeight.w600,)))
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
