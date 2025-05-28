import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final Widget? errorWidget;
  final ColorFilter? colorFilter;
  final BoxFit? fit;

  const  CustomNetworkImage({
    super.key,
    this.child,
    this.errorWidget,
    this.colorFilter,
    required this.imageUrl,
    this.backgroundColor,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.fit,
    this.boxShape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
  //  final String finalUrl = "https://www.webxcreation.com/event-recruitment/images/profile-1.jpg/$imageUrl";

    if (imageUrl.isEmpty) {
      print("Empty Image URL: $imageUrl");
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            borderRadius: borderRadius,
            shape: boxShape,
            color: backgroundColor,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover, colorFilter: colorFilter),
          ),
          child: child,
        ),
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.withValues(alpha: 0.6),
            highlightColor: Colors.grey.withValues(alpha: 0.3),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: border,
                color: Colors.grey.withValues(alpha: 0.6),
                borderRadius: borderRadius,
                shape: boxShape,
              ),
            )),
        errorWidget: (context, url, error) => errorWidget??Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: Colors.grey.withValues(alpha: 0.6),
            borderRadius: borderRadius,
            shape: boxShape,
          ),
          child: const Icon(Icons.error),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: "https://www.webxcreation.com/event-recruitment/images/profile-1.jpg",
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          shape: boxShape,
          color: backgroundColor,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover, colorFilter: colorFilter),
        ),
        child: child,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.withValues(alpha: 0.6),
          highlightColor: Colors.grey.withValues(alpha: 0.3),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: border,
              color: Colors.grey.withValues(alpha: 0.6),
              borderRadius: borderRadius,
              shape: boxShape,
            ),
          )),
      errorWidget: (context, url, error) => errorWidget??Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: Colors.grey.withValues(alpha: 0.6),
          borderRadius: borderRadius,
          shape: boxShape,
        ),
        child: const Icon(Icons.error),
      ),
    );
  }
}
