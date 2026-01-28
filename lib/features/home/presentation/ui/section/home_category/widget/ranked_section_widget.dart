

// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_cached_image.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/movie_detail_open_bottom_sheet.dart';
import 'package:stream4videos/l10n/app_localizations.dart';
import 'package:stream4videos/main.dart';




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
      padding:  EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
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
          if (showSeeAll) AppSizes.spaceW(08),

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
                  AppSizes.spaceW(04),
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
                // image: DecorationImage(
                //   image: NetworkImage(item.image ?? ""),
                //   fit: BoxFit.contain,
                // ),
              ),
              child: AppCachedImage(
                  width: screenWidth,
                  height: height,

                  url: item.image ?? "", fit: BoxFit.cover),
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
      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding:  EdgeInsets.only(left: 10.w, right: 16.w),
        itemBuilder: (_, i) {
          final item = items[i];
          final rank = "${i + 1}";
          return GestureDetector(
            onTap: () {
              if (!allowIfInternet(context: context, ref: ref)) return;

              onItemTap(item);
            },
            child: Container(
              width: 150.w,
              margin: EdgeInsets.only(left: i == 0 ? 10.w : 0, right: 8.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 10.w,
                    top: 5.h,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(03),
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
                    left: -10.w,
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
                    right: 25.w,
                    child: _buildBadge1(item.quality.toString(), Colors.red.shade800),
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
      padding:  EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
      height: 180.h,
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
              width: 120.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(03),
                    child: AppCachedImage(
                      url: item.image ?? "",
                      height: 180.h,
                      width: 120.w,
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
        borderRadius: BorderRadius.circular(03),
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
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(03),
          gradient: const LinearGradient(
            colors: [Color(0xffD4AF37), Color(0xffB8860B)], // Gold gradient
          ),
        ),
        child: ConstText(text:
          "PREMIUM",
            fontSize: AppConstant.fontSizeSmall-3,
            // fontWeight: FontWeight.bold,
            color: AppColors.blackPrimary
        ),
      );

    case "0":
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(03),
          color: Colors.teal.shade400,
        ),
        child:  ConstText(text:
          "FREE",
            fontSize: AppConstant.fontSizeSmall-3,
            // fontWeight: FontWeight.bold,
            color: AppColors.textPrimary
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
    child: ConstText(text:
      q,
        fontSize: AppConstant.fontSizeSmall-3,
        color: AppColors.textPrimary
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
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: AppColors.primaryBackground,
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.white.withOpacity(0.10),
                offset: const Offset(1, 1),
              ),
            ],
            fontFamily: "Poppins"
          ),
        ),
      ],
    );
  }
}