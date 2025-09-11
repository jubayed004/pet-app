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
import 'package:pet_app/utils/app_const/app_const.dart';

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
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomDefaultAppbar(title: "All Pets"),
              Obx(() {
                // Checking loading status
                switch (myPetsController.loading.value) {
                  case Status.loading:
                    return SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case Status.internetError:
                    return SliverToBoxAdapter(
                      child: Center(child: Text('Internet error. Please try again.')),
                    );
                  case Status.noDataFound:
                    return SliverToBoxAdapter(
                      child: Center(child: Text('No pets found.')),
                    );
                  case Status.error:
                    return SliverToBoxAdapter(
                      child: Center(child: Text('An error occurred.')),
                    );
                  case Status.completed:
                    final pets = myPetsController.profile.value.pet ?? [];
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = pets[index];
                        final String id = item.id ?? "";
                        final String name = item.name ?? "";
                        final String petType = item.animalType ?? "";
                        final String photo = (item.petPhoto ?? "").trim();

                        Widget avatar;
                        if (photo.isNotEmpty) {
                          final imageUrl = '${ApiUrl.imageBase}$photo';
                          avatar = CircleAvatar(
                            radius: 24.r, // Use ScreenUtil for radius scaling
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(imageUrl),
                          );
                        } else {
                          avatar = const CircleAvatar(radius: 24, child: Icon(Icons.pets));
                        }

                        return GestureDetector(
                          onTap: () {
                            AppRouter.route.pushNamed(RoutePath.myPetsScreen, extra: id);
                          },
                          child: Card(
                            color: AppColors.purple200,
                            elevation: 1,
                            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

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
                      }, childCount: pets.length),
                    );
                }
                return SliverToBoxAdapter(child: SizedBox()); // Default empty widget
              }),
            ],
          ),
        ),
      ),
    );
  }
}
