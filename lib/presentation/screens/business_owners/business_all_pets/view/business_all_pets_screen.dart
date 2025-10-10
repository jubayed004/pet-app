import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAllPetsScreen extends StatelessWidget {
  BusinessAllPetsScreen({super.key});

  final businessPetsController = GetControllers.instance.getBusinessAllPetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          businessPetsController.getBusinessAllPets();
        },
        child: CustomScrollView(
          slivers: [
            /// ✅ Appbar
            CustomDefaultAppbar(title: "All Pets"),

            /// ✅ Pet List (SliverList + Obx)
            Obx(() {
              final state = businessPetsController.loading.value;
              final pets = businessPetsController.profile.value.pets ?? [];

              if (state == Status.loading) {
                return const SliverToBoxAdapter(child: Center(child: Padding(padding: EdgeInsets.all(24.0), child: CircularProgressIndicator())));
              }

              if (pets.isEmpty) {
                return const SliverToBoxAdapter(child: Center(child: Padding(padding: EdgeInsets.all(24.0), child: Text("No pets found"))));
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = pets[index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: (item.petPhoto != null && item.petPhoto!.isNotEmpty) ? NetworkImage(item.petPhoto!) : null,
                      child: (item.petPhoto == null || item.petPhoto!.isEmpty) ? const Icon(Icons.pets, color: Colors.white) : null,
                    ),
                    title: Text(item.name ?? "Unknown"),
                    subtitle: Text(item.breed ?? ""),
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.businessPetsDetailsScreen, extra: item.id ?? "");
                    },
                  );
                }, childCount: pets.length),
              );
            }),
          ],
        ),
      ),
    );
  }
}
