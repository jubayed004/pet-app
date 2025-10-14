import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class BusinessAllPetsScreen extends StatelessWidget {
  BusinessAllPetsScreen({super.key});

  final controller = GetControllers.instance.getBusinessAllPetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.getBusinessAllPets(),
        child: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "All Pets"),
            Obx(() => _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final state = controller.loading.value;
    final pets = controller.profile.value.pets ?? [];

    if (state == Status.loading) {
      return SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (pets.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) => _PetCard(pet: pets[index]),
          childCount: pets.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.pets_outlined, size: 80, color: Colors.grey[300]),
        Gap(16),
        Text(
          "No pets found",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Gap(8),
        Text(
          "Add your first pet to get started",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

class _PetCard extends StatelessWidget {
  final dynamic pet;

  const _PetCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.route.pushNamed(
        RoutePath.businessPetsDetailsScreen,
        extra: pet.id ?? "",
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildAvatar(),
            Gap(12),
            Expanded(child: _buildInfo()),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasPhoto = pet.petPhoto != null && pet.petPhoto!.isNotEmpty;

    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: hasPhoto
            ? null
            : LinearGradient(
          colors: [Colors.blue[300]!, Colors.purple[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: hasPhoto
            ? DecorationImage(
          image: NetworkImage(pet.petPhoto!),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: hasPhoto
          ? null
          : Icon(Icons.pets, color: Colors.white, size: 28),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pet.name ?? "Unknown",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (pet.breed != null && pet.breed!.isNotEmpty) ...[
          Gap(4),
          Text(
            pet.breed!,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}