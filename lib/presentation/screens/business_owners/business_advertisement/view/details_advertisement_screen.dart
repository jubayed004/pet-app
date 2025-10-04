import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_netwrok_image/custom_network_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/service/api_url.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/app_const.dart';

class DetailsAdvertisementScreen extends StatefulWidget {
  const DetailsAdvertisementScreen({super.key});

  @override
  State<DetailsAdvertisementScreen> createState() => _DetailsAdvertisementScreenState();
}

class _DetailsAdvertisementScreenState extends State<DetailsAdvertisementScreen> {

  @override
  void initState() {
    controller.getDetailsAdvertisement();
    super.initState();
  }
  final controller = GetControllers.instance.getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: "Details Advertisements",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            labelColor: AppColors.purple500,
            unselectedLabelColor: Colors.pink,
            indicatorColor: Colors.red,
            tabs: [
              Tab(child: CustomText(text: "Inactive", fontSize: 14, fontWeight: FontWeight.w500)),
              Tab(child: CustomText(text: "Active", fontSize: 14, fontWeight: FontWeight.w500)),

            ],
          ),
        ),
        body: Obx(() {
          /// 🔥 Loader Handling Here
          if (controller.loading.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.loading.value == Status.error) {
            return const Center(child: CustomText(
              text: "Something went wrong!",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ));
          }

          if (controller.loading.value == Status.internetError) {
            return const Center(child: CustomText(
              text: "Internet Error!",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ));
          }

          if (controller.loading.value == Status.noDataFound) {
            return const Center(child: CustomText(
              text: "No data found",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ));
          }

          /// ✅ If data loaded successfully
          return TabBarView(
            children: [
               InactiveTab(),
              ActiveTab(),

            ],
          );
        }),
      ),
    );
  }
}


class ActiveTab extends StatelessWidget {
  ActiveTab({super.key});
  final controller = GetControllers.instance.getBusinessAdvertisementController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        final advertisements = controller.profile.value.advertisement ?? [];
        final activeAdvertisements = advertisements
            .where((ad) => ad.status == "ACTIVE")
            .toList();
        if (activeAdvertisements.isEmpty) {
          return const CustomText(
            text: "No active advertisements available",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          );
        }
        return ListView.builder(
          itemCount: activeAdvertisements.length,
          itemBuilder: (context, imageIndex) {
            final image = activeAdvertisements[imageIndex].advertisementImg;
            if (image != null && image.isNotEmpty) {
              // Format the image URL
              final imageUrl = image.first;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomNetworkImage(
                  imageUrl: imageUrl,
                  height: 200,
                  width: 100,
                ),
              );
            } else {
              return const SizedBox(); // Return an empty widget if no image
            }
          },
        );
      }),
    );
  }

  String _getImageUrl(String image) {
    final baseUrl = ApiUrl.imageBase.endsWith('/') ? ApiUrl.imageBase : '${ApiUrl.imageBase}/';
    return '$baseUrl${image.replaceAll('\\', '/')}';
  }
}


class InactiveTab extends StatelessWidget {
  const InactiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        final controller = GetControllers.instance.getBusinessAdvertisementController();
        final advertisements = controller.profile.value.advertisement ?? [];

        // Filter advertisements with status "INACTIVE"
        final inactiveAdvertisements = advertisements
            .where((ad) => ad.status == "INACTIVE")
            .toList();

        if (inactiveAdvertisements.isEmpty) {
          return const CustomText(
            text: "No inactive advertisements available",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          );
        }

        return ListView.builder(
          itemCount: inactiveAdvertisements.length,
          itemBuilder: (context, imageIndex) {
            final image = inactiveAdvertisements[imageIndex].advertisementImg;
            if (image != null && image.isNotEmpty) {
              final imageUrl = image.first;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomNetworkImage(
                  imageUrl: imageUrl,
                  height: 200,
                  width: 100,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      }),
    );
  }

}
