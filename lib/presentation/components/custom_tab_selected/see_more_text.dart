import 'package:flutter/material.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/text_style_constant.dart';


class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? buttonStyle;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.textStyle,
    this.buttonStyle,
    this.maxLines = 2,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isTextOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkTextOverflow();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _checkTextOverflow();
        }
      });
    }
  }

  void _checkTextOverflow() {
    final textStyle = widget.textStyle ??
        poppinsRegular.copyWith(
          fontSize: 14,
        );

    final textSpan = TextSpan(text: widget.text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    if (textPainter.didExceedMaxLines) {
      if (mounted) {
        setState(() {
          _isTextOverflowing = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isTextOverflowing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.text,
          style: widget.textStyle ??
              poppinsRegular.copyWith(
                fontSize:14,
                color: AppColors.kSeeAllColor
              ),
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (_isTextOverflowing)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'See Less' : "See More",
              style: widget.buttonStyle ??
                  poppinsSemiBold.copyWith(
                    fontSize:14,
                  ),
            ),
          ),
      ],
    );
  }
}