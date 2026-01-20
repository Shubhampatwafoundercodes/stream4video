// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';

import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/utils/toast/app_toast.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/data/model/common_model/sub_cat_data_model.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/movie_detail_open_bottom_sheet.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';

enum HomeSectionType { banner, ranked, dynamic }

HomeSectionType parseSectionType(String? type) {
  switch (type) {
    case "banner":
      return HomeSectionType.banner;
    case "ranked":
      return HomeSectionType.ranked;
    default:
      return HomeSectionType.dynamic;
  }
}

class HomeSectionRenderer extends ConsumerWidget {
  final SubCatDataModel section;

  const HomeSectionRenderer({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = parseSectionType(section.sectionType);


    void openDetail(ContentPosterItemModel item) {
      if (!allowIfInternet(context: context, ref: ref)) return;
      if (item.id == null) return;
      MovieDetailOpenBottomSheet.openContentSheet(
        context,
        contentId: item.id.toString(),
      );
    }
    final showSeeA =
        type != HomeSectionType.ranked && type != HomeSectionType.banner;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: section.title ?? "",
          subtitle: section.subtitle ?? "",
          showSeeAll: showSeeA ? (section.showSeeAll ?? false) : false,
          onSeeAllTap: () {
            AppToast.premium("Internet Recheck");

            if (!allowIfInternet(context: context, ref: ref)) return;

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SeeAllMovieListScreen()),
            // );

            context.pushNamed(
              RoutesName.seeAllScreen,
              extra: {
                'title': section.title ?? "See All",
                'items': section.items,
              },
            );
          },
        ),
        if (type == HomeSectionType.ranked)
          RankedSectionWidget(items: section.items, onItemTap: openDetail,ref: ref,)
        else if (type == HomeSectionType.banner)
          BannerSectionWidget(items: section.items, height: 200.h,onItemTap: openDetail,ref: ref,)
        else
          HorizontalSectionWidget(items: section.items, onItemTap: openDetail,ref: ref,),
           AppSizes.spaceH(15),
      ],
    );
  }
}




