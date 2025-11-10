import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/core/custom_assets/assets.gen.dart';
import 'package:pet_app/helper/image/network_image.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';

class CustomBookingCard extends StatelessWidget {
  const CustomBookingCard({
    super.key,
    required this.index,
    required this.logoPath,
    required this.topTitle,
    required this.imagePath,
    required this.visitingDate,
    required this.mainTitle,


    required this.phoneNumber,
    required this.address,
    this.onApprove,
    this.onReject,
    this.showApproveButton = false,
    this.showRejectButton = false,
    this.approveText,
    this.rejectText,
    this.bookingTime,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
  });
  final int index;
  final String logoPath;
  final String topTitle;
  final String imagePath;
  final String visitingDate;
  final String? bookingTime;
  final String? checkInDate;
  final String? checkInTime;
  final String? checkOutDate;
  final String? checkOutTime;
  final String mainTitle;


  final String phoneNumber;
  final String address;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final bool showApproveButton;
  final bool showRejectButton;
  final String? approveText;
  final String? rejectText;
  bool get _isUrlLogo =>
      logoPath.startsWith('http://') ||
          logoPath.startsWith('https://') ||
          logoPath.startsWith('www.');
  bool get _isSvgLogo =>
      _isUrlLogo && logoPath.toLowerCase().trim().endsWith('.svg');
  String get _defaultApproveText {
    if (index == 1) return 'Complete'; // Ongoing tab
    if (index == 0) return 'Approve';  // Pending tab
    return 'Approve';
  }
  String get _defaultRejectText => 'Reject';
  SvgPicture _getIconByService({required String name}) {
    switch (name.toUpperCase()) {
      case "VET":
        return Assets.icons.petvets.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
      case "SHOP":
        return Assets.icons.petshops.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
      case "GROOMING":
        return Assets.icons.petgrooming.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
      case "HOTEL":
        return Assets.icons.pethotel.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
      case "TRAINING":
        return Assets.icons.pettraining.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
      case "FRIENDLY":
      default:
        return Assets.icons.friendlyplace.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          width: 22, height: 22,
        );
    }
  }
  Widget _buildLogo() {
    // If URL provided, load it; otherwise map by service key.
    if (_isUrlLogo) {
      if (_isSvgLogo) {
        return SvgPicture.network(
          logoPath,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          placeholderBuilder: (context) => const SizedBox(
            height: 22, width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CustomNetworkImage(
          imageUrl: logoPath,
          height: 22,
          width: 22,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }
    return _getIconByService(name: logoPath.isNotEmpty ? logoPath : topTitle);
  }
  Widget _buildMainImage() {
    if (imagePath.isEmpty) {
      return Container(
        height: 70.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported, size: 20, color: Colors.grey),
      );
    }
    return CustomNetworkImage(
      imageUrl: imagePath,
      height: 70.h,
      width: 100.w,
      borderRadius: BorderRadius.circular(10),
    );
  }
  @override
  Widget build(BuildContext context) {
    final String primaryBtnText = (approveText ?? _defaultApproveText).toUpperCase();
    final String secondaryBtnText = (rejectText ?? _defaultRejectText).toUpperCase();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          /// Logo & Top Title
          Row(
            children: [
              _buildLogo(),
              const Gap(6),
              Expanded(
                child: CustomText(
                  text: topTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(8),
          /// Main Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: image + date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainImage(),
                  ],
                ),
              ),
              const Gap(8),

              // Right: titles + phone + address
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: mainTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const Gap(4),

                  ],
                ),
              ),
            ],
          ),
           const Gap(6),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   CustomText(
                     text: "Booking Date:",
                     fontWeight: FontWeight.w400,
                   ),
                  const Gap(4),
                  Expanded(
                    child: CustomText(
                      text: visitingDate,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   CustomText(
                     text: "Booking Time:",
                     fontWeight: FontWeight.w400,
                   ),
                  const Gap(4),
                  Expanded(
                    child: CustomText(
                      text: bookingTime ?? "",
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const Gap(6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.call, size: 18),
                  const Gap(4),
                  Expanded(
                    child: CustomText(
                      text: phoneNumber,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 18),
                  const Gap(4),
                  Expanded(
                    child: CustomText(
                      text: address,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(12),
          /// Approve / Reject Section (controlled by flags)
          if (showApproveButton || showRejectButton)
            Row(
              children: [
                if (showApproveButton)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onApprove,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        onApprove == null ? Colors.grey : AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: CustomText(
                        text: primaryBtnText,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (showApproveButton && showRejectButton) const SizedBox(width: 12),
                if (showRejectButton)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.blueColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: CustomText(
                        text: secondaryBtnText,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

          const Gap(4),
        ],
      ),
    );
  }
}
