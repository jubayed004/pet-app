/*

import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';

class SettingNotificationCard extends StatefulWidget {
  const SettingNotificationCard({
    super.key,
    required this.text,
    required this.icons,
    required this.onTap,
  });

  final String text;
  final Widget icons;
  final VoidCallback onTap;

  @override
  State<SettingNotificationCard> createState() => _SettingNotificationCardState();
}

class _SettingNotificationCardState extends State<SettingNotificationCard> {
  bool status = false;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0,),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 24,

                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.icons,
                    Gap(10),
                    Flexible(
                      child: CustomText(
                        text: widget.text,
                        color: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
         FlutterSwitch(
           activeColor: AppColors.greenColor,
         activeTextColor: Colors.white,
         inactiveTextColor: Colors.grey.shade600,
         inactiveColor: Colors.grey.shade300,

         height: 32,
          width: 60,
          valueFontSize: 15.0,
          toggleSize: 25.0,
          value: status,
          borderRadius: 30.0,
          padding: 4.0,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),


            ],
          ),
        ),
      ),
    );
  }
}
*/
