import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/service/api_url.dart';

class AllPetsScreen extends StatelessWidget {
  AllPetsScreen({super.key});

  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: const Text("All Pets"),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Obx(() => ListView.builder(
                  itemCount: myPetsController.profile.value.pet?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = myPetsController.profile.value.pet?[index];
                    final photo = item?.petPhoto != null && item!.petPhoto!.isNotEmpty? item.petPhoto?.first ?? "" : "";
                    final name = item?.name ?? "";
                    return GestureDetector(
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.myPetsScreen, extra: item?.id ?? "");

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage('${ApiUrl.imageBase}$photo'),
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
          ],
        ),
      ),
    );
  }
}
