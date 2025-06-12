import 'package:flutter/material.dart';

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
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF010F07).withOpacity(0.84),
                      height: 1),
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

class RequiredSectionTitle extends StatelessWidget {
  const RequiredSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
              color: const Color(0xFFEF9920).withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Text(
            "Required".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: const Color(0xFFEF9920)),
          ),
        )
      ],
      );
  }
}