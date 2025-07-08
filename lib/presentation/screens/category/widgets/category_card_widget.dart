import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/route/route_path.dart';
import '../../../../core/route/routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/padding_constant.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(RoutePath.categoryDetailsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: padding8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            /*    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
            */
            /*    Row(
                  children: [
                */
            /**/
            /*    CustomImage(imageSrc: "assets/images/vet.png",sizeWidth: 30,),*/
            /**/
            /*
                    Gap(6),
                    CustomText(text: AppStrings.vets,textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w700,),
                  ],
                ),*/
            /*


              ],
            ),*/
            //Assets.icons.petshopimage.svg(),
            Gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImage(
                        imageSrc: "assets/images/womandogimage.png",
                        boxFit: BoxFit.cover,
                      ),
                      Gap(8),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Sansal  Land",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(4),
                      CustomText(
                        text: "Pet Grooming ",
                        overflow: TextOverflow.ellipsis,
                      ),

                      Gap(4),
                      Row(
                        children: [
                          Icon(Icons.location_on_sharp, size: 18),
                          Expanded(
                            child: CustomText(
                              text: "4517 Washington Ave. ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),

                      Gap(4),
                    ],
                  ),
                ),
                CustomImage(
                  imageSrc: "assets/images/petshoplogo.png",
                  sizeWidth: 50,
                ),
              ],
            ),
            Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 18),
                Gap(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Monday - Friday at 8.00 am - 5.00pm',
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomText(
                        text: 'Off day -Sunday',
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                /*   ListTile(
                            leading: Icon(Icons.access_time_sharp),
                            title: CustomText(text: 'Monday - Friday at 8.00 am - 5.00pm'),
                            subtitle:CustomText(text: '  Off day -Sunday'),
                          )*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*      Expanded(
                  child: CustomButton(onTap: (){},
                    title: "Chat Now",
                    height: 24,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fillColor: AppColors.whiteColor,
                    textColor: Colors.black,
                    //borderColor: Colors.black,
                    borderWidth: 1,
                    //isBorder: true,
                    // icon: Icon(Icons.chat,color: Colors.black,size: 16,),
                    showIcon: true,
                  ),
                ),*/
                Expanded(child: SizedBox()),
                Expanded(
                  child: CustomButton(
                    onTap: () {},
                    title: " Website",
                    height: 24,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fillColor: AppColors.purple500,
                    textColor: Colors.black,
                  ),
                ),
                Expanded(child: SizedBox()),
                /*
Expanded(

                    child: TextButton(onPressed: (){}, child: CustomText(text: "Add Review",fontSize: 12,fontWeight: FontWeight.w600,))),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
