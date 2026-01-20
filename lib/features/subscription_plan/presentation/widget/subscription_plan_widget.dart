import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';

import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_screen_tapbar.dart';
import 'package:stream4videos/features/subscription_plan/data/model/subcription_plans_model.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/cashfree/create_paying_notifier.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/subscription_plan_notifer.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class SubscriptionPlanWidget extends ConsumerStatefulWidget {
  const SubscriptionPlanWidget({super.key});

  @override
  ConsumerState<SubscriptionPlanWidget> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends ConsumerState<SubscriptionPlanWidget> {
  int selectedDurationIndex = 0;
  int selectedPlanIndex = 0;
  HalfYearly? selectedPlan;
  Map<String, List<HalfYearly>> plansMap = {};

  final durations = ["Monthly", "Quarterly", "Half-Yearly", "Yearly"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionNotifierProvider.notifier).getSubscriptionPlans();
      // ref.read(authNotifierProvider.notifier).allBannerApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t= AppLocalizations.of(context)!;
    return Consumer(
        builder: (context, ref, _) {
          final subState = ref.watch(subscriptionNotifierProvider);
          final categoryState = ref.watch(categoryNotifierProvider);

          final banners = categoryState.homeBannerModel?.data ?? [];

          if (subState.isLoading) {
            return const HomeScreenShimmer();
          }

          final plansData = subState.plans?.data;

          if (plansData == null) {
            return  Center(
              child: ConstText(
                text: t.plan_no_available,
                color: Colors.white54,
              ),
            );
          }

          final plansMap = buildPlansMap(plansData);
          final durationKeys = plansMap.keys.toList();

          if (durationKeys.isEmpty) {
            return  Center(
              child: ConstText(
                text: t.plan_no_available,
                color: Colors.white54,
              ),
            );
          }

          final plans = plansMap[durationKeys[selectedDurationIndex]] ?? [];

          if (selectedPlan == null && plans.isNotEmpty) {
            selectedPlan = plans.first;
            selectedPlanIndex = 0;
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                HomeHeroSlider(banners: banners),

                _buildStickyTabBar(durationKeys),

                AppSizes.spaceH(16),

                /// 🔹 PLANS LIST
                SizedBox(
                  height: 300.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: plans.length,
                    separatorBuilder: (_, __) => AppSizes.spaceW(16),
                    itemBuilder: (_, i) => _buildPlanCard(plans[i], i,t),
                  ),
                ),

                AppSizes.spaceH(30),

                /// 🔹 SUBSCRIBE BUTTON
                AppBtn(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  onTap: selectedPlan == null
                      ? null
                      : () {


                    if (!allowIfInternet(context: context, ref: ref)) return;

                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => CommonConfirmSheet(
                        title: t.plan_buy_title,
                        // subtitle: "Continue with ${selectedPlan!.name} for ₹${selectedPlan!.price}?",
                        subtitle: t.plan_buy_subtitle(
                          selectedPlan!.name ?? "",
                          selectedPlan!.price?.toString() ?? "",
                        ),
                        confirmText: t.plan_buy_confirm,
                        cancelText: t.plan_buy_cancel,
                        imagePath: Assets.iconMyPlan,
                        onConfirm: () async {


                          GlobalLoader.show(context);
                          await ref.read(paymentProvider.notifier)
                              .startPayment(
                            amount: selectedPlan!.price!.toDouble(),
                            planId: selectedPlan!.id.toString(),
                          );
                          // ignore: use_build_context_synchronously
                          GlobalLoader.hide(context);
                        },
                      ),
                    );
                  },
                  child:  ConstText(
                    text: t.plan_subscribe_now,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                AppSizes.spaceH(12),

                Center(
                  child: ConstText(
                    text: t.plan_no_commitment,
                    color: Colors.white54,
                  ),
                ),

                AppSizes.spaceH(20),
              ],
            ),
          );
        }
    );
  }


  Widget _buildPlanCard(HalfYearly plan, int index, AppLocalizations t) {
    final active = selectedPlanIndex == index;

    return GestureDetector(
      onTap: () => setState(() {
        selectedPlanIndex = index;
        selectedPlan = plan;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: 220.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: active
              ? const Color(0xFF141414) // premium dark
              : AppColors.textSecondary.withAlpha(40),
          border: Border.all(
            color: active
                ? const Color(0xFFB11226) // accent red
                : AppColors.textSecondary.withAlpha(14),
            width: active ? 1.4 : 0.6,
          ),
          boxShadow: active
              ? [
            BoxShadow(
              color: const Color(0xFFB11226).withAlpha(20),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstText(
              text: plan.name ?? "",
              fontSize: AppConstant.fontSizeThree,
              fontWeight: AppConstant.semiBold,
              color: AppColors.textPrimary,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            ),
            AppSizes.spaceH(5),
            if (active)
              Align(
                alignment: AlignmentGeometry.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB11226),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ConstText(
                    text: t.plan_subscribe_now, // "Selected"
                    fontSize: 10,
                    fontWeight: AppConstant.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            AppSizes.spaceH(5),

            ConstText(
              text: "₹${plan.price}",
              fontSize: 28,
              fontWeight: AppConstant.extraBold,
              color: Colors.white,
            ),

            AppSizes.spaceH(6),

            ConstText(
              text: plan.description ?? "",
              maxLine: 3,
              fontSize: AppConstant.fontSizeOne,
              color: Colors.white70,
            ),

            AppSizes.spaceH(14),

            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: active
                      ? [
                    const Color(0xFFB11226),
                    Colors.transparent,
                  ]
                      : [
                    Colors.white24,
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            AppSizes.spaceH(12),

            /// 📋 FEATURES
            _featureRow(t.plan_feature_quality, plan.quality),
            _featureRow(t.plan_feature_devices, "${plan.deviceLimit}"),
            _featureRow(t.plan_feature_downloads, "${plan.downloadsAllowed}"),
            _featureRow(
              t.plan_feature_ads,
              plan.ads == true ? t.plan_feature_yes : t.plan_feature_no,
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          ConstText(text: "$title: ", fontSize: 12, color: Colors.white54),
          ConstText(text: value ?? "-", fontSize: 12, color: Colors.white),
        ],
      ),
    );
  }

  Map<String, List<HalfYearly>> buildPlansMap(SubscriptionListData data) {
    final map = <String, List<HalfYearly>>{};

    if (data.monthly.isNotEmpty) {
      map["monthly"] = data.monthly;
    }
    if (data.quarterly.isNotEmpty) {
      map["quarterly"] = data.quarterly;
    }
    if (data.halfYearly.isNotEmpty) {
      map["half_yearly"] = data.halfYearly;
    }
    if (data.yearly.isNotEmpty) {
      map["yearly"] = data.yearly;
    }

    return map;
  }

  String formatDuration(String key) {
    return key.replaceAll("_", " ").toUpperCase();
  }

  Widget _buildStickyTabBar(List<String> durationKeys) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: UpgradedCategorySelector(
        categories: durationKeys.map(formatDuration).toList(),
        selectedIndex: selectedDurationIndex,
        onSelect: (i) {
          setState(() {
            selectedDurationIndex = i;
            selectedPlanIndex = 0;
            selectedPlan = null;
          });
        },
      ),
    );
  }

}
