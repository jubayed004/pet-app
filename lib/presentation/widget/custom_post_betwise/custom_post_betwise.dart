/*
import 'package:betwise_app/core/custom_assets/assets.gen.dart';
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:betwise_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomPostWidget extends StatelessWidget {
  final String timeAgo;
  final String matchTitle;
  final String predictions;
  final String analystLabel;
  final Widget? image;


  CustomPostWidget({
    required this.timeAgo,
    required this.matchTitle,
    required this.predictions,
    required this.analystLabel,
    required this.image,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomHeader(timeAgo: timeAgo),
        Gap(16),
        image ?? SizedBox(),
        Gap(16),
        _PredictionSection(predictions: predictions, analystLabel: analystLabel, matchTitle: matchTitle),
      ],
    );
  }
}

class _CustomHeader extends StatelessWidget {
  final String timeAgo;

  _CustomHeader({required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.bitwisepicksimage.image(height: 36),
        CustomText(
          text: timeAgo,
          color: AppColors.secondTextColor,
          fontSize: 12,
        ),
      ],
    );
  }
}

class _PredictionSection extends StatelessWidget {
  final String predictions;
  final String analystLabel;
  final String matchTitle;

  _PredictionSection({
    required this.predictions,
    required this.analystLabel,
    required this.matchTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MatchRow(matchTitle: matchTitle),
        Gap(16),
        _PredictionDetails(predictions: predictions),
        Gap(16),
        _GoldAnalystRow(analystLabel: analystLabel),
      ],
    );
  }
}

class _MatchRow extends StatelessWidget {
  final String matchTitle;

  _MatchRow({required this.matchTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.icons.vs.svg(),
        Gap(6),
        Expanded(
          child: CustomText(
            text: matchTitle,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class _PredictionDetails extends StatelessWidget {
  final String predictions;

  _PredictionDetails({required this.predictions});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.icons.prediction.svg(),
        Gap(6),
        CustomText(text: predictions)
      ],
    );
  }
}

class _GoldAnalystRow extends StatelessWidget {
  final String analystLabel;

  _GoldAnalystRow({required this.analystLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.icons.statsBadges.svg(),
        Gap(6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "Stats & Badges"),
            Gap(10),
            _GoldAnalyst(analystLabel: analystLabel),
          ],
        ),
      ],
    );
  }
}

class _GoldAnalyst extends StatelessWidget {
  final String analystLabel;

  _GoldAnalyst({required this.analystLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Color(0xffFEF3C7),
        border: Border.all(
          color: Color(0xffF59E0B),
        ),
      ),
      child: CustomText(
        text: analystLabel,
        color: Color(0xffF59E0B),
      ),
    );
  }
}

*/
