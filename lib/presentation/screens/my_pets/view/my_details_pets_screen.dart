import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
  final String id ;
  const MyDetailsPetsScreen({super.key, required this.id, });
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
     body:  RefreshIndicator(
       onRefresh: () async{
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
               final pet =
                   controller.details.value.pet?.petPhoto;
               final image =
               pet != null && pet.isNotEmpty ? pet.first ?? "" : "";
               return image.isNotEmpty
                   ? Image.network(ApiUrl.imageBase + image, height: 100)
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
               padding: const EdgeInsets.symmetric(
                 horizontal: 16,
                 vertical: 20,
               ),
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
                                   text: controller.details.value.pet?.name ?? "",
                                   textAlign: TextAlign.start,
                                   fontWeight: FontWeight.w600,
                                   fontSize: 16,
                                 );
                               }),
                               Gap(6),
                               CustomText(
                                 text: controller.details.value.pet?.gender ?? "",
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
                           text: "About ${controller.details.value.pet?.name ?? ""}",
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
                         text: "${controller.details.value.pet?.name ?? ""} ’s Status",
                         fontWeight: FontWeight.w600,
                         fontSize: 16,
                       ),
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
                           AppRouter.route.pushNamed(RoutePath.petHealthScreen);
                         },
                         child: Container(
                           padding: EdgeInsets.all(8),
                           decoration: BoxDecoration(
                             color: Color(0xFFE54D4D),
                             borderRadius: BorderRadius.circular(10),
                           ), child: Row(
                           children: [
                             CustomText(text: "Health Status",fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),
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
                   Gap(16),
                   CustomAlignText(text: "More Info",fontWeight: FontWeight.w600,fontSize: 14,),
                   Gap(8),
                   Container(
                     padding: EdgeInsets.all(12),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: AppColors.purple500)
                     ),
                     child:CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ",fontSize: 16,fontWeight: FontWeight.w400,maxLines: 6,textAlign: TextAlign.start,),
                   )

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


