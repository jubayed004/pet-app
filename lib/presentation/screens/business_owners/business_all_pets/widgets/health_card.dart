import 'package:flutter/material.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class HealthCard extends StatelessWidget {
  final String id;
  final String title;
  final String dateOfMonth;
  final String drName;
  final String status;
  final Color? statusColor;

  HealthCard({
    super.key,
    required this.title,
    required this.dateOfMonth,
    required this.drName,
    required this.status,
    this.statusColor,
    required this.id,
  });

  final businessAllPetController =
      GetControllers.instance.getBusinessAllPetController();

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.white,
      margin: EdgeInsets.only(right: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1, // This adds a shadow effect
      child: Padding(
        padding: EdgeInsets.all( 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                dateOfMonth,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Flexible(
              child: Text(
                drName,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Flexible(
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      defaultYesNoDialog(
                        context: context,
                        message: "Are you sure you want to delete this record?",
                        onYes: () {
                          businessAllPetController.deletedHealthHistory(
                            id: id,
                            status: status,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete, color: Color(0xFFE54D4D)),
                  ),
                  IconButton(
                    onPressed: () {
                      editAddHealthDialog(context,dateOfMonth,title, drName,id); // 👈 Show the dialog
                    },
                    icon: Icon(Icons.edit, color: Color(0xFFE54D4D)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
