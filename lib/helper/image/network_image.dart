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

  const CustomNetworkImage({
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
    final String finalUrl = "http://10.0.60.137:5055/$imageUrl";

    if (imageUrl.isEmpty) {
      print("Empty Image URL: $imageUrl");
      return CachedNetworkImage(
        imageUrl: "http://10.0.60.137:5055/uploads/images/category/1741837193950-photo-1470225620780-dba8ba36b745.jpg",
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
      imageUrl: finalUrl,
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
