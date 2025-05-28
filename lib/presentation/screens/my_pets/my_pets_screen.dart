import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       slivers: [
         SliverAppBar(
           pinned: true,
           expandedHeight: 200,
              centerTitle: true,
           title: Text('My Pet'),
           flexibleSpace: FlexibleSpaceBar(
             background: Image.network(
               'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80', // your image URL or use AssetImage
               fit: BoxFit.cover,
             ),
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
                       CustomText(text: 'Bella \nBorder Collie ',textAlign: TextAlign.start,fontWeight: FontWeight.w600,),
                         Column(
                           children: [
                             CircleAvatar(
                                 backgroundColor: Color(0xFFF576AC),
                                 child: IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,))),
                             Gap(6),
                             CircleAvatar(
                               backgroundColor: Color(0xFFF576AC),
                               radius: 20,
                               child: Icon(Icons.health_and_safety_outlined),
                             )
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
               ],
             ),
           ),
         ),
         SliverList(
           delegate: SliverChildBuilderDelegate(
                 (context, index) => ListTile(
               title: Text('Item #$index'),
             ),
             childCount: 20,
           ),
         ),
       ],
     ),
    );
  }
}
