import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/components/custom_text_field/custom_text_field.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = GetControllers.instance.getHomeController();
  final controller = GetControllers.instance.getProfileController();
  final _controller = GetControllers.instance.getOnboardingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            pinned: false,
            backgroundColor: AppColors.appBackgroundColor,
            elevation: 0,
            toolbarHeight: 56,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 16, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Obx(
                                  () =>
                              controller.loading.value == Status.completed
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CustomNetworkImage(
                                  imageUrl:
                                  /* controller.profile.value.data?.profileImage ??*/
                                  "",
                                ),
                              )
                                  : Shimmer.fromColors(
                                baseColor: AppColors.whiteColor
                                    .withAlpha(50),
                                highlightColor: AppColors.whiteColor
                                    .withAlpha(100),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: CustomTextField(
                            onTap: () {},
                            hintText: AppStrings.searchForServices,
                            fillColor: AppColors.whiteColor,
                            fieldBorderColor: AppColors.purple500,
                            keyboardType: TextInputType.none,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: badges.Badge(
                            badgeContent: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: AppColors.purple500,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              elevation: 2,
                            ),
                            position: badges.BadgePosition.topStart(
                              start: 10,
                              top: -20,
                            ),
                            child: const Icon(
                              CupertinoIcons.bell,
                              size: 24,
                              color: AppColors.purple500,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(AppStrings.activePetProfiles, style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                      Gap(4),
                      CircleAvatar(
                        radius: 10,
                        child: CustomText(text: "1",
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,),
                      ),

                    ],
                  ),
                  Gap(16),
                  Obx(() {
                    return Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: _controller.onboardingList[_controller
                                    .currentIndex.value]
                                    .title,),
                              CustomText(
                                text: _controller.onboardingList[_controller
                                    .currentIndex
                                    .value]
                                    .details,)
                            ],
                          ),
                          CustomImage(
                            imageSrc: "assets/images/petkalloimage.png",
                            sizeWidth: 100,)
                        ],
                      ),
                    );
                  }),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3, (index) => buildDot(index, context)),
                  ),
                ],
              ),
            ),
          ),
          SliverGap(8),
          SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: CustomText(text: AppStrings.findWhatYouNeed,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,)),
          ),
          SliverGap(8),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                padding: EdgeInsets.only(left: 16, right: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.selectedIndex.value = index;
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 3,
                            child: Obx(() {
                              bool isSelected = homeController.selectedIndex.value == index;
                              return CircleAvatar(
                                backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
                                radius: 40,
                                child: iconList[index],
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 4),
                        CustomText(text: stringList[index],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  children: [
                    CustomImage(imageSrc: "assets/images/adshome.png"),
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   CustomText(text: AppStrings.upcomingAppointments,fontWeight: FontWeight.w400,fontSize: 18,),
                  TextButton(onPressed: (){}, child:   CustomText(text: AppStrings.seeAll,fontWeight: FontWeight.w400,fontSize: 14,))
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImage(imageSrc: "assets/images/womandogimage.png",),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                CustomText(text: AppStrings.lastVisit, fontWeight: FontWeight.w400),
                                CustomText(text: "25/11/2022", fontWeight: FontWeight.w400),
                              ],
                            ),
                          ],
                        ),
                        Gap(6),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Dr.Jubayed Islam ",fontSize: 18,fontWeight: FontWeight.w500,),
                              Gap(4),
                              CustomText(
                                text: "Bachelor of veterinary science ",
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
                                  Expanded(child: CustomText(text: "5.0 {100 reviews}",fontWeight: FontWeight.w500, fontSize: 12,))
                                ],
                              ),
                              Gap(4),
                              Row(
                                children: [
                                  Icon(Icons.call,size: 18,),
                                  Expanded(child: CustomText(text: "(406) 555-0120",fontWeight: FontWeight.w400,)),
                                  Icon(Icons.location_on_sharp,size: 18,),
                                  Expanded(child: CustomText(text: "4517 Washington Ave.{2.5 km} ",overflow: TextOverflow.ellipsis,))
                                ],
                              ),
                             Gap(4),
                              Row(
                                children: [
                                  Expanded(child: CustomButton(onTap: (){},title: "Bella",height: 20,fontSize: 14,fontWeight: FontWeight.w400,fillColor: AppColors.whiteColor,textColor: Colors.black,borderColor: Colors.black,borderRadius: 30,borderWidth: 1,isBorder: true,)),
                                  Gap(4),
                                  Expanded(child: CustomButton(onTap: (){},title: "Chat",height: 20,fontSize: 14,fontWeight: FontWeight.w400,fillColor: AppColors.whiteColor,textColor: Colors.black,borderColor: Colors.black,borderRadius: 30,borderWidth: 1,isBorder: true,)),

                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(

                                      child: CustomButton(onTap: (){},title: " Website",height: 20,fontSize: 14,fontWeight: FontWeight.w400,fillColor: AppColors.purple500,)),
                                  Expanded(

                                      child: TextButton(onPressed: (){}, child: CustomText(text: "Add Review")))
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
          ),
          SliverGap(16),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: AppStrings.topBrands,fontWeight: FontWeight.w400,fontSize: 18,)
                ],
              ),
            ),
          ),
          SliverGap(24),


        ],
      ),
    );
  }

  final List<Widget> iconList = [
    Assets.icons.petvets.svg(),
    Assets.icons.petshops.svg(),
    Assets.icons.petgrooming.svg(),
    Assets.icons.pethotel.svg(),
    Assets.icons.pettraining.svg(),
    Assets.icons.friendlyplace.svg(),

  ];
  final List<String> stringList = [
    AppStrings.petVets,
    AppStrings.petShops,
    AppStrings.petGrooming,
    AppStrings.petHotels,
    AppStrings.petTraining,
    AppStrings.friendlyPlace,


  ];

  buildDot(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Obx(() {
        return Container(
          height: 6,
          width: _controller.currentIndex.value == index ? 24 : 6,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _controller.currentIndex.value == index ?
            AppColors.primaryColor : AppColors.lightGray,
          ),
        );
      }),
    );
  }
}
