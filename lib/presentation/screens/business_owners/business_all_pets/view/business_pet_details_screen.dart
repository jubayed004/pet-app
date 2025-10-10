import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/vaccination_list_widget.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/health_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessPetsDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessPetsDetailsScreen({super.key, required this.id});

  @override
  State<BusinessPetsDetailsScreen> createState() => _BusinessPetsDetailsScreenState();
}

class _BusinessPetsDetailsScreenState extends State<BusinessPetsDetailsScreen> {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  final pagingController = PagingController<int, PetMedicalHistoryByTreatmentStatus>(firstPageKey: 1);
  final pagingController1 = PagingController<int, PetMedicalHistoryByTreatmentStatus>(firstPageKey: 1);

  static final _dateFmt = DateFormat('dd MMMM yyyy');

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  void _initializeScreen() {
    pagingController.addPageRequestListener((int pageKey) {
      businessAllPetController.getHealthHistoryUpdate(
        id: widget.id,
        status: 'COMPLETED',
        page: pageKey,
        pagingController: pagingController
      );
    });

    pagingController1.addPageRequestListener((int pageKey) {
      businessAllPetController.getHealthHistoryUpdate1(
        id: widget.id,
        status: 'PENDING',
        page: pageKey,
        pagingController1: pagingController1,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await businessAllPetController.businessPetDetails(id: widget.id);
    });
  }


  @override
  void dispose() {
    pagingController.dispose();
    pagingController1.dispose();
    super.dispose();
  }

  Color _statusColorFor(BuildContext context, String? status) {
    final s = (status ?? '').toLowerCase();
    if (s.contains('complete') || s == 'done') return const Color(0xFF5ED160);
    if (s.contains('pending') || s.contains('schedule')) return const Color(0xFFFFA726);
    if (s.contains('cancel') || s.contains('miss')) return const Color(0xFFE54D4D);
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kWhiteColor,
        body: Obx(() {
          final isLoading = businessAllPetController.detailsLoading.value == Status.loading;
          final hasError = businessAllPetController.detailsLoading.value == Status.error;
          final noData = businessAllPetController.detailsLoading.value == Status.noDataFound;

          // Show loading state
          if (isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading pet details...'),
                ],
              ),
            );
          }

          // Show error state
          if (hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Failed to load pet details'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      businessAllPetController.businessPetDetails(id: widget.id);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show no data state
          if (noData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pets, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Pet not found'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final pet = businessAllPetController.details.value.petWithMedicalHistory;

          // Main content
          return NestedScrollView(
            headerSliverBuilder: (context, innerScrolled) => [
              // Title app bar
              CustomDefaultAppbar(title: pet?.name ?? "Pet Details"),

              // Header image with gradient overlay
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    _buildPetImage(context, pet?.petPhoto),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Pet info section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPetInfoCard(pet),
                      const Gap(20),
                      _buildAboutSection(pet),
                      const Gap(20),
                      _buildHealthSection(context),
                    ],
                  ),
                ),
              ),

              // Pinned TabBar
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarHeaderDelegate(
                  TabBar(
                    dividerColor: Colors.transparent,
                    labelColor: const Color(0xFFE54D4D),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFFE54D4D),
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    tabs: const [
                      Tab(text: 'Past Vaccinations'),
                      Tab(text: 'Upcoming Vaccinations')
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
                  pagingController: pagingController,
                  itemBuilder: (context, item, index) {
                    final date = item.treatmentDate?.toLocal();
                    final dateText = date != null ? _dateFmt.format(date) : '—';
                    return HealthCard(
                      key: ValueKey('completed_${item.id}_${widget.id}'),
                      id: item.id ?? "",
                      petId: widget.id,
                      title: item.treatmentName ?? "",
                      dateOfMonth: dateText,
                      drName: item.doctorName ?? "",
                      treatmentDescription: item.treatmentDescription ?? "",
                      status: item.treatmentStatus ?? "COMPLETED",
                      statusColor: _statusColorFor(context, item.treatmentStatus ?? "COMPLETED"),
                      pagingController: pagingController,
                      pagingController1: pagingController1,
                    );
                  },
                  emptyText: 'No past vaccinations found',
                ),

                // Next (PENDING)
                VaccinationList(
                  pagingController: pagingController1,
                  itemBuilder: (context, item, index) {
                    final date = item.treatmentDate?.toLocal();
                    final dateText = date != null ? _dateFmt.format(date) : '—';
                    return HealthCard(
                      key: ValueKey('pending_${item.id}_${widget.id}'),
                      id: item.id ?? "",
                      petId: widget.id,
                      title: item.treatmentName ?? "",
                      dateOfMonth: dateText,
                      drName: item.doctorName ?? "",
                      treatmentDescription: item.treatmentDescription ?? "",
                      status: item.treatmentStatus ?? "PENDING",
                      statusColor: _statusColorFor(context, item.treatmentStatus ?? "PENDING"),
                      pagingController: pagingController,
                      pagingController1: pagingController1,
                    );
                  },
                  emptyText: 'No upcoming vaccinations scheduled',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPetImage(BuildContext context, String? petPhoto) {
    final image = (petPhoto != null && petPhoto.isNotEmpty)
        ? petPhoto
        : 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?auto=format&fit=crop&w=800&q=80';

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.pets, size: 64, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPetInfoCard(dynamic pet) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE54D4D).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.pets, size: 32, color: Color(0xFFE54D4D)),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: pet?.name ?? "Unknown",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Icon(
                        pet?.gender?.toLowerCase() == 'male' ? Icons.male : Icons.female,
                        size: 18,
                        color: AppColors.purple500,
                      ),
                      const Gap(4),
                      CustomText(
                        text: pet?.gender ?? "Unknown",
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.purple500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(dynamic pet) {
    final details = [
      if (pet?.age != null) {'icon': Icons.cake, 'title': 'Age', 'value': '${pet?.age} years'},
      if (pet?.animalType != null) {'icon': Icons.category, 'title': 'Type', 'value': pet?.animalType},
      if (pet?.breed != null) {'icon': Icons.pets, 'title': 'Breed', 'value': pet?.breed},
      if (pet?.height != null) {'icon': Icons.height, 'title': 'Height', 'value': '${pet?.height} cm'},
      if (pet?.weight != null) {'icon': Icons.monitor_weight, 'title': 'Weight', 'value': '${pet?.weight} kg'},
      if (pet?.color != null) {'icon': Icons.color_lens, 'title': 'Color', 'value': pet?.color},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.info_outline, size: 20, color: Colors.blue),
            ),
            const Gap(8),
            const CustomText(
              text: "About Pet",
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ],
        ),
        const Gap(12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: details.map((detail) {
            return Container(
              width: (MediaQuery.of(context).size.width - 56) / 2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(detail['icon'] as IconData, size: 20, color: Colors.grey[700]),
                  const Gap(6),
                  Text(
                    detail['title'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    detail['value'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHealthSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE54D4D).withValues(alpha: 0.1),
            const Color(0xFFE54D4D).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE54D4D).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE54D4D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.health_and_safety, size: 28, color: Colors.white),
              ),
              const Gap(12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Health Records",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(2),
                  Text(
                    'Manage vaccinations',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => showAddHealthDialog(context, widget.id, pagingController1, pagingController),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE54D4D),
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 20),
                Gap(4),
                Text('Add', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.white,
      elevation: overlapsContent ? 4 : 0,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}