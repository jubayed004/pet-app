import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/utils/app_const/app_const.dart'; // for Status enum

class AllPetsScreen extends StatefulWidget {
  const AllPetsScreen({super.key});

  @override
  State<AllPetsScreen> createState() => _AllPetsScreenState();
}

class _AllPetsScreenState extends State<AllPetsScreen> {
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
          child: Obx(() {
            final status = myPetsController.loading.value;
            final pets = myPetsController.profile.value.pet ?? [];

            /// Handle states
            if (status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (status == Status.internetError) {
              return NoInternetCard(
                onTap: () => myPetsController.getAllPet(),
              );
            }

            if (status == Status.error) {
              return ErrorCard(
                onTap: () => myPetsController.getAllPet(),
              );
            }

            if (status == Status.noDataFound || pets.isEmpty) {
              return NoDataCard(
                onTap: () => myPetsController.getAllPet(),
              );
            }

            /// Show Pets List when completed
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                CustomDefaultAppbar(title: "All Pets"),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = pets[index];
                      final String id = item.id ?? "";
                      final String name = item.name ?? "";
                      final String petType = item.animalType ?? "";
                      final String photo = (item.petPhoto ?? "").trim();

                      Widget avatar;
                      if (photo.isNotEmpty) {
                        avatar = CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(photo),
                        );
                      } else {
                        avatar = const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.pets),
                        );
                      }

                      return GestureDetector(
                        onTap: () => AppRouter.route.pushNamed(
                          RoutePath.myPetsScreen,
                          extra: id,
                        ),
                        child: Card(
                          color: AppColors.purple200,
                          elevation: 1,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          child: ListTile(
                            leading: avatar,
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              petType,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                defaultDeletedYesNoDialog(
                                  context: context,
                                  title:
                                  'Are you sure you want to delete this Pet?',
                                  onYes: () =>
                                      myPetsController.deletedPet(id: id),
                                );
                              },
                              icon: const Icon(
                                Iconsax.trash,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: pets.length,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
