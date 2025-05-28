import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
             padding: const EdgeInsets.all(8.0),
             child: Card(
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
