import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';

class AllPetsScreen extends StatelessWidget {
  AllPetsScreen({super.key});

  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("All Pets"),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Obx(() => ListView.builder(
                itemCount: myPetsController.petList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final pet = myPetsController.petList[index];
                  return GestureDetector(
                    onTap: () {
                      AppRouter.route.pushNamed(
                        RoutePath.myPetsScreen,
                        extra: {
                          'name': pet['name'],
                          'image': pet['image'],
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(pet["image"]!),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            pet["name"]!,
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
    );
  }
}
