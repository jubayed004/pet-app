import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // For date formatting
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

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
        onRefresh: ()async{
          notifyController.getNotify();
        },
        child: CustomScrollView(
          slivers: [
            Obx(() {
              final item = notifyController.notify.value.data ?? [];
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final notification = item[index];
                    final title = notification.title ?? "No Title";
                    final  time = DateFormat(
                      "dd MMMM yyyy",
                    ).format(notification.time ?? DateTime.now());

                    return Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.purple500),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          title: CustomText(
                            text: title,
                            textAlign: TextAlign.start,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          subtitle: CustomText(
                            text: time,  // Format the date and time dynamically
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
