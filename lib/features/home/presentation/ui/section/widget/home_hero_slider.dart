import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_cached_image.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/features/home/data/model/get_home_banner_model.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/movie_detail_open_bottom_sheet.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/l10n/app_localizations.dart';
import 'package:stream4videos/main.dart';

class HomeHeroSlider extends ConsumerStatefulWidget {
  final List<HomeBannerDataList>? banners;

  const HomeHeroSlider({super.key,this.banners});

  @override
  ConsumerState<HomeHeroSlider> createState() => _HomeHeroSliderState();
}

class _HomeHeroSliderState extends ConsumerState<HomeHeroSlider> {
  int current = 0;


  @override
  Widget build(BuildContext context) {
    final banners = widget.banners;

    final t =AppLocalizations.of(context)!;

    if (banners == null || banners.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 500.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, real) {
              final item = banners[index];

              return Stack(
                children: [
                  Positioned.fill(
                    child: AppCachedImage(
                        url:  item.image ?? "",
                        fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.blackPrimary,
                            AppColors.blackSecondary.withAlpha(60),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.25, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstText(
                          text: (item.subtitle ?? "")
                              .toUpperCase(),
                          color: AppColors.textSecondary,
                          fontWeight: AppConstant.bold,
                        ),
                        AppSizes.spaceH(5),
                        ConstText(
                          text: item.title??"",
                          fontSize: AppConstant.fontSizeHeading,
                          fontWeight: AppConstant.bold,
                        ),
                        AppSizes.spaceH(12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          children: item.tags.map((tag) {
                            return Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary.withAlpha(70),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ConstText(
                                text: tag,
                                fontSize: AppConstant.fontSizeOne,
                                color: AppColors.textSecondary,
                                fontWeight: AppConstant.medium,
                                // fontSize: ,
                              ),
                            );
                          }).toList(),
                        ),

                         AppSizes.spaceH(16),

                        // WATCH NOW BUTTON + PLUS BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppBtn(
                              onTap: (){
                                if (item.id == null) return;
                                MovieDetailOpenBottomSheet.openContentSheet(
                                  context,
                                  contentId: item.id.toString(),
                                );
                              },
                              height: 40.h,
                              width: screenWidth * 0.6,
                              gradient: AppColors.secondButtonGradient,
                              borderRadius: 06,

                              child:  Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    AppSizes.spaceW(06),
                                    ConstText(text: t.watchlist_watch_now),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 500.h,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 900),
              onPageChanged: (i, _) => setState(() => current = i),
            ),
          ),
          Positioned(
            bottom: 10.h,
            child: Row(
              children: List.generate(
               banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: current == i ? 23 : 7,
                  height: 6.h,
                  margin:  EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: current == i
                        ? Colors.white70
                        : Colors.white54.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
