import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class VaccinationList extends StatelessWidget {
  const VaccinationList({super.key, required this.pagingController, required this.itemBuilder, required this.emptyText});

  final PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController;
  final Widget Function(BuildContext, PetMedicalHistoryByTreatmentStatus, int) itemBuilder;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, PetMedicalHistoryByTreatmentStatus>.separated(
      padding: padding14H,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<PetMedicalHistoryByTreatmentStatus>(
        itemBuilder: (ctx, item, index) => itemBuilder(ctx, item, index),
        firstPageProgressIndicatorBuilder: (_) => const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
        newPageProgressIndicatorBuilder: (_) => const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
        noItemsFoundIndicatorBuilder: (_) => Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(emptyText))),
        firstPageErrorIndicatorBuilder:
            (ctx) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Something went wrong.'),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: () => pagingController.refresh(), child: const Text('Retry')),
                ],
              ),
            ),
        newPageErrorIndicatorBuilder:
            (ctx) => Center(child: TextButton(onPressed: () => pagingController.retryLastFailedRequest(), child: const Text('Tap to retry'))),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }
}
