import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';

class ConstBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const ConstBottomSheet({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundColourGradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: child,
      ),
    );
  }
}
