import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/category/controller/category_controller.dart';
import 'package:pet_app/presentation/screens/category/model/category_model.dart';

import 'category_card_widget.dart';

class VetWidget extends StatefulWidget {
  const VetWidget({super.key, required this.index, required this.controller});

  final int index;
  final CategoryController controller;

  @override
  State<VetWidget> createState() => _VetWidgetState();
}

class _VetWidgetState extends State<VetWidget> {
  final pagingController = PagingController<int, CategoryServiceItem>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      widget.controller.getCategoryService(
        page: pageKey,
        pagingController: pagingController,
        type: "VET",
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: RefreshIndicator(
        onRefresh: () async{
          pagingController.refresh();
        },
        child: PagedListView<int, CategoryServiceItem>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<CategoryServiceItem>(
            itemBuilder: (context, item, itemIndex) {
              return CategoryCardWidget(
                item: item,
                showWebsite: widget.index == 1 || widget.index == 3,
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
