import 'package:flutter/material.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class CategoryList extends StatelessWidget {
  final dynamic controller;
  const CategoryList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.iconList.length,
        padding: const EdgeInsets.only(left: 16, right: 10),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  shape: const CircleBorder(),
                  elevation: 3,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => AppRouter.route.pushNamed(
                      RoutePath.categoryScreen,
                      extra: index,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: controller.iconList[index],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: controller.stringList[index],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}