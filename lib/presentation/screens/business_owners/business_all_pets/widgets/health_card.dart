import 'package:flutter/material.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String dateOfMonth;
  final String drName;
  final String status;
  final Color? statusColor;
  const HealthCard({super.key, required this.title, required this.dateOfMonth, required this.drName, required this.status, this.statusColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            dateOfMonth,
            style: TextStyle(color: Colors.black54),
          ),
          Text(
            drName,
            style: TextStyle(color: Colors.black54),
          ),
          Text(
            status,
            style: TextStyle(color: statusColor,fontSize: 16,fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  defaultYesNoDialog(
                    context: context,
                    message: "Are you sure you want to delete this record?",
                    onYes: () {

                    },
                  );
                },
                icon: const Icon(Icons.delete, color: Color(0xFFE54D4D)),
              ),

              IconButton(
                onPressed: () {
                  editAddHealthDialog(context); // 👈 Show the dialog
                },
                icon: Icon(Icons.edit, color: Color(0xFFE54D4D)),
              ),

            ],
          ),
        ],
      ),
    );
  }
}