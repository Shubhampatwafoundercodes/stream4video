import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/widget/common_no_data_found.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart' show categoryNotifierProvider;
import 'package:stream4videos/features/home/presentation/ui/section/home_category/all_category.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart' show HomeHeroSlider;
import 'package:stream4videos/l10n/app_localizations.dart';

class PremiumMovieScreen extends HookConsumerWidget {
  const PremiumMovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final catNotifier = ref.read(categoryNotifierProvider.notifier);
    final categoryState = ref.watch(categoryNotifierProvider);
    final t=AppLocalizations.of(context)!;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_){
        catNotifier.getSectionApi(isPremium: true);
      });
      return null;
    }, const []);



    final sections = categoryState.freeSectionModel?.data??[];

    final banners = categoryState.freeSectionModel?.banner ?? [];

    return SafeArea(
      top: false,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.blackPrimary,
          body:categoryState.isFreeSectionLoading ?
          HomeScreenShimmer():
          CommonScreenContainer(
            padding: EdgeInsets.zero,
            showBack: false,
            scrollable: true,
            backgroundColor: Colors.transparent,
            child:
            (sections.isEmpty && banners.isEmpty)
                ? CommonNoDataFound(
              title: t.search_no_results,

            )
                :


            Column(
              children: [
                HomeHeroSlider(banners: banners,),
                AppSizes.spaceH(10),
                if(sections.isNotEmpty)
                  Column(
                    children: List.generate(
                      sections.length,
                          (index) => HomeSectionRenderer(section: sections[index]),
                    ),
                  ),
                // HomeScreenShimmer()
              ],
            ),
          )
      ),
    );
  }


}

