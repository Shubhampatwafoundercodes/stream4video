import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';

class CommonCardContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const CommonCardContainer({
    super.key,
    required this.child,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 5),
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        border: Border.all(color: AppColors.textHint, width: 1),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: card)
        : card;
  }
}


