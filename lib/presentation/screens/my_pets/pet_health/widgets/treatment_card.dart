import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/category/controller/category_controller.dart';
import 'package:pet_app/presentation/screens/my_pets/pet_health/controller/pet_health_controller.dart';
import 'package:pet_app/presentation/screens/my_pets/pet_health/model/pet_health_model.dart';

import 'health_history_card.dart';

class TreatmentCard extends StatefulWidget {
  final String id;
  final String status;
  final PetHealthController controller;

  const TreatmentCard({
    super.key,
    required this.controller,
    required this.id,
    required this.status,
  });

  @override
  State<TreatmentCard> createState() => _TreatmentCardState();
}

class _TreatmentCardState extends State<TreatmentCard> {
  final pagingController = PagingController<int, HealthHistoryItem>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      widget.controller.getHealth(
        page: pageKey,
        pagingController: pagingController,
        id: widget.id,
        status: widget.status,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: RefreshIndicator(
        onRefresh: () async {
          pagingController.refresh();
        },
        child: PagedListView<int, HealthHistoryItem>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<HealthHistoryItem>(
            itemBuilder: (context, item, index) {
              return HealthHistoryCard(
                controller: widget.controller,
                item: item,
              );
            },

            /// First page error
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: ErrorCard(
                onTap: () => pagingController.refresh(),
                text: pagingController.error?.toString() ?? "Error loading data",
              ),
            ),

            /// First page no items (empty)
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: Text(
                "No medical history found",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),

            /// Loading indicator
            firstPageProgressIndicatorBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),

            newPageProgressIndicatorBuilder: (context) => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


