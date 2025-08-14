import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  final controller = GetControllers.instance.getFaqController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  CustomScrollView(
        slivers: [
          CustomDefaultAppbar(title: "FAQs"),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            sliver: Obx(() {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final faqItem = controller.faqData.value.faqs?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: EasyFaq(
                        backgroundColor: Colors.white,
                        question: faqItem?.question ?? "No Question",
                        answer: faqItem?.answer ?? "No Answer",
                        anserTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff2A2A2A),
                        ),
                      ),
                    );
                  },
                  childCount: controller.faqData.value.faqs?.length ?? 0,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }


}
