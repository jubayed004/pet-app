import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/vaccination_list_widget.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/health_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';

class HealthRecordsScreen extends StatefulWidget {
  final String petId;

  const HealthRecordsScreen({super.key, required this.petId});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> with SingleTickerProviderStateMixin {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();
  final pagingController = PagingController<int, PetMedicalHistoryByTreatmentStatus>(firstPageKey: 1);
  final pagingController1 = PagingController<int, PetMedicalHistoryByTreatmentStatus>(firstPageKey: 1);

  late TabController _tabController;
  static final _dateFmt = DateFormat('dd MMMM yyyy');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializePagination();
  }

  void _initializePagination() {
    // Past/Completed vaccinations
    pagingController.addPageRequestListener((int pageKey) {
      businessAllPetController.getHealthHistoryUpdate(
        id: widget.petId,
        status: 'COMPLETED',
        page: pageKey,
        pagingController: pagingController,
      );
    });

    // Upcoming/Pending vaccinations
    pagingController1.addPageRequestListener((int pageKey) {
      businessAllPetController.getHealthHistoryUpdate1(
        id: widget.petId,
        status: 'PENDING',
        page: pageKey,
        pagingController1: pagingController1,
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomDefaultAppbar(title: "Health Records"),

          // Header card with gradient
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(screenWidth * 0.04),
              padding: EdgeInsets.all(screenWidth * 0.045),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE54D4D),
                    const Color(0xFFE54D4D).withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE54D4D).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medical History',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(4),
                        Text(
                          'Track all vaccinations and treatments',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TabBar with enhanced styling
          SliverPersistentHeader(
            pinned: true,
            delegate: _EnhancedTabBarDelegate(
              TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                labelColor: const Color(0xFFE54D4D),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFFE54D4D),
                indicatorWeight: 3,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 18),
                        Gap(6),
                        Text('Past'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.schedule, size: 18),
                        Gap(6),
                        Text('Upcoming'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Past Vaccinations
            VaccinationList(
              pagingController: pagingController,
              itemBuilder: (context, item, index) {
                final date = item.treatmentDate?.toLocal();
                final dateText = date != null ? _dateFmt.format(date) : '—';
                return HealthCard(
                  key: ValueKey('completed_${item.petId}_${item.id}'),
                  id: item.petId ?? "",
                  petMedicalHistoryId: item.id,
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

            // Upcoming Vaccinations
            VaccinationList(
              pagingController: pagingController1,
              itemBuilder: (context, item, index) {
                final date = item.treatmentDate?.toLocal();
                final dateText = date != null ? _dateFmt.format(date) : '—';
                return HealthCard(
                  key: ValueKey('pending_${item.petId}_${item.id}'),
                  id: item.petId ?? "",
                  petMedicalHistoryId: item.id,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FloatingActionButton(
            onPressed: () => showAddHealthDialog(
              context,
              widget.petId,           // keep using your screen's id
              pagingController1,   // PENDING list controller
              pagingController,    // COMPLETED list controller
            ),
            backgroundColor: const Color(0xFFE54D4D),
            shape: const CircleBorder(), // ensures round shape
            elevation: 4,
            tooltip: 'Add Record',
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),

    );
  }
}

/// Enhanced TabBar Delegate for sticky header
class _EnhancedTabBarDelegate extends SliverPersistentHeaderDelegate {
  _EnhancedTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + 8;

  @override
  double get maxExtent => _tabBar.preferredSize.height + 8;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: overlapsContent
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Column(
        children: [
          _tabBar,
          const Gap(8),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}