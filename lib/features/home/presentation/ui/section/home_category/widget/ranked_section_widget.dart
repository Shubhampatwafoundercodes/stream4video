

// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_cached_image.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/movie_detail_open_bottom_sheet.dart';
import 'package:stream4videos/l10n/app_localizations.dart';




class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showSeeAll;
  final VoidCallback? onSeeAllTap;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.showSeeAll,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {

    final t=AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstText(
                  text: title,
                  fontSize: AppConstant.fontSizeThree,
                  fontWeight: AppConstant.semiBold,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: ConstText(
                      text: subtitle!,
                      color: Colors.white54,
                      fontSize: 13,
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          if (showSeeAll) const SizedBox(width: 8),

          if (showSeeAll)
            InkWell(
              onTap: onSeeAllTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstText(
                    text: t.watchlist_see_all,
                    fontWeight: AppConstant.medium,
                    fontSize: AppConstant.fontSizeThree,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.textPrimary,
                    size: 14,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class BannerSectionWidget extends StatelessWidget {
  final List<ContentPosterItemModel> items;
  final ValueChanged<ContentPosterItemModel> onItemTap;

  final WidgetRef ref;

  final double height;

  const BannerSectionWidget({
    super.key,
    required this.items,
    required this.onItemTap,
    this.height = 200,
    required this.ref
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: items.length > 1
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return GestureDetector(
            onTap: () => onItemTap(item),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == items.length - 1 ? 0 : 8,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.image ?? ""),
                  fit: BoxFit.contain,
                ),
              ),
              child: AppCachedImage(url: item.image ?? "", fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

class RankedSectionWidget extends StatelessWidget {
  final List<ContentPosterItemModel> items;
  // final Function(ContentPosterItemModel item) onItemTap;
  final ValueChanged<ContentPosterItemModel> onItemTap;
  final WidgetRef ref;

  const RankedSectionWidget({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.ref
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 10, right: 16),
        itemBuilder: (_, i) {
          final item = items[i];
          final rank = "${i + 1}";
          return GestureDetector(
            onTap: () {
              if (!allowIfInternet(context: context, ref: ref)) return;

              onItemTap(item);
            },
            child: Container(
              width: 160.w,
              margin: EdgeInsets.only(left: i == 0 ? 10.w : 0, right: 8.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 10.w,
                    top: 5.h,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(04),
                      child: AppCachedImage(
                        url: item.image ?? "",
                        fit: BoxFit.cover,
                        width: 130,
                      ),

                      // Image.asset(
                      //     item["image"],
                      //     width: 110,
                      //     fit: BoxFit.cover
                      // ),
                    ),
                  ),
                  Positioned(
                    left: -15.w,
                    bottom: -20.h,
                    child: StrokeText(text: rank, fontSize: 80.sp),
                  ),
                  // if (item.itsPremium != null)
                  //   Positioned(
                  //     top: 15.h,
                  //     left: 18.w,
                  //     child: _buildBadge(item.itsPremium.toString()),
                  //   ),
                  Positioned(
                    top: 15.h,
                    right: 35.w,
                    child: _buildBadge1(item.quality.toString(), Colors.red.shade700),
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadge1(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ConstText(
        text: text,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class HorizontalSectionWidget extends StatelessWidget {
  final WidgetRef ref;
  // final List items;
  // final Function(Map item) onItemTap;
  final List<ContentPosterItemModel> items;
  final ValueChanged<ContentPosterItemModel> onItemTap;

  // final Function(ContentPosterItemModel item) onItemTap;

  const HorizontalSectionWidget({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.ref
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return GestureDetector(
            onTap: () {
              if (!allowIfInternet(context: context, ref: ref)) return;

              onItemTap(item);

              },
            child: Container(
              margin: EdgeInsets.only(left: i == 0 ? 14 : 10, right: 4),
              width: 140,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppCachedImage(
                      url: item.image ?? "",
                      height: 200,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (item.itsPremium != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _buildBadge(item.itsPremium.toString()),
                    ),
                  if (item.quality != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _buildQualityBadge(item.quality ?? ""),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            // ignore: duplicate_ignore
                            // ignore: deprecated_member_use
                            Colors.black.withOpacity(.85),
                            Colors.black.withOpacity(.30),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: ConstText(text:
                        item.title.toString().toUpperCase(),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class PosterCard extends HookConsumerWidget {
  final ContentPosterItemModel item;
  final VoidCallback? onTap;

  const PosterCard({super.key, required this.item,this.onTap});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
      onTap: onTap??(){

        if (!allowIfInternet(context: context, ref: ref)) return;

        if (item.id == null) return;
        MovieDetailOpenBottomSheet.openContentSheet(
          context,
          contentId: item.id.toString(),
        );

      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// 🎬 IMAGE
              AppCachedImage(
                url: item.image ?? "",
                fit: BoxFit.cover,
                // backgroundColor: Colors.grey.shade900,
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(.85),
                        Colors.black.withOpacity(.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    item.title?.toUpperCase() ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),

              /// 🎖 PREMIUM / FREE
              if (item.itsPremium != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildBadge(item.itsPremium.toString()),
                ),

              /// 🔥 QUALITY
              if (item.quality != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: _buildQualityBadge(item.quality ?? ""),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBadge(String type) {
  switch (type) {
    case "1":
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            colors: [Color(0xffD4AF37), Color(0xffB8860B)], // Gold gradient
          ),
        ),
        child: const Text(
          "PREMIUM",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

    case "0":
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.greenAccent.shade400,
        ),
        child: const Text(
          "FREE",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );

    default:
      return const SizedBox();
  }
}

Widget _buildQualityBadge(String q) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.6),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      q,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;

  const StrokeText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // OUTLINE STROKE (thin border)
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: 2, // 👈 spacing added
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth =
              3 // 👈 slim border
              ..color = AppColors.textTertiary,
          ),
        ),

        // INNER THICK FILL
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900, // 👈 heavy fill
            letterSpacing: 2, // 👈 fill spacing
            color: AppColors.primaryBackground, // 👈 more hollow space look
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.white.withOpacity(0.10),
                offset: const Offset(1, 1), // 👈 depth feel
              ),
            ],
          ),
        ),
      ],
    );
  }
}