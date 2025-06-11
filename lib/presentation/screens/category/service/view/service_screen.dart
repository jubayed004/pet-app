import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomDefaultAppbar(title: "Service",),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16,top: 24),
                child: Column(
                  children: [


                 CustomAlignText(text: "Selected your service",fontWeight: FontWeight.w500,fontSize: 18,),
                    Gap(16),
                    Row(
                      children: [
                        CustomText(text: "General Health Exams",fontSize: 14,fontWeight: FontWeight.w500,),


                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}
