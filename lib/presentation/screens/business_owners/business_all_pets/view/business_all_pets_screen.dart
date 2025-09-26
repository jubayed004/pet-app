import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/service/api_url.dart';

class BusinessAllPetsScreen extends StatelessWidget {
   BusinessAllPetsScreen({super.key});
   final businessPetsController = GetControllers.instance.getBusinessAllPetController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          businessPetsController.getBusinessAllPets();
        },
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "All Pets",),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Obx(() => ListView.builder(
                  itemCount: businessPetsController.profile.value.pets?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = businessPetsController.profile.value.pets?[index];
                    final photo = item?.petPhoto != null && item!.petPhoto!.isNotEmpty? item.petPhoto : "";
                    final name = item?.name ?? "";
                    return GestureDetector(
                      onTap: () {
                    AppRouter.route.pushNamed(RoutePath.businessPetsDetailsScreen, extra: item?.id ?? "");

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(photo?? ""),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ),
            ),
          /*  SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  leading: Assets.icons.champ.svg(width: 30), // Correct way to use SVGs
                  title: Text("Bella"),
                ),
              ]),
            ),*/
          ],
        ),
      ),
    );
  }
}
