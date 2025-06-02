import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class CategoryDetailsScreen extends StatelessWidget {
   CategoryDetailsScreen({super.key});
  final controller = GetControllers.instance.getMyPetsProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
         slivers: [
        /*   CustomDefaultAppbar(
             title: "Category Details ",
           ),*/

           SliverToBoxAdapter(
             child: SizedBox(
               height: 380, // increased from 320 to allow for taller card content
               child: Stack(
                 clipBehavior: Clip.none,
                 children: [
                   // Background Image
                   Obx(() {
                     return controller.selectedImage.value != null
                         ? Image.file(
                       File(controller.selectedImage.value!.path),
                       fit: BoxFit.cover,
                       width: double.infinity,
                       height: 250,
                     )
                         : Image.network(
                       'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                       fit: BoxFit.cover,
                       width: double.infinity,
                       height: 250,
                     );
                   }),
                   Positioned(
                     top: 30,
                       left: 30,
                       child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.black,))),
                   // Card positioned below image, no fixed height, mainAxisSize.min ensures height matches content
                   Positioned(
                     top: 160,
                     left: 30,
                     right: 30,
                     child: Card(
                       elevation: 6,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16, right: 16),
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Text(
                               'PET SHOP',
                               style: TextStyle(fontSize: 16),
                             ),
                             SizedBox(height: 8),
                             CustomText(text: AppStrings.withOver5Years,maxLines: 10,),
                             Gap(16),
                              CustomButton(onTap: (){

                              },title: "Visit Website",
                                textColor: Color(0xFF1E1E1E),
                                height: 30,
                                width: 140,
                                fontWeight: FontWeight.w400,
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

                   // Floating avatar/logo overlapping the card
                   Positioned(
                     top: 100,
                     left: 0,
                     right: 0,
                     child: Center(
                       child: Container(
                         width: 90,
                         height: 90,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black26,
                               blurRadius: 8,
                               offset: Offset(0, 4),
                             ),
                           ],
                         ),
                         child: ClipOval(
                           child: CustomImage(imageSrc: "assets/images/petshoplogo.png", sizeWidth: 90),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
           SliverGap(40),
           SliverToBoxAdapter(
             child: Padding(
               padding: const EdgeInsets.only(left: 16.0,right: 16),
               child: Column(
                 children: [
                   SizedBox(
                     width: MediaQuery.of(context).size.width/2-30,
                     child: Card(
                       elevation: 4,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             CustomText(text: "Rating"),
                             Gap(10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
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
                           ],
                         ),
                       ),
                     ),
                   ),
                   Gap(16),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       CustomText(
                         text: AppStrings.businessType,
                         textAlign: TextAlign.start,
                       ),
                       Expanded(
                         child: CustomText(
                           text: "Pet Vets, Pet Grooming, Pet Shops, Pet Hotels, Pet Training, Friendly Place",
                           maxLines: 4,
                           textAlign: TextAlign.start,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                     ],
                   ),
                   Gap(16),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       CustomText(
                         text: AppStrings.businessAddress,
                         textAlign: TextAlign.start,
                       ),
                       Expanded(
                         child: CustomText(
                           text: "6391 Elgin St. Celina, Delaware",
                           maxLines: 4,
                           textAlign: TextAlign.start,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                     ],
                   ),

                   Gap(16),
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.black,width: 1)
                     ),
                     child: CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",maxLines: 20,textAlign: TextAlign.start,),
                   ),
                   Gap(24),
                   CustomButton(onTap: (){
                     AppRouter.route.pushNamed(RoutePath.serviceScreen);
                   },title: "What service do you want?",textColor: Colors.black,),
                   Gap(24),
                 ],
               ),
             ),
           )
         ],
       ),
    );
  }
}
