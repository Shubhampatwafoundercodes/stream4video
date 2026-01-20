import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart' show AppShimmer;
import 'package:stream4videos/core/widget/shimmer/shimmer_box.dart';

class PosterShimmer extends StatelessWidget {
  const PosterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      height: 200,
      width: 140,
      radius: AppShimmer.radiusLarge,
    );
  }
}

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      height: 220,
      width: double.infinity,
      radius: AppShimmer.radiusLarge,
    );
  }
}


class AvatarShimmer extends StatelessWidget {
  const AvatarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      height: 64,
      width: 64,
      radius: BorderRadius.circular(100),
    );
  }
}


class TextLineShimmer extends StatelessWidget {
  final double width;

  const TextLineShimmer({super.key, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      height: 12,
      width: width,
      radius: AppShimmer.radiusSmall,
    );
  }
}

