import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/subscription/controller/subscription_controller.dart';

class SubscriptionHeader extends StatelessWidget {
  final VoidCallback onClose;
  final SubscriptionController controller;

  const SubscriptionHeader({
    super.key,
    required this.onClose,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, size: 28),
            onPressed: onClose,
            color: Colors.black54,
          ),
          Obx(() {
            if (controller.isRestoring.value) {
              return const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            }
            return TextButton(
              onPressed: () => controller.restorePurchases(),
              child: const Text(
                'Restore',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            );
          }),
        ],
      ),
    );
  }
}
