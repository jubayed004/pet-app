import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_button/custom_button.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class EmptyOrErrorSliver extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String primaryActionLabel;
  final Future<void> Function() onRetry;
  final Widget? secondary;

  const EmptyOrErrorSliver({
    super.key,
    required this.title,
    this.subtitle,
    this.primaryActionLabel = "Try again",
    required this.onRetry,
    this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.pets, size: 48),
              const Gap(8),
              const SizedBox(height: 4),
              CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const Gap(6),
                CustomText(
                  text: subtitle!,
                  fontSize: 13,
                  color: Colors.black54,
                  textAlign: TextAlign.center,
                ),
              ],
              const Gap(12),
              SizedBox(
                width: 160,
                child: CustomButton(
                  title: primaryActionLabel,
                  onTap: onRetry,
                  height: 36,
                ),
              ),
              if (secondary != null) secondary!,
            ],
          ),
        ),
      ),
    );
  }
}
