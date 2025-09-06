import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/category/controller/category_controller.dart';
import 'package:pet_app/presentation/screens/pet_health/controller/pet_health_controller.dart';
import 'package:pet_app/presentation/screens/pet_health/model/pet_health_model.dart';

import 'health_history_card.dart';

class TreatmentCard extends StatefulWidget {
  final String id;

  final PetHealthController controller;
   const TreatmentCard({super.key, required this.controller, required this.id});

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
        status: "HOTEL",
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: RefreshIndicator(
        onRefresh: () async{
          pagingController.refresh();
        },
        child: PagedListView<int, HealthHistoryItem>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<HealthHistoryItem>(
            itemBuilder: (context, item, itemIndex) {
              return HealthHistoryCard(controller: widget.controller, item: item,

              );
            },
            firstPageErrorIndicatorBuilder:
                (context) => Center(
              child: ErrorCard(
                onTap: () => pagingController.refresh(),
                text: pagingController.error.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
