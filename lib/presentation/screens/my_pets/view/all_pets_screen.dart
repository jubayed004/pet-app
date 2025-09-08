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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPetsScreen extends StatelessWidget {
  AllPetsScreen({super.key});

  final myPetsController = GetControllers.instance.getMyPetsProfileController();

  Future<void> _refresh() async {
    await myPetsController.getAllPet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomDefaultAppbar(title: "All Pets"),
              Obx(() {
                // Safely handle the pet list (assuming it's a single pet object or an empty list)
                final pets = myPetsController.profile.value.pet?? [];
                // Fallback to an empty list if no pets

                if (pets.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.pets, size: 48),
                          SizedBox(height: 8.h),
                          Text(
                            "No pets found",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Pull down to refresh.",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = pets[index];
                      final String id = item.id ?? "";
                      final String name = item.name ?? "";
                      final String petType = item.animalType ?? "";
                      final String photo = (item.petPhoto ?? "").trim();

                      Widget avatar;
                      if (photo.isNotEmpty) {
                        final imageUrl = '${ApiUrl.imageBase}$photo';
                        avatar = CircleAvatar(
                          radius: 24.r,  // Use ScreenUtil for radius scaling
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(imageUrl),
                        );
                      } else {
                        avatar = const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.pets),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          AppRouter.route.pushNamed(
                            RoutePath.myPetsScreen,
                            extra: id,
                          );
                        },
                        child: Card(
                          color: AppColors.purple200,
                          elevation: 1,
                          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),  // Use ScreenUtil for margins
                          child: ListTile(
                            leading: avatar,
                            title: Text(
                              name,
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500), // Use ScreenUtil for font size
                            ),
                            subtitle: Text(
                              petType,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400), // Use ScreenUtil for font size
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                defaultDeletedYesNoDialog(
                                  context: context,
                                  title: 'Are you sure you want to delete this Pet?',
                                  onYes: () {
                                    myPetsController.deletedPet(id: id);
                                  },
                                );
                              },
                              icon: const Icon(Iconsax.trash, color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: pets.length,
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
