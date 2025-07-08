import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/category/widgets/category_card_widget.dart';
import 'package:pet_app/presentation/screens/home/controller/home_controller.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});
  final homeController = GetControllers.instance.getHomeController();
   final categoryController = GetControllers.instance.getCategoryController();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      // backgroundColor: AppColors.appBackgroundColor,
 backgroundColor: AppColors.whiteColor,
       body: CustomScrollView(
         slivers: [
           CustomDefaultAppbar(title: 'Category'),
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
                                 child: homeController.iconList[index],
                               );
                             }),
                           ),
                         ),
                         Gap(4),
                         CustomText(
                           text: homeController.stringList[index],
                           fontSize: 16,
                           fontWeight: FontWeight.w400,
                         ),
                       ],
                     ),
                   );
                 },
               ),
             ),
           ),
     /*      SliverFillRemaining(
             child: RefreshIndicator(
               onRefresh: () async {
                 categoryController.pagingController.refresh();
               },
               child: PagedListView<int, String>(
                 pagingController: categoryController.pagingController,
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                 builderDelegate: PagedChildBuilderDelegate<String>(
                   itemBuilder: (context, item, index) {
                     return CategoryCardWidget();
                   },
                   firstPageErrorIndicatorBuilder: (context) => Center(
                     child: ErrorCard(
                       onTap: () => categoryController.pagingController.refresh(),
                       text: categoryController.pagingController.error.toString(),
                     ),
                   ),
                 ),
               ),
             ),
           ),*/

/*           /// 👇 এই অংশটায় ক্লিক করা আইটেম অনুযায়ী UI দেখাবো
           SliverToBoxAdapter(
             child: Obx(() {
               int selectedIndex = homeController.selectedIndex.value;
               return Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Card(
                   color: Colors.white,
                   elevation: 4,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(16),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomText(
                           text: "Selected Category: ${homeController.stringList[selectedIndex]}",
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                         ),
                         Gap(10),
                         // তুমি চাইলে এখানে Image, Description বা অন্য কিছুও দেখাতে পারো
                         CustomText(
                           text: "Description of ${homeController.stringList[selectedIndex]} goes here.",
                           fontSize: 14,
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             }),
           ),*/
         ],
       ),
     );
   }
}
