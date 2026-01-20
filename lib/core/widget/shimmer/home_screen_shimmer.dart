import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/widget/shimmer/shimmer_custom.dart';
import 'package:stream4videos/core/widget/shimmer/shimmer_design.dart';


class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          BannerShimmer(),
          SizedBox(height: 16),
          CategoryRowShimmer(),
          SearchScreenShimmer(),
        ],
      ),
    );
  }
}

class CategoryRowShimmer extends StatelessWidget {
  const CategoryRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: AppShimmer.baseColor,
          highlightColor: AppShimmer.highlightColor,
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              color: AppShimmer.baseColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: 6,
      ),
    );
  }
}

class MovieSectionShimmer extends StatelessWidget {
  const MovieSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Shimmer.fromColors(
            baseColor: AppShimmer.baseColor,
            highlightColor: AppShimmer.highlightColor,
            child: Container(
              height: 14,
              width: 140,
              decoration: BoxDecoration(
                color: AppShimmer.baseColor,
                borderRadius: AppShimmer.radiusSmall,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal Posters
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => const PosterShimmer(),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: 6,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}


class SearchScreenShimmer extends StatelessWidget {
  const SearchScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),
        MovieSectionShimmer(),
        MovieSectionShimmer(),
        MovieSectionShimmer(),
      ],
    );
  }
}








