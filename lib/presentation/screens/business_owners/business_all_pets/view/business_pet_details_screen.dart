import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessPetsDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessPetsDetailsScreen({super.key, required this.id});

  @override
  State<BusinessPetsDetailsScreen> createState() => _BusinessPetsDetailsScreenState();
}

class _BusinessPetsDetailsScreenState extends State<BusinessPetsDetailsScreen> {
  final businessAllPetController = GetControllers.instance.getBusinessAllPetController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await businessAllPetController.businessPetDetails(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: CustomText(fontWeight: FontWeight.w600, fontSize: 16, text: "Pet Details"),
      ),
      backgroundColor: AppColors.kWhiteColor,
      body: Obx(() {
        final isLoading = businessAllPetController.detailsLoading.value == Status.loading;
        final hasError = businessAllPetController.detailsLoading.value == Status.error;
        final noData = businessAllPetController.detailsLoading.value == Status.noDataFound;

        if (isLoading) {
          return _buildLoadingState();
        }

        if (hasError) {
          return _buildErrorState();
        }

        if (noData) {
          return _buildNoDataState();
        }

        final pet = businessAllPetController.details.value.petWithMedicalHistory;

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildPetImageSection(context, pet?.petPhoto, screenHeight),
              ),
          
              // Main Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPetInfoCard(pet, screenWidth),
                      const Gap(20),
                      _buildAboutSection(pet, screenWidth),
                      const Gap(20),
                      _buildHealthSection(context, screenWidth),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: const Color(0xFFE54D4D),
            strokeWidth: 3,
          ),
          const Gap(20),
          const Text(
            'Loading pet details...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
            ),
            const Gap(20),
            const Text(
              'Failed to load pet details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            Text(
              'Something went wrong. Please try again.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            ElevatedButton.icon(
              onPressed: () {
                businessAllPetController.businessPetDetails(id: widget.id);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE54D4D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pets,
                size: 64,
                color: Colors.grey,
              ),
            ),
            const Gap(20),
            const Text(
              'Pet not found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(8),
            Text(
              'This pet doesn\'t exist or has been removed.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE54D4D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImageSection(BuildContext context, String? petPhoto, double screenHeight) {
    final image = (petPhoto != null && petPhoto.isNotEmpty)
        ? petPhoto
        : 'https://images.unsplash.com/photo-1601758123927-196d5f3f6bb0?auto=format&fit=crop&w=800&q=80';

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.pets, size: 80, color: Colors.grey),
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
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPetInfoCard(dynamic pet, double screenWidth) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE54D4D),
                    const Color(0xFFE54D4D).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE54D4D).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.pets, size: 32, color: Colors.white),
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
                    fontSize: 22,
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.purple500.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          pet?.gender?.toLowerCase() == 'male' ? Icons.male : Icons.female,
                          size: 20,
                          color: AppColors.purple500,
                        ),
                      ),
                      const Gap(6),
                      CustomText(
                        text: pet?.gender ?? "Unknown",
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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

  Widget _buildAboutSection(dynamic pet, double screenWidth) {
    final details = [
      if (pet?.age != null) {'icon': Icons.cake, 'title': 'Age', 'value': '${pet?.age} years', 'color': Colors.orange},
      if (pet?.animalType != null) {'icon': Icons.category, 'title': 'Type', 'value': pet?.animalType, 'color': Colors.blue},
      if (pet?.breed != null) {'icon': Icons.pets, 'title': 'Breed', 'value': pet?.breed, 'color': Colors.purple},
      if (pet?.height != null) {'icon': Icons.height, 'title': 'Height', 'value': '${pet?.height} cm', 'color': Colors.green},
      if (pet?.weight != null) {'icon': Icons.monitor_weight, 'title': 'Weight', 'value': '${pet?.weight} kg', 'color': Colors.teal},
      if (pet?.color != null) {'icon': Icons.color_lens, 'title': 'Color', 'value': pet?.color, 'color': Colors.pink},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.info_outline, size: 22, color: Colors.white),
            ),
            const Gap(10),
            const CustomText(
              text: "About Pet",
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ],
        ),
        const Gap(16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: details.map((detail) {
            return Container(
              width: (screenWidth - 56) / 2,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey[300]!, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (detail['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      detail['icon'] as IconData,
                      size: 22,
                      color: detail['color'] as Color,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    detail['title'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    detail['value'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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

  Widget _buildHealthSection(BuildContext context, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE54D4D).withValues(alpha: 0.15),
            const Color(0xFFE54D4D).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE54D4D).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE54D4D), Color(0xFFFF6B6B)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE54D4D).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.health_and_safety, size: 28, color: Colors.white),
              ),
              const Gap(12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Health Records",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    Gap(4),
                    Text(
                      'View and manage vaccinations',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                AppRouter.route.pushNamed(RoutePath.healthRecordsScreen, extra: widget.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE54D4D),
                foregroundColor: Colors.white,
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.arrow_forward, size: 20),
              label: const Text(
                'View Health Records',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerInfoSection(dynamic pet, double screenWidth) {
    if (pet?.ownerName == null && pet?.ownerEmail == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.indigo.withValues(alpha: 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person, size: 22, color: Colors.white),
              ),
              const Gap(10),
              const CustomText(
                text: "Owner Information",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ],
          ),
          const Gap(16),
          if (pet?.ownerName != null) ...[
            _buildInfoRow(Icons.person_outline, 'Name', pet?.ownerName ?? '—'),
            const Gap(12),
          ],
          if (pet?.ownerEmail != null)
            _buildInfoRow(Icons.email_outlined, 'Email', pet?.ownerEmail ?? '—'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}