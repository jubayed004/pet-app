import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/core/route/route_path.dart';
import 'package:pet_app/core/route/routes.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/presentation/widget/align/custom_align_text.dart';

class ServiceScreen extends StatefulWidget {
   ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<String> choiceOfTopCookies = [
    "General Health Exams",
    "Vaccinations & Immunizations",
    "Parasite Prevention & Treatment (fleas, ticks, worms)",
    "Spaying & Neutering",
    "Emergency Care",
    "Peanut Butter",
    "Extras ",

  ];

   int choiceOfTopCookie = 1;

   int choiceOfBottomCookie = 1;

   int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ...List.generate(
              choiceOfTopCookies.length,
              (index) => RoundedCheckboxListTile(
              isActive: index == choiceOfTopCookie,
              text: choiceOfTopCookies[index],
              press: () {
                setState(() {
                  choiceOfTopCookie = index;
                });
              },
            )),
                    Gap(24),
                    CustomButton(onTap: (){

                      AppRouter.route.pushNamed(RoutePath.bookAnAppointmentScreen);
                    },title: "Book an Appointment ",textColor: Colors.black,icon: Icon(Icons.calendar_month_outlined,color: Colors.black,),showIcon: true,)
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}
class SmallDot extends StatelessWidget {
  const SmallDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}

class RoundedCheckboxListTile extends StatelessWidget {
  const RoundedCheckboxListTile({
    super.key,
    this.isActive = false,
    required this.press,
    required this.text,
  });

  final bool isActive;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                CircleCheckBox(isActive: isActive),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF010F07).withOpacity(0.84),
                        height: 1,
                    overflow: TextOverflow.ellipsis
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 24,
      width: 24,
      padding: EdgeInsets.all(isActive ? 3 : 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? const Color(0xFF22A45D).withOpacity(0.54)
              : const Color(0xFF868686).withOpacity(0.54),
          width: 0.8,
        ),
      ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFF22A45D),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
