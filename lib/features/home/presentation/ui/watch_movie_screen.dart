// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_cached_image.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_bottom_sheet.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/format/date_time_formater.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_no_data_found.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/expandable_description.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/home/data/model/movie_details_model.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/notifier/movie_details_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/l10n/app_localizations.dart';
import 'package:stream4videos/main.dart';

class WatchMovieScreen extends HookConsumerWidget {
  final String contentId;
  const WatchMovieScreen({super.key,required this.contentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t=AppLocalizations.of(context)!;

    final state = ref.watch(movieDetailsNotifierProvider);
    final notifier = ref.read(movieDetailsNotifierProvider.notifier);
    final categoryState = ref.watch(categoryNotifierProvider);
    final categoryNotifier = ref.read(categoryNotifierProvider.notifier);
    final scrollController = useScrollController();
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.updateSticky(false);
        notifier.movieDetailsApi(contentId.toString());
      });
      return ;
    }, [contentId]);
    useEffect(() {
      void listener() {
        final shouldStick = scrollController.offset > 40;
        if (shouldStick != state.isSticky) {
          notifier.updateSticky(shouldStick);
        }
      }

      scrollController.addListener(listener);
      return () { scrollController.removeListener(listener);
      // scrollController.jumpTo(0);
      // notifier.updateSticky(false);
      };
    }, []);



    final movie = state.data?.data?.movieDetails;
    final people = state.data?.data?.people ?? [];


    final currentSeason = notifier.currentSeason;
    final moreLikeThis = state.data?.data?.moreLikeThis ?? [];
    final isInWatchlist = categoryState.isInWatchlist;


    // print(moreLikeThis);

    return Stack(
      children: [
        CommonScreenContainer(
          showBack: false,
          scrollable: false,
          padding: EdgeInsets.zero,
          child:state.isLoading?
          HomeScreenShimmer():
          movie==null?
          CommonNoDataFound(title: t.search_no_results,)
              : SingleChildScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                buildHeroHeader(
                  context: context,
                  imageUrl: movie.banner ?? "",
                  title: movie.title ?? "",
                  metaText: notifier.isSeries
                      ? "${buildMetaText(movie)} • ${notifier.episodes.length} ${t.detail_episodes}"
                      : buildMetaText(movie)),

                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    // horizontal: 16.w,
                  ),
                  color: AppColors.blackPrimary,
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppBtn(
                                onTap: () async{
                                  // GlobalLoader.show();

                                    checkLoginAndPremium(
                                      context: context,
                                      ref: ref,
                                      isPremiumContent: movie.isPremium == 1,
                                      onAllowed: () async{
                                        final url = notifier.getPlayUrlOnPlayTap();
                                        if (url == null) return;
                                        context.pushNamed(
                                          RoutesName.fullScreenVideoPlay,
                                          extra: {
                                            'videoUrl': url,
                                            'moreLikeThis': moreLikeThis,
                                          },);
                                      },
                                    );

                                   // GlobalLoader.hide();

                                  },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: AppColors.blackPrimary,
                                    ),
                                    AppSizes.spaceW(10),
                                    ConstText(
                                      text: t.detail_play,
                                      fontWeight: AppConstant.bold,
                                      fontSize: AppConstant.fontSizeThree,
                                      color: AppColors.blackPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AppSizes.spaceW(15),
                            GestureDetector(
                              onTap: categoryState.isAddWatchListLoading?null: ()async{
                                checkLoginOnly(
                                  context: context,
                                  ref: ref,
                                  onAllowed: () async{
                                    GlobalLoader.show();
                                    await categoryNotifier.addWatchListApi(contentId);
                                    GlobalLoader.hide();
                                    },
                                );

                              },
                              child: Column(
                                children: [
                                  Icon(
                                    isInWatchlist ? Icons.check_circle : Icons.add,
                                    color: isInWatchlist
                                        ? const Color(0xFF4ED6A5)
                                        : AppColors.textSecondary,
                                    size: 30,
                                  ),
                                  AppSizes.spaceH(06),
                                  ConstText(
                                    text: isInWatchlist ?t.detail_watchlist_added : t.detail_watchlist_add,
                                    color: isInWatchlist
                                        ? const Color(0xFF4ED6A5)
                                        : AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSizes.spaceH(16),
                      if (movie.description != null)
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: InlineExpandableDescription(
                            title: "${movie.title}",
                            description: movie.description ?? "",
                          ),
                        ),

                      AppSizes.spaceH(16),
                      if (people.isNotEmpty) ...[
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
                          child: ConstText(
                            text: t.detail_cast_crew,
                            color: AppColors.textPrimary,
                            fontWeight: AppConstant.bold,
                            fontSize: AppConstant.fontSizeThree,
                          ),
                        ),
                        AppSizes.spaceH(10),
                        SizedBox(
                          height: 115.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: people.length,
                            itemBuilder: (_, i) {
                              final p = people[i];
                              return castCrewItem(
                                imageUrl: p.profileImage ?? "",
                                name: p.name ?? "",
                                badgeText: p.personType ?? "",
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                  AppSizes.spaceH(8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (notifier.isSeries ) ...[
                          _tabItem(t.detail_episodes, 0, state, notifier),
                          // AppSizes.spaceW(12),
                        ],
                        if(moreLikeThis.isNotEmpty)
                        _tabItem(
                          t.detail_more_like_this,
                          notifier.isSeries ? 1 : 0,
                          state,
                          notifier,
                        ),
                      ],
                    ),
                  ),
                  AppSizes.spaceH(12),

                  if ( notifier.isSeries && state.selectedTab == 0) ...[
                    if (currentSeason != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GestureDetector(
                          onTap: () =>
                              _openSeasonSheet(context, notifier, state,t),
                          child: Row(
                            children: [
                              ConstText(
                                text: currentSeason.title ?? "",
                                fontSize: AppConstant.fontSizeThree,
                                fontWeight: AppConstant.bold,
                              ),
                              AppSizes.spaceH(06),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSizes.spaceH(12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notifier.episodes.length,
                      itemBuilder: (context, i) {
                        final ep = notifier.episodes[i];
                        final isActive =
                            state.currentEpisodeIndex != -1 &&
                                i == state.currentEpisodeIndex;
                        return GestureDetector(
                          onTap: () async{
                            // GlobalLoader.show();

                               checkLoginAndPremium(
                              context: context,
                              ref: ref,
                              isPremiumContent: movie.isPremium == 1,
                              onAllowed: () async{
                                notifier.selectEpisode(i);
                                context.pushNamed(
                                  RoutesName.fullScreenVideoPlay,
                                  extra: {
                                    'videoUrl': ep.watchUrl,
                                    'moreLikeThis': moreLikeThis,
                                  },

                                );
                              },
                              );






                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 120.w,
                                          height: 70.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            color: Colors.grey.shade800,
                                          ),
                                          child: AppCachedImage(
                                            url: ep.thumbnail,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.all(6),
                                          child: Icon(
                                            isActive
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),

                                    AppSizes.spaceW(12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 6,
                                            crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                            children: [
                                              ConstText(
                                                text: ep.isPremium
                                                    ? t.detail_premium_badge
                                                    : t.detail_free_badge,
                                                color: ep.isPremium
                                                    ? const Color(
                                                  0xFF4ED6A5,
                                                )
                                                    : AppColors
                                                    .textSecondary,
                                                fontWeight:
                                                AppConstant.bold,
                                                fontSize: AppConstant
                                                    .fontSizeOne,
                                              ),
                                              ConstText(
                                                text:
                                                "${ep.durationMinutes}m | ${DateTimeFormat.formatEpisodeDate(ep.createdAt)}",
                                                color: AppColors.textHint,
                                                fontSize: AppConstant
                                                    .fontSizeOne,
                                                maxLine: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),

                                          AppSizes.spaceH(6),

                                          /// TITLE
                                          ConstText(
                                            text:
                                            "${i + 1}. ${t.detail_episodes} ${ep.title}",
                                            color:
                                            AppColors.textSecondary,
                                            fontWeight:
                                            AppConstant.semiBold,
                                            // fontSize: AppConstant.fontSizeThree,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                AppSizes.spaceH(06),

                                /// 📝 DESCRIPTION
                                InlineExpandableDescription(
                                  title:
                                  "${t.detail_episodes} ${ep.episodeNumber}: ${ep.title}",
                                  description: ep.description,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    AppSizes.spaceH(06),
                  ],
                  if ((notifier.isSeries && state.selectedTab == 1) || (!notifier.isSeries))
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: moreLikeThis.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, i) {
                          return PosterCard(item: moreLikeThis[i]);
                        },
                      ),
                    ),
                ],

            ),
          ),
        ),
        AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          offset: state.isSticky ? Offset.zero : const Offset(0, -1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            opacity: state.isSticky ? 1 : 0,
            child: IgnorePointer(
              ignoring: !state.isSticky,
              child: Container(
                height: 85.h,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                ),
                child: Padding(
                  padding:  EdgeInsets.only(top: 25.0.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      AppSizes.spaceW(10),
                      Expanded(
                        child: ConstText(
                          text: movie?.title ?? "",
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: AppConstant.semiBold,
                          fontSize: AppConstant.fontSizeThree,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget castCrewItem({
    required String imageUrl,
    required String name,
    required String badgeText,
  }) {
    return Container(
      // height: 80,
      width: 85.w,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentGeometry.bottomCenter,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(imageUrl),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(06),
                ),
                child: ConstText(
                  text: badgeText,
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          AppSizes.spaceH(05),

          ConstText(
            text: name,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _openSeasonSheet(
    BuildContext context,
    MovieDetailsNotifier notifier,
    MovieDetailsState state,
    AppLocalizations t
  )
  {
    final seasonList = notifier.seasons;
    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.black,
      builder: (_) {
        return ConstBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               ConstText(
                text: t.detail_select_season,
                fontSize: 18,
                fontWeight: AppConstant.bold,
                color: Colors.white,
              ),
              AppSizes.spaceH(12),
              ...seasonList.map((s) {
                final isSelected = s.seasonNumber == state.selectedSeason;
                return ListTile(
                  onTap: () {
                    notifier.changeSeason(s.seasonNumber ?? 1);
                    context.pop();
                  },
                  title: ConstText(text:
                    "${s.title}",
                      color: isSelected ? Colors.red : Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.red)
                      : null,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _tabItem(
    String title,
    int index,
    MovieDetailsState state,
    MovieDetailsNotifier notifier,
  ) {
    final isActive = state.selectedTab == index;
    return GestureDetector(
      onTap: () => notifier.changeTab(index),
      child: Column(
        children: [
          ConstText(
            text: title,
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
            fontSize: AppConstant.fontSizeThree,
          ),
          if (isActive) Container(height: 3, width: 80, color: Colors.red),
        ],
      ),
    );
  }

  Widget buildHeroHeader({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String metaText,
    double height = 350,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          /// 🎬 POSTER IMAGE
          Positioned.fill(
            child: AppCachedImage(url: imageUrl, fit: BoxFit.cover),
          ),


          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                   AppColors.blackPrimary.withOpacity(0.3),
                    AppColors.blackPrimary.withOpacity(0.6),
                    AppColors.blackPrimary,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                ConstText(
                  text: title,
                  fontSize: AppConstant.fontSizeHeading,
                  fontWeight: AppConstant.extraBold,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                AppSizes.spaceH(6),
                ConstText(
                  text: metaText,
                  color: AppColors.textHint,
                  fontSize: 13,
                  maxLine: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Positioned(
            top: 40,
            left: 15,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackPrimary.withAlpha(100),
                ),
                child: Icon(Icons.keyboard_arrow_down_outlined, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String buildMetaText(MovieDetails movie) {
    final rating = movie.contentRating ?? "U/A";
    final genres = movie.genres.isNotEmpty ? movie.genres.join(" • ") : "";
    final languages = movie.languages.isNotEmpty
        ? movie.languages.join(", ")
        : "";

    return [rating, genres, languages].where((e) => e.isNotEmpty).join(" • ");
  }
}

