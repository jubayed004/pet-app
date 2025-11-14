import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_image/custom_image.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/no_internet/error_card.dart';
import 'package:pet_app/presentation/screens/business_owners/business_service/widgets/default_dialog.dart';
import 'package:pet_app/presentation/screens/category/model/category_item_model.dart';
import 'package:pet_app/presentation/screens/my_appointment/model/appointment_booking_model.dart';
import 'package:pet_app/presentation/screens/my_appointment/widgets/my_appointment_container.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_strings/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  final myAppointmentController = GetControllers.instance.getMyAppointmentController();
  final navController = GetControllers.instance.getNavigationControllerMain();

  @override
  void initState() {
    super.initState();
    myAppointmentController.pagingController1.addPageRequestListener((pageKey) {
      myAppointmentController.getAppointmentBooking(page: pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "My Appointment"),
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: () async {
                myAppointmentController.pagingController1.refresh();
              },
              child: PagedListView<int, BookingItem>(
                pagingController: myAppointmentController.pagingController1,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                builderDelegate: PagedChildBuilderDelegate<BookingItem>(
                  itemBuilder: (context, item, index) {
                    final appointmentId = item.id;
                    final bookingTime = item.bookingTime;
                    final serviceType = item.serviceId;
                    final shopLogo = serviceType?.shopLogo;
                    final serviceImage = serviceType?.servicesImages;
                    final phone = serviceType?.phone;
                    final address = serviceType?.location;
                    final bookingStatus = item.bookingStatus;
                    final selectedService = item.selectedService ?? "";
                    final bookingDate = DateFormat("dd MMMM yyyy").format(
                      (item.bookingDate ?? DateTime.now()).toLocal(),
                    );

                    return MyAppointmentContainer(
                      id: appointmentId ?? "",
                      petLogo: Assets.images.vet.image(width: 24),
                      serviceType: serviceType?.serviceType ?? "",
                      shopLogo: (shopLogo != null && shopLogo.isNotEmpty) ? shopLogo : "",
                      serviceImage: (serviceImage != null && serviceImage.isNotEmpty) ? serviceImage : "",
                      bookingDate: bookingDate,
                      bookingTime: bookingTime ?? "",
                      bookingStatus: bookingStatus ?? "",
                      selectedService: selectedService,
                      address: address ?? "",
                      phone: phone ?? "",
                      deletedOnTab: () {
                        defaultDeletedYesNoCencelDialog(
                          context: context,
                          title: 'Are you sure you want to Cancel this Appointment?',
                          id: appointmentId ?? "",
                          controller: myAppointmentController,
                        );
                      },
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return Center(
                      child: ErrorCard(
                        onTap: () => myAppointmentController.pagingController1.refresh(),
                        text: myAppointmentController.pagingController1.error.toString(),
                      ),
                    );
                  },
                  newPageErrorIndicatorBuilder: (context) {
                    return Center(
                      child: ErrorCard(
                        onTap: () => myAppointmentController.pagingController1.retryLastFailedRequest(),
                        text: myAppointmentController.pagingController1.error.toString(),
                      ),
                    );
                  },
                  // Empty state handling when no data is found
                  noItemsFoundIndicatorBuilder: (context) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No Appointments Found",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                          Gap(8),
                          Text(
                            textAlign: TextAlign.center,
                            "It seems you have no appointments yet. \nCheck back later!",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
