import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

class BookAnAppointmentScreen extends StatelessWidget {
  const BookAnAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomDefaultAppbar(
            title: "Book an Appointment",
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: CustomAlignText(text: "Choose a Date",fontWeight: FontWeight.w500,fontSize: 21,),
            ),
          )
        ],
      ),
    );
  }
}
