import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
          title: CustomText(text:"Notification" ,fontSize: 16,fontWeight: FontWeight.w600,),
      ),
     body: CustomScrollView(
       slivers: [

         SliverList(
           delegate: SliverChildBuilderDelegate(
                 (context, index) => Padding(
                   padding: EdgeInsets.only(left: 16,right: 16),
                   child: Card(
                     shape: OutlineInputBorder(
                       borderSide: BorderSide(color:AppColors.purple500),
                       borderRadius: BorderRadius.circular(8.r)
                     ),
                     color: Colors.white,
                     child: ListTile(
                       title: CustomText(text: '"Welcome to SansaLand"  ',textAlign: TextAlign.start,),
                       subtitle: CustomText(text: "Friday,12 PM",textAlign: TextAlign.start,),
                       leading: CircleAvatar(
                         child: Assets.images.splashlogo.image(),
                       ),
                                  ),
                   ),
                 ),
             childCount: 20,
           ),
         ),
       ],
     ),
    );
  }
}
