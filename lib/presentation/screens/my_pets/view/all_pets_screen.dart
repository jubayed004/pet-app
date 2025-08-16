import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class AllPetsScreen extends StatelessWidget {
  AllPetsScreen({super.key});

  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: RefreshIndicator(

          onRefresh: () async{
            myPetsController.getAllPet();
          },
          child: CustomScrollView(
            slivers: [
             CustomDefaultAppbar(title: "All Pets",),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Obx(() => ListView.builder(
                    itemCount: myPetsController.profile.value.pet?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = myPetsController.profile.value.pet?[index];
                      final photo = item?.petPhoto != null && item!.petPhoto!.isNotEmpty? item.petPhoto ?? "": "";
                      print(photo);
                      final name = item?.name ?? "";
                      final petType = item?.animalType ?? "";
                      return GestureDetector(
                        onTap: () {
                          AppRouter.route.pushNamed(RoutePath.myPetsScreen, extra: item?.id ?? "");
                        },
                        child: Card(
                          color: AppColors.purple200,
                            elevation: 1,
                          child: ListTile(
                            trailing: IconButton(onPressed: (){
                              defaultDeletedYesNoDialog(
                                context: context,
                                title: 'Are you sure you want to delete this Pet?',

                                onYes: () {
                                  myPetsController.deletedPet(id: item?.id ?? "",);
                                },

                              );
                            }, icon: Icon(Iconsax.trush_square,color: Colors.red,)),
                            leading:     CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage('${ApiUrl.imageBase}$photo'),
                            ),
                            title:  Text(
                              name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            subtitle:    Text(
                              petType,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
