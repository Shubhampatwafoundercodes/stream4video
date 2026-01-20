import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/widget/shimmer/shimmer_custom.dart' show Shimmer;

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? radius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppShimmer.baseColor,
      highlightColor: AppShimmer.highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppShimmer.baseColor,
          borderRadius: radius ?? AppShimmer.radiusMedium,
        ),
      ),
    );
  }
}
