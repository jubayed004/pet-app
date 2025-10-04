import 'package:flutter/material.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_tab_selected/see_more_text.dart';
import 'package:pet_app/presentation/screens/business_owners/business_all_pets/widgets/custom_add_health_dialog.dart';

class HealthCard extends StatelessWidget {
  final String? petId;
  final String id;
  final String title;
  final String dateOfMonth;
  final String drName;
  final String treatmentDescription;
  final String status;
  final Color? statusColor;

  HealthCard({
    super.key,
    required this.id,
    required this.title,
    required this.dateOfMonth,
    required this.drName,
    required this.treatmentDescription,
    required this.status,
    this.statusColor,  this.petId,
  });

  final _businessAllPetController =
  GetControllers.instance.getBusinessAllPetController();

  // Map status → color (used if statusColor not provided)
  Color _resolveStatusColor(BuildContext context) {
    if (statusColor != null) return statusColor!;
    final s = status.toLowerCase();
    final scheme = Theme.of(context).colorScheme;
    if (s.contains('complete') || s == 'done') return scheme.primary;
    if (s.contains('pending') || s.contains('schedule')) return scheme.tertiary;
    if (s.contains('cancel') || s.contains('miss')) return const Color(0xFFE54D4D);
    return scheme.onSurfaceVariant;
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
    final onCard = Colors.black;


    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 10, bottom: 10,top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {}, // optional: open details
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min, // grow only as needed
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Title + Status pill
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xff5ED160)
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _StatusPill(
                    text: status,
                    color: resolvedStatusColor,
                    icon: _statusIcon(),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Info lines
              _MetaLine(icon: Icons.event, text: dateOfMonth, color: onCard),
              const SizedBox(height: 6),
              _MetaLine(icon: Icons.person, text: drName, color: onCard),
              if (treatmentDescription.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                _MetaLine(
                  icon: Icons.medical_information,
                  text: treatmentDescription,
                  color: onCard,
                  maxLines: 3,
                ),
              ],

              const SizedBox(height: 12),


              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      onPressed: () {
                        editAddHealthDialog(context: context, date: dateOfMonth, description: treatmentDescription, title: title, name: drName, id: id);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.delete, size: 18),
                      label: const Text('Delete'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFE54D4D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      onPressed: () {
                        defaultYesNoDialog(
                          context: context,
                          message: "Are you sure you want to delete this record?",
                          onYes: () {
                            _businessAllPetController.deletedHealthHistory(
                              id: petId ?? "",
                              status: status,
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
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({
    required this.icon,
    required this.text,
    this.maxLines = 1,
    this.color,
  });

  final IconData icon;
  final String text;
  final int maxLines;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: textColor),
        const SizedBox(width: 8),
        Expanded(
          child: ExpandableText(
            text: text,
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
    final bg = color.withOpacity(0.12);
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
