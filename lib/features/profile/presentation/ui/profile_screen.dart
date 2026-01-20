import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_card_container.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/notifier/help_support_notifer.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class ProfileScreenMinimal extends HookConsumerWidget {
  const ProfileScreenMinimal({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final categoryState = ref.watch(categoryNotifierProvider);

    final profileData = profileState.profile?.profile;
    final watchlist = categoryState.myWatchListModelData ?? [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryNotifierProvider.notifier).getMyWatchListApi();
      });
      return null;
    }, []);
final t=AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title:t.profile_title,
          scrollable: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  Container(
                    width: 85.w,
                    height: 85.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                      border: Border.all(
                        color: AppColors.textHint,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackPrimary.withAlpha(30),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: profileData?.image != null && profileData!.image!.isNotEmpty
                          ? Image.network(
                        profileData.image!,
                        fit: BoxFit.cover,
                        width: 85.w,
                        height: 85.h,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(
                            Assets.imageNoCustomerImage,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                          : Image.asset(
                        Assets.imageNoCustomerImage,
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),

                  AppSizes.spaceW(15),

                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstText(
                          text: (profileData?.name != null && profileData!.name!.trim().isNotEmpty)
                              ? profileData.name!
                              : t.profile_greeting_guest,
                          color: AppColors.textPrimary,
                          fontSize: AppConstant.fontSizeLarge,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          maxLine: 1,
                        ),
                        AppSizes.spaceH(2),
                        ConstText(
                          text: (profileData?.mobile != null && profileData!.mobile!.isNotEmpty)
                              ? "+91-${profileData.mobile}"
                              : t.profile_guest_message,
                          color: AppColors.textPrimary.withAlpha(100),
                          fontSize: AppConstant.fontSizeTwo,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),

                  // Edit Button
                  GestureDetector(
                    onTap: () {

                      checkLoginOnly(
                        context: context,
                        ref: ref,
                        onAllowed: () {
                          context.pushNamed(RoutesName.editProfileScreen);
                        },
                      );

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(10),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.textHint,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white70, size: 16),
                          SizedBox(width: 6),
                          ConstText(
                            text: t.profile_edit,
                            color: AppColors.textSecondary,
                            fontSize: AppConstant.fontSizeOne,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AppSizes.spaceH(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMinimalOptionCard(
                    icon: Icons.percent,
                    title: t.profile_plans_offers,
                    onTap: () {

                      checkLoginOnly(
                        context: context,
                        ref: ref,
                        onAllowed: () {
                          context.pushNamed(RoutesName.myPlanHistory);
                        },
                      );
                      },
                  ),

                  _buildMinimalOptionCard(
                    icon: Icons.headset_mic_outlined,
                    title: t.profile_help_center,
                    onTap: () async{

                      if (!allowIfInternet(context: context, ref: ref)) return;
                       GlobalLoader.show(context);
                       await  ref.read(helpSupportNotifierProvider.notifier).helpSupportApi();
                      GlobalLoader.hide(context);
                      context.pushNamed(RoutesName.helpScreen);


                    },
                  ),

                  _buildMinimalOptionCard(
                    icon: Icons.settings,
                    title: t.profile_settings,
                    onTap: () {
                      checkLoginOnly(
                        context: context,
                        ref: ref,
                        onAllowed: () {
                          context.push(RoutesName.settingScreen);
                        },
                      );


                    },
                  ),
                ],
              ),
              AppSizes.spaceH(30),
              if (categoryState.isAddWatchListLoading)
                const Center(child: MovieSectionShimmer(),)
              else if (watchlist.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstText(
                      text: t.profile_watchlist_title,
                      fontSize: AppConstant.fontSizeLarge,
                      fontWeight: AppConstant.bold,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!allowIfInternet(context: context, ref: ref)) return;

                        context.pushNamed(RoutesName.watchListScreen);
                      },
                      child: ConstText(
                        text: t.profile_watchlist_view_all,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                AppSizes.spaceH(12),
                SizedBox(
                  height: 180.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    watchlist.length > 6 ? 6 : watchlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 120.h,
                          child: PosterCard(item: watchlist[index]),
                        ),
                      );
                    },
                  ),
                ),
                AppSizes.spaceH(30),
              ]

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: CommonCardContainer(
        onTap: onTap,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 26),
            ),

            AppSizes.spaceH(12),

            ConstText(
              text: title,
              color: Colors.white,
              fontSize: AppConstant.fontSizeTwo,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
          ],
        )
      ),
    );
  }
}
