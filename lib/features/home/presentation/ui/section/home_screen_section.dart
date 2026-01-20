import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/all_category.dart';
import 'package:stream4videos/features/home/presentation/notifier/home_section_provider.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/animated_golden_batch.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_screen_tapbar.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/generated/assets.dart';


class HomeScreenSection extends HookConsumerWidget {
  const HomeScreenSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final categoryState = ref.watch(categoryNotifierProvider);
    final sections = categoryState.subCategories?.data ?? [];

    final banners = categoryState.homeBannerModel?.data ?? [];

    final scrollController = useScrollController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(0);
        }
        notifier.updateSticky(false);
      });

      return null;
    }, []);



    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset > 340) {
          notifier.updateSticky(true);
        } else {
          notifier.updateSticky(false);
        }
      });
      return null;
    }, []);


    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.blackPrimary,

      appBar: AppBar(
        backgroundColor: state.isSticky
            ? AppColors.primaryBackground
            : Colors.transparent,
        elevation: 0,
        toolbarHeight: state.isSticky ? 90 : 80,
        automaticallyImplyLeading: false,
        titleSpacing: 0,

        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.isSticky
              ? _buildStickyTabBar(ref,)
              : _buildProfileHeader(context),
        ),
      ),

      body:categoryState.isSubCatLoading || categoryState.isLoading?
          HomeScreenShimmer():
          RefreshIndicator(
            color: AppColors.textPrimary,
            backgroundColor: AppColors.primaryBackground,
            onRefresh: ()async{
              if (scrollController.hasClients) {
                scrollController.jumpTo(0);
              }
              notifier.updateSticky(false);
              ref.read(categoryNotifierProvider.notifier).getAllCategories();
              ref.read(profileNotifierProvider.notifier).getProfile();


            },
            child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
            children: [
               HomeHeroSlider(banners: banners,),

              if (!state.isSticky) _buildStickyTabBar(ref),
              AppSizes.spaceH(20),
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
                  ),
          ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      key: const ValueKey("PROFILE_HEADER"),
      padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              context.push(RoutesName.profileScreen);
            },
            child: ClipOval(
              child: Image.asset(
                Assets.imageNoCustomerImage,
                height: 45.h,
                width: 45.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          AnimatedGoldenBadge(
            texts: ["Prime", "Premium", "Exclusive"],
            width: 90.w,
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget _buildStickyTabBar(WidgetRef ref,) {
    final state = ref.watch(homeProvider);
    final categoryNotifier = ref.watch(categoryNotifierProvider);
    final categoryList = categoryNotifier.categories?.data ?? [];

    return Container(
      key: const ValueKey("STICKY_TABBAR"),
      padding:  EdgeInsets.only(top: 10.h),
      child: UpgradedCategorySelector(
        categories: categoryList.map((e) => e.name ?? "").toList(),
        selectedIndex: state.selectedCategory,
        onSelect: (i) {
          final catId= categoryList[i].id.toString();
          ref.read(homeProvider.notifier).updateCategory(i);
          ref.read(categoryNotifierProvider.notifier).getSubCategories(catId);
        } 
      ),
    );
  }

}
