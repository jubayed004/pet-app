import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/model/business_medical_history_model.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';

class HealthCard extends StatelessWidget {
  final String? petMedicalHistoryId;
  final String id;
  final String title;
  final String dateOfMonth;
  final String drName;
  final String treatmentDescription;
  final String status;
  final Color? statusColor;
  final PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController1;
  final PagingController<int, PetMedicalHistoryByTreatmentStatus> pagingController;

  HealthCard({
    super.key,
    required this.id,
    required this.title,
    required this.dateOfMonth,
    required this.drName,
    required this.treatmentDescription,
    required this.status,
    this.statusColor,
    this.petMedicalHistoryId,
    required this.pagingController1,
    required this.pagingController,
  });

  final _businessAllPetController = GetControllers.instance.getBusinessAllPetController();

  Color _resolveStatusColor(BuildContext context) {
    if (statusColor != null) return statusColor!;
    final s = status.toLowerCase();
    if (s.contains('complete') || s == 'done') return const Color(0xFF5ED160);
    if (s.contains('pending') || s.contains('schedule')) return const Color(0xFFFFA726);
    if (s.contains('cancel') || s.contains('miss')) return const Color(0xFFE54D4D);
    return Colors.grey;
  }

  IconData _statusIcon() {
    final s = status.toLowerCase();
    if (s.contains('complete') || s == 'done') return Icons.check_circle_rounded;
    if (s.contains('pending') || s.contains('schedule')) return Icons.schedule_rounded;
    if (s.contains('cancel') || s.contains('miss')) return Icons.error_rounded;
    return Icons.info_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedStatusColor = _resolveStatusColor(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 6,
      ),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  resolvedStatusColor.withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and status
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Color(0xFF2C3E50),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(4),
                            Text(
                              'Treatment Record',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                      _StatusPill(
                        text: status,
                        color: resolvedStatusColor,
                        icon: _statusIcon(),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  const Gap(16),

                  // Information rows
                  _InfoTile(
                    icon: Icons.calendar_today,
                    label: 'Date',
                    value: dateOfMonth,
                    iconColor: Colors.blue,
                  ),
                  const Gap(12),
                  _InfoTile(
                    icon: Icons.medical_services,
                    label: 'Doctor',
                    value: drName,
                    iconColor: Colors.purple,
                  ),

                  if (treatmentDescription.trim().isNotEmpty) ...[
                    const Gap(12),
                    _InfoTile(
                      icon: Icons.description,
                      label: 'Description',
                      value: treatmentDescription,
                      iconColor: Colors.orange,
                      isExpandable: true,
                    ),
                  ],

                  const Gap(20),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF2C3E50),
                            side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onPressed: () {
                            editAddHealthDialog(
                              context: context,
                              date: dateOfMonth,
                              description: treatmentDescription,
                              title: title,
                              name: drName,
                              id: petMedicalHistoryId ?? "",
                              pagingController1: pagingController1,
                              pagingController: pagingController,
                            );
                          },
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE54D4D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onPressed: () {
                            defaultYesNoDialog(
                              context: context,
                              message: "Are you sure you want to delete this record?",
                              onYes: () {
                                _businessAllPetController.deletedHealthHistory(
                                  id: petMedicalHistoryId ?? "",
                                  status: status,
                                  pagingController: pagingController,
                                  pagingController1: pagingController1,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.isExpandable = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final bool isExpandable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(4),
              isExpandable
                  ? ExpandableText(text: value)
                  : Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.text,
    required this.color,
    required this.icon,
  });

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const Gap(6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}