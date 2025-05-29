import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/my_pets/widgets/health_history_section.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';

class MyPetsScreen extends StatelessWidget {
   MyPetsScreen({super.key});
   final controller = GetControllers.instance.getMyPetsProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       slivers: [
         SliverAppBar(
           pinned: true,
           expandedHeight: 200,
           centerTitle: true,
           title: CustomText(text: 'My Pet',fontWeight: FontWeight.w600,fontSize: 24,color: Colors.white,),
           flexibleSpace: FlexibleSpaceBar(
             background: Obx(() {
               return controller.selectedImage.value != null
                   ? Image.file(
                 File(controller.selectedImage.value!.path),
                 fit: BoxFit.cover,
                 width: double.infinity,
                 height: double.infinity,
               )
                   : Image.network(
                 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                 fit: BoxFit.cover,
                 width: double.infinity,
                 height: double.infinity,
               );
             }),
           ),
         ),

         SliverToBoxAdapter(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
             child: Column(
               children: [
                 Card(
                   elevation: 4,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 18.0,right: 18,top: 8,bottom: 8),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CustomText(text: 'Bella \nBorder Collie ',textAlign: TextAlign.start,fontWeight: FontWeight.w600,),
                             Gap(6),
                             CustomText(text: "Female",textAlign: TextAlign.start,fontWeight: FontWeight.w600,color: AppColors.purple500,),
                         ],
                       ),
                         Column(
                           children: [
                             CircleAvatar(
                                 backgroundColor: Color(0xFFF576AC),
                                 child: IconButton(onPressed: (){
                                   AppRouter.route.pushNamed(RoutePath.editMyPetsScreen);
                                 }, icon: Icon(Icons.edit,size: 20,))),
                             Gap(6),

                           ],
                         )
                       ],
                     ),
                   ),
                 ),
                 Gap(8),
                 Row(
                   children: [
                      Icon(Icons.account_box_outlined),
                     Gap(6),
                     CustomText(text: "About Bella",fontWeight: FontWeight.w600,fontSize: 16,)

                   ],
                 ),
                 Gap(16),
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: List.generate(6, (index){
                   return  Card(
                     color: Color(0xFFd2ead1),
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           CustomText(text: "Age",fontWeight: FontWeight.w400,fontSize: 14,),
                           CustomText(text: "1y 4m 11d",color: Color(0xFF064E57),fontSize: 14,fontWeight: FontWeight.w600,),
                         ],
                       ),
                     ),
                   );
                 }),
               ),
             ),
                 Gap(16),
                 Row(
                   children: [

                     Icon(Icons.safety_divider_outlined),
                     Gap(6),
                     CustomText(text: "Bella’s Status",fontWeight: FontWeight.w600,fontSize: 16,)

                   ],
                 ),
                 Gap(16),
                 Divider(height: 1,color: Colors.grey,),
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
                           child: Icon(Icons.health_and_safety,size: 24,color: Colors.white,),
                         ),
                         Gap(6),
                         CustomText(text: "Health",fontSize: 16,fontWeight:FontWeight.w600,),
                       ],
                     ),
                     GestureDetector(
                       onTap: (){

                       },
                       child: Container(
                         padding: EdgeInsets.all(8),
                         decoration: BoxDecoration(
                         color: Color(0xFFE54D4D),
                         borderRadius: BorderRadius.circular(10),
                       ), child: Row(
                         children: [
                           CustomText(text: "Contact Vet",fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),
                           Icon(Icons.arrow_forward_ios_rounded,size: 18,color: Colors.white,)
                         ],
                       ),
                       ),
                     )
                   ],
                 ),
                 Gap(16),
                 Align(
                   alignment: Alignment.topLeft,
                     child: CustomText(text: "Health History",fontWeight: FontWeight.w700,fontSize: 14,)),
                 Gap(8),
                 HealthHistorySection(text: "Vaccinations:", subText: "Up to date",),
                 Gap(12),
                 HealthHistorySection(text: "Pills:", subText: "Heartworm prevention monthly",),
                 Gap(12),
                 HealthHistorySection(text: "Appointments:", subText: "Last check-up 2 months ago",),
                 Gap(12),
                 HealthHistorySection(text: "Surgeries:", subText: "Spayed - January 2024",),
                 Gap(12),
                 HealthHistorySection(text: "Treatments:", subText: " Flea and tick treatment every 3 months",),
                 Gap(12),
                 HealthHistorySection(text: "Notes:", subText: "Allergic to certain antibiotics",),
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
    );
  }
}


