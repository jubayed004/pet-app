import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';

class VaccinationList extends StatelessWidget {
  const VaccinationList({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.emptyText,
  });

  final PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController;
  final Widget Function(BuildContext, PetMedicalHistoryByTreatmentStatus, int) itemBuilder;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, PetMedicalHistoryByTreatmentStatus>(
      pagingController: pagingController,
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      builderDelegate: PagedChildBuilderDelegate<PetMedicalHistoryByTreatmentStatus>(
        itemBuilder: (ctx, item, index) => itemBuilder(ctx, item, index),

        // First page loading
        firstPageProgressIndicatorBuilder: (_) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: const Color(0xFFE54D4D),
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading records...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Next page loading
        newPageProgressIndicatorBuilder: (_) => Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: const Color(0xFFE54D4D),
            strokeWidth: 2.5,
          ),
        ),

        // No items found
        noItemsFoundIndicatorBuilder: (_) => _buildEmptyState(context),

        // First page error
        firstPageErrorIndicatorBuilder: (ctx) => _buildErrorState(
          context,
          onRetry: () => pagingController.refresh(),
        ),

        // Next page error
        newPageErrorIndicatorBuilder: (ctx) => Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Failed to load more items',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () => pagingController.retryLastFailedRequest(),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFE54D4D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medical_information_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              emptyText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No vaccination records available at the moment',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, {required VoidCallback onRetry}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load vaccination records',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE54D4D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}