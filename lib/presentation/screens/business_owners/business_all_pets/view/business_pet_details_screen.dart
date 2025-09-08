import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/vaccination_list_widget.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

// widgets
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/details_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/health_card.dart';

// models
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';

class BusinessPetsDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessPetsDetailsScreen({super.key, required this.id});

  @override
  State<BusinessPetsDetailsScreen> createState() =>
      _BusinessPetsDetailsScreenState();
}

class _BusinessPetsDetailsScreenState extends State<BusinessPetsDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  final businessAllPetController =
      GetControllers.instance.getBusinessAllPetController();

  static final _dateFmt = DateFormat('dd MMMM yyyy');

  final controller = GetControllers.instance.getMyPetsProfileController();


  @override void initState() {
    businessAllPetController.businessPetDetails(id: widget.id);
    businessAllPetController.getHealthHistoryUpdate(
      id: widget.id, status: '', page: 1,);
    businessAllPetController.pagingController.refresh();
    businessAllPetController.pagingController.addPageRequestListener((pageKey) {
      businessAllPetController.getHealthHistoryUpdate(
        id: widget.id, status: 'COMPLETED', page: pageKey,);
    });
    businessAllPetController.pagingController1.refresh();
    businessAllPetController.pagingController1.addPageRequestListener((
        pageKey,) {
      businessAllPetController.getHealthHistoryUpdate1(
        id: widget.id, status: 'PENDING', page: pageKey,);
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Color _statusColorFor(BuildContext context, String? status) {
    final s = (status ?? '').toLowerCase();
    final scheme = Theme
        .of(context)
        .colorScheme;
    if (s.contains('complete') || s == 'done') return scheme.primary;
    if (s.contains('pending') || s.contains('schedule')) return scheme.tertiary;
    if (s.contains('cancel') || s.contains('miss')) {
      return const Color(0xFFE54D4D);
    }
    return scheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kWhiteColor,
        body: RefreshIndicator(
          onRefresh: () async {
            businessAllPetController.businessPetDetails(id: widget.id);
            businessAllPetController.pagingController.refresh();
            businessAllPetController.pagingController1.refresh();
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (context, innerScrolled) =>
            [
              // App bar (your custom sliver appbar widget)
              Obx(() {
                return CustomDefaultAppbar(
                  title:
                  businessAllPetController.details.value.pet?.name ??
                      "",
                );
              }),

              // Header image (safe)
              SliverToBoxAdapter(
                child: Obx(() {
                  final pet =
                      businessAllPetController.details.value.pet?.petPhoto;
                  final image = pet != null && pet.isNotEmpty ? pet : "";
                  return image.isNotEmpty
                      ? Image.network(
                      ApiUrl.imageBase + image, height: MediaQuery
                      .of(context)
                      .size
                      .height / 7)
                      : Image.network(
                    'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 7,
                  );
                }),
              ),

              // Basic info block
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                final pet =
                                    businessAllPetController
                                        .details
                                        .value
                                        .pet;
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: pet?.name ?? "",
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    const Gap(6),
                                    CustomText(
                                      text: pet?.gender ?? "",
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.purple500,
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const Gap(8),

                      Row(
                        children: [
                          const Icon(Icons.account_box_outlined),
                          const Gap(6),
                          Obx(() {
                            final name =
                                businessAllPetController
                                    .details
                                    .value
                                    .pet
                                    ?.name ??
                                    "";
                            return CustomText(
                              text: "About $name",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            );
                          }),
                        ],
                      ),
                      const Gap(16),

                      SizedBox(
                        height: 80,
                        child: Obx(() {
                          final pet =
                              businessAllPetController.details.value.pet;
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              DetailsCard(
                                title: "Age",
                                details: pet?.age?.toString() ?? "",
                              ),
                              DetailsCard(
                                title: "Pet Type",
                                details: pet?.animalType ?? "",
                              ),
                              DetailsCard(
                                title: "Gender",
                                details: pet?.gender ?? "",
                              ),
                              DetailsCard(
                                title: "Height",
                                details: pet?.height?.toString() ?? "",
                              ),
                              DetailsCard(
                                title: "Weight",
                                details: pet?.weight?.toString() ?? "",
                              ),
                              DetailsCard(
                                title: "Color",
                                details: pet?.color ?? "",
                              ),
                              DetailsCard(
                                title: "Breed",
                                details: pet?.breed ?? "",
                              ),
                            ],
                          );
                        }),
                      ),
                      const Gap(16),

                      Row(
                        children: const [
                          Icon(Icons.safety_divider_outlined),
                          Gap(6),
                          CustomText(
                            text: "Status",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const Gap(16),
                      const Divider(height: 1, color: Colors.grey),
                      const Gap(16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color(0xFFE54D4D),
                                child: Icon(
                                  Icons.health_and_safety,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(10),
                              CustomText(
                                text: "Health",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap:
                                () =>
                                showAddHealthDialog(context, widget.id),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE54D4D),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                children: [
                                  CustomText(
                                    text: "Add Health Update ",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 🔒 Pinned TabBar
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarHeaderDelegate(
                  TabBar(
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    indicatorColor: const Color(0xFFE54D4D),
                    tabs: const [
                      Tab(text: 'Past vaccinations'),
                      Tab(text: 'Next vaccinations'),
                    ],
                  ),
                ),
              ),
            ],

            // Tab bodies
            body: TabBarView(
              children: [
                // Past (COMPLETED)
                VaccinationList(
                  pagingController: businessAllPetController.pagingController,
                  itemBuilder: (context, item, index) {
                    final date = item.treatmentDate?.toLocal();
                    final dateText = date != null ? _dateFmt.format(date) : '—';
                    return HealthCard(
                      key: ValueKey(item.id ?? index),
                      id: item.id ?? "",
                      title: item.treatmentName ?? "",
                      dateOfMonth: dateText,
                      drName: item.doctorName ?? "",
                      treatmentDescription: item.treatmentDescription ?? "",
                      status: item.treatmentStatus ?? "COMPLETED",
                      statusColor: _statusColorFor(
                        context,
                        item.treatmentStatus ?? "COMPLETED",
                      ),
                    );
                  },
                  emptyText: 'No past vaccinations found',
                ),

                // Next (PENDING)
                VaccinationList(
                  pagingController: businessAllPetController.pagingController1,
                  itemBuilder: (context, item, index) {
                    final date = item.treatmentDate?.toLocal();
                    final dateText = date != null ? _dateFmt.format(date) : '—';
                    return HealthCard(
                      key: ValueKey(item.id ?? index),
                      id: item.id ?? "",
                      title: item.treatmentName ?? "",
                      dateOfMonth: dateText,
                      drName: item.doctorName ?? "",
                      treatmentDescription: item.treatmentDescription ?? "",
                      status: item.treatmentStatus ?? "PENDING",
                      statusColor: _statusColorFor(
                        context,
                        item.treatmentStatus ?? "PENDING",
                      ),
                    );
                  },
                  emptyText: 'No upcoming vaccinations',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Pinned TabBar delegate
class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  _TabBarHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context,
      double shrinkOffset,
      bool overlapsContent,) {
    return Material(
      color: Colors.white,
      elevation: overlapsContent ? 2 : 0,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}



