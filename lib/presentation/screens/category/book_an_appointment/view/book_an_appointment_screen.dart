import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/screens/category/book_an_appointment/widgets/custom_selling_calender_widget.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class BookAnAppointmentScreen extends StatelessWidget {
  BookAnAppointmentScreen({super.key, required this.bookingTime});
final bool bookingTime;
  final controller = GetControllers.instance.getBookAnAppointmentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            backgroundColor: Colors.white,
            title: "Book an Appointment",
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                children: [
                  CustomAlignText(
                    text: "Choose a Date",
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                  CustomCalendar(),
                  Gap(24),
                  CustomAlignText(
                    text: "Pick a Time",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          SliverGap(16),
          bookingTime ? SliverToBoxAdapter(
            child: Padding(
              padding: padding16H,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Arrival time",fontWeight: FontWeight.w500,fontSize: 14,),
                  CustomText(text: "Receipt time",fontWeight: FontWeight.w500,fontSize: 14)
                ],
              ),
            ),
          ):SliverToBoxAdapter(),
          SliverGap(16),
          Obx(
            () => SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.9,
              children: List.generate(6, (index) {
                final isSelected = controller.selectedIndex.value == index;

                return GestureDetector(
                  onTap: () {
                    controller.selectIndex(index);
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFFB5ED90) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        text: "9:30",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SliverGap(24),
          SliverToBoxAdapter(
            child: Padding(
              padding: padding16H,
              child: CustomButton(onTap: () {
                AppRouter.route.pushNamed(RoutePath.congratulationScreen);
              }, title: "Book an Appointment ",textColor: Colors.black,),
            ),
          ),
          SliverGap(24),
        ],
      ),
    );
  }
}
