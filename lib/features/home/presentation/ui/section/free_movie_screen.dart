import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart' show CommonScreenContainer;
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/all_category.dart' show HomeSectionRenderer;
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart' show HomeHeroSlider;

class FreeMovieScreen extends HookConsumerWidget {
  const FreeMovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(homeProvider);
    // final notifier = ref.read(homeProvider.notifier);
    final catNotifier = ref.read(categoryNotifierProvider.notifier);
    final categoryState = ref.watch(categoryNotifierProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_){

        catNotifier.getSectionApi(isPremium: false);
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
          child: Column(
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
