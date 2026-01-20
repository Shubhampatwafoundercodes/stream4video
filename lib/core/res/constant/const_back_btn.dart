import 'package:flutter/material.dart';

class ConstBackBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;

  const ConstBackBtn({
    super.key,
    this.onTap,
    this.height = 30,
    this.width = 30,
    this.iconSize = 20,
    this.iconColor,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
          border: border,
          boxShadow: boxShadow,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}