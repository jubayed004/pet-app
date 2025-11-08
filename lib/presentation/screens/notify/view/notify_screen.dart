import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/no_internet/more_data_error_card.dart';
import 'package:pet_app/presentation/no_internet/no_data_card.dart';
import 'package:pet_app/presentation/no_internet/no_internet_card.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class NotifyScreen extends StatelessWidget {
  NotifyScreen({super.key});

  final notifyController = GetControllers.instance.getNotifyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(
          text: "Notification",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await notifyController.getNotify();
        },
        child: Obx(() {
          final item = notifyController.notify.value.data ?? [];
          final status = notifyController.loading.value;

          switch (status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.error:
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: ErrorCard(
                        onTap: () => notifyController.getNotify(),
                      ),
                    ),
                  ),
                ],
              );

            case Status.internetError:
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: NoInternetCard(
                        onTap: () => notifyController.getNotify(),
                      ),
                    ),
                  ),
                ],
              );

            case Status.noDataFound:
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: MoreDataErrorCard(
                        onTap: () => notifyController.getNotify(),
                      ),
                    ),
                  ),
                ],
              );

            case Status.completed:
              if (item.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: NoDataCard(
                          onTap: () => notifyController.getNotify(),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final notification = item[index];
                        final title = notification.title ?? "No Title";
                        final time = DateFormat("dd MMMM yyyy").format(
                          notification.time ?? DateTime.now(),
                        );

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Card(
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.purple500),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ListTile(
                              title: CustomText(
                                text: title,
                                textAlign: TextAlign.start,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: CustomText(
                                text: time,
                                textAlign: TextAlign.start,
                              ),
                              leading: CircleAvatar(
                                child: Assets.images.splashlogo.image(),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: item.length,
                    ),
                  ),
                ],
              );
          }
        }),
      ),
    );
  }
}
