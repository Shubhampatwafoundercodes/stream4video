// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
// import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart';
// import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
// import 'package:stream4videos/features/subscription_plan/presentation/notifier/subscription_plan_notifer.dart';
//
// class CurrentPlanWithAddOnWidget extends HookConsumerWidget {
//   const CurrentPlanWithAddOnWidget({super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     final categoryState = ref.watch(categoryNotifierProvider);
//     final banners = categoryState.homeBannerModel?.data ?? [];
//     final subState = ref.watch(subscriptionNotifierProvider);
//     final subNotifier = ref.read(subscriptionNotifierProvider.notifier);
//     final profileState = ref.read(profileNotifierProvider);
//
//     final currentPlan=profileState.profile?.profile?.subscriptionData ??{};
//     final planId = currentPlan.planId?.toString();
//
//
//     final subId=cu
//
//
//     useEffect((){
//
//       WidgetsBinding.instance.addPostFrameCallback((_){
//         subNotifier.getSubscriptionAddOnPlanApi("1");
//
//       });
//
//        return null;
//     },const []);
//
//     final addons = subState.plansAddOnModel?.addons ?? [];
//
//     return SingleChildScrollView(
//
//       child: Column(
//         children: [
//           HomeHeroSlider(banners: banners),
//
//
//
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';

import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/home_hero_slider.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/subscription_plan_notifer.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/cashfree/create_paying_notifier.dart';
import 'package:stream4videos/generated/assets.dart';

class CurrentPlanWithAddOnWidget extends HookConsumerWidget {
  const CurrentPlanWithAddOnWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddonIndex = useState<int>(0);

    final categoryState = ref.watch(categoryNotifierProvider);
    final profileState = ref.watch(profileNotifierProvider);
    final subState = ref.watch(subscriptionNotifierProvider);

    final subNotifier = ref.read(subscriptionNotifierProvider.notifier);

    final banners = categoryState.homeBannerModel?.data ?? [];
    final currentPlan = profileState.profile?.profile?.subscriptionData;
    final planId=currentPlan?.planId;

    useEffect(() {
      if (planId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          subNotifier.getSubscriptionAddOnPlanApi(
            planId.toString(),
          );
        });
      }
      return null;
    }, [currentPlan?.planId]);

    final addons = subState.plansAddOnModel?.addons ?? [];

    if (subState.isLoading) {
      return const Center(child: HomeScreenShimmer());
    }
    if (currentPlan==null) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeroSlider(banners: banners),

          AppSizes.spaceH(16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: _currentPlanCard(currentPlan),
          ),

          AppSizes.spaceH(24),

          if (addons.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstText(
                  text: "Add-Ons",
                  fontSize: AppConstant.fontSizeThree,
                  fontWeight: AppConstant.semiBold,
                ),
              ),
            ),

            AppSizes.spaceH(12),

            SizedBox(
              height: 150.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                scrollDirection: Axis.horizontal,
                itemCount: addons.length,
                separatorBuilder: (_, __) => AppSizes.spaceW(16),
                itemBuilder: (_, i) => _addonCard(
                  addon: addons[i],
                  active: selectedAddonIndex.value == i,
                  onTap: () => selectedAddonIndex.value = i,
                ),
              ),
            ),

            AppSizes.spaceH(30),

            AppBtn(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              onTap: () {
                final addon = addons[selectedAddonIndex.value];

                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => CommonConfirmSheet(
                    title: "Recharge Add-On",
                    subtitle:
                    "${addon.name} for ₹${addon.price}",
                    confirmText: "Pay Now",
                    cancelText: "Cancel",
                    onConfirm: () async {
                      GlobalLoader.show(context);

                      await ref
                          .read(paymentProvider.notifier)
                          .startPayment(
                        amount: double.parse(addon.price!),
                        planId: planId.toString(),
                        addOnId: addon.id.toString()
                      );

                      GlobalLoader.hide(context);
                    }, imagePath: Assets.iconMyPlan,
                  ),
                );
              },
              child:  ConstText(
                text: "Recharge Add-On",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            AppSizes.spaceH(20),
          ],
        ],
      ),
    );
  }


  Widget _currentPlanCard(dynamic plan) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient:  LinearGradient(
          colors: [Color(0xFF1C1C1C), Color(0xFF0F0F0F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB11226), width: 1.3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB11226).withAlpha(30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color:  Color(0xFFB11226),
              borderRadius: BorderRadius.circular(20),
            ),
            child:  ConstText(
              text: "ACTIVE PLAN",
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          AppSizes.spaceH(10),

          ConstText(
            text: plan.name ?? "",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),

          AppSizes.spaceH(6),

          ConstText(
            text: "₹${plan.price}",
            fontSize: 30,
            fontWeight: AppConstant.extraBold,
          ),

          AppSizes.spaceH(10),

          ConstText(
            text: plan.description ?? "",
            fontSize: 12,
            color: Colors.white70,
            maxLine: 3,
          ),

          AppSizes.spaceH(14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip("Quality", plan.quality),
              _chip("Devices", "${plan.finalDeviceLimit}"),
              _chip("Downloads", "${plan.downloadsAllowed}"),
              _chip("Ads", plan.ads == 1 ? "Yes" : "No"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String title, String? value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstText(
        text: "$title: $value",
        fontSize: 11,
        color: Colors.white70,
      ),
    );
  }

  Widget _addonCard({
    required dynamic addon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 210.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: active
              ? const LinearGradient(
            colors: [Color(0xFF1C1C1C), Color(0xFF0F0F0F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: active ? null :AppColors.textSecondary.withAlpha(40),
          border: Border.all(
            color: active ? const Color(0xFFB11226) : Colors.white24,
            width: active ? 1.4 : 0.6,
          ),
          boxShadow: active
              ? [
            BoxShadow(
              color:  Color(0xFFB11226).withAlpha(20),
              blurRadius: 16,
              offset:  Offset(0, 8),
            )
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔴 SELECTED BADGE
            if (active)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFB11226),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const ConstText(
                  text: "SELECTED",
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            AppSizes.spaceH(8),

            /// 🧩 ADDON NAME
            ConstText(
              text: addon.name ?? "",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              maxLine: 2,
            ),

            AppSizes.spaceH(6),

            /// ➕ BENEFIT
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withAlpha(40),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ConstText(
                text: "+${addon.addonValue} Device",
                fontSize: 11,
                color: Colors.white70,
              ),
            ),

            const Spacer(),

            /// 💰 PRICE
            Align(
              alignment: Alignment.bottomRight,
              child: ConstText(
                text: "₹${addon.price}",
                fontSize: 22,
                fontWeight: AppConstant.extraBold,
              ),
            ),
          ],
        ),
      ),
    );
  }


}

