import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BusinessPetsDetailsScreen extends StatelessWidget {
  final String name ;
  final String imageUrl;

  BusinessPetsDetailsScreen({super.key, required this.name, required this.imageUrl,});
  final controller = GetControllers.instance.getMyPetsProfileController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryColor,
            pinned: true,
            expandedHeight: 200,
            centerTitle: true,
            title: CustomText(text: name,fontWeight: FontWeight.w600,fontSize: 24,color: Colors.black,),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            /* flexibleSpace: FlexibleSpaceBar(
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
           ),*/
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
                              CustomText(text: name ,textAlign: TextAlign.start,fontWeight: FontWeight.w600,fontSize: 16,),
                              Gap(6),
                              CustomText(text: "Female",textAlign: TextAlign.start,fontWeight: FontWeight.w600,color: AppColors.purple500,),
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
                      CustomText(text: "About $name",fontWeight: FontWeight.w600,fontSize: 16,)
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
                      CustomText(text: "$name’s Status",fontWeight: FontWeight.w600,fontSize: 16,)
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
                        onTap: () {
                          showAddHealthDialog(context); // 👈 Show the dialog
                        },

                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFE54D4D),
                            borderRadius: BorderRadius.circular(10),
                          ), child: Row(
                          children: [
                            CustomText(text: "Add Health Update ",fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),
                            Icon(Icons.arrow_forward_ios_rounded,size: 18,color: Colors.white,)
                          ],
                        ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
         SliverToBoxAdapter(
           child:  Padding(
             padding: padding16H,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: const [
                 Text(
                   "Past vaccinations",
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                 ),
                 Icon(Icons.edit, size: 18, color: Colors.pink),
               ],
             ),
           ),
         ),
         SliverGrid(
           delegate: SliverChildBuilderDelegate(
                 (context, index) => Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     color: Color(0xFFF7F7F7),
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Rabies vaccination", style: TextStyle(fontWeight: FontWeight.w700)),
                       SizedBox(height: 4),
                       Text("Mon 24 Jan", style: TextStyle(color: Colors.black54)),
                       Text("Dr. Green", style: TextStyle(color: Colors.black54)),
                     ],
                   ),
                 ),
             childCount: 5,
           ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 100),
         ),
          SliverToBoxAdapter(
            child:  Padding(
              padding: padding16H,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Next vaccinations",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.edit, size: 18, color: Colors.pink),
                ],
              ),
            ),
          ),
         SliverGrid(
           delegate: SliverChildBuilderDelegate(
                 (context, index) => Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     color: Color(0xFFF7F7F7),
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Rabies vaccination", style: TextStyle(fontWeight: FontWeight.w700)),
                       SizedBox(height: 4),
                       Text("Mon 24 Jan", style: TextStyle(color: Colors.black54)),
                       Text("Dr. Green", style: TextStyle(color: Colors.black54)),
                     ],
                   ),
                 ),
             childCount: 5,
           ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 100),
         ),

          SliverToBoxAdapter(
            child:      Container(
              margin: paddingH16V8,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.purple500)
              ),
              child:CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ",fontSize: 16,fontWeight: FontWeight.w400,maxLines: 6,textAlign: TextAlign.start,),
            ),
          )
        ],
      ),
    );
  }
}


