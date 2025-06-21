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

  final String phoneNumber = '12124567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return CustomScrollView(
          slivers: [
       CustomDefaultAppbar(title: "FAQs"),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final faqItem = controller.faqData.value.data?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: EasyFaq(
                        backgroundColor: Colors.white,
                        question: faqItem?.question ?? "No Question",
                        answer: faqItem?.description ?? "No Answer",
                        anserTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff2A2A2A),
                        ),
                      ),
                    );
                  },
                  childCount: controller.faqData.value.data?.length ?? 0,
                ),
              ),
            ),
            SliverToBoxAdapter(child: Gap(20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: "Need More Help?",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SliverToBoxAdapter(child: Gap(16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => _openDialScreen(context, phoneNumber),
                    child: ListTile(
                      leading: Assets.icons.chaticon.svg(),
                      title: const Text("Call Us (+1-212-456-7890)"),
                      subtitle: const Text("Our help line service is active: 24/7"),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Gap(20)),
          ],
        );
      }),
    );
  }

  Future<void> _openDialScreen(BuildContext context, String phoneNumber) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(dialUri)) {
        bool launched = await launchUrl(dialUri, mode: LaunchMode.externalApplication);
        if (!launched) {
          _showErrorDialog(context, "Dialer app found but failed to open.");
        }
      } else {
        _showErrorDialog(context, "No dialer app found on this device.");
      }
    } catch (e) {
      _showErrorDialog(context, "Error: ${e.toString()}");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
