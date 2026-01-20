import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/format/date_time_formater.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/subscription_plan_notifer.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class MyPlanHistory extends HookConsumerWidget {
  const MyPlanHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final t=AppLocalizations.of(context)!;
    final state = ref.watch(subscriptionNotifierProvider);
    final notifier = ref.read(subscriptionNotifierProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_){
        notifier.getUserPlanHistory();

      });
      return null;
    }, const []);

    final plans = state.userPlanHistory?.data ?? [];

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.blackPrimary,
        body: CommonScreenContainer(
          title: t.mySubscriptionTitle,
          scrollable: false,
          child: state.isLoading
              ? HomeScreenShimmer()
              : ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: plans.length,
            itemBuilder: (_, index) {
              final plan = plans[index];
              final isActive = plan.isActive == true;
              return _planCard(plan, isActive,t);
            },
          ),
        ),
      ),
    );
  }

  Widget _planCard(dynamic plan, bool isActive,AppLocalizations t) {
    final addons = plan.addons ?? [];

    return Container(
      margin:  EdgeInsets.only(bottom: 14.h),
      padding:  EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
          colors: [Color(0xFFB11226), Color(0xFF5A0A14)],
        )
            : null,
        color: isActive ? null : AppColors.textPrimary.withAlpha(20),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isActive ? const Color(0xFFB11226) : Colors.white12,
          width: isActive ? 1.4 : 0.6,
        ),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: const Color(0xFFB11226).withAlpha(30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔖 ACTIVE BADGE
          if (isActive)
            Container(
              margin:  EdgeInsets.only(bottom: 8.h),
              padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.background.withAlpha(100),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child:  ConstText(
                text:t.currentPlan,
                fontWeight: FontWeight.bold,
              ),
            ),

          ConstText(
            text: plan.name ?? "",
            fontSize: isActive ? 18.sp : 15.sp,
            fontWeight: FontWeight.bold,
          ),

          AppSizes.spaceH(06),

          ConstText(
            text: "₹${plan.price}  •  ${plan.duration?.toUpperCase()}",
            fontSize: 13.sp,
            color: Colors.white70,
          ),



          AppSizes.spaceH(10),

          _feature(t.startDate, DateTimeFormat.formatShortDate(plan.startAt)),
          _feature(t.expireDate,DateTimeFormat.formatShortDate(plan.expiresAt)),
          _feature(t.quality, plan.quality),
          _feature(t.devices, plan.finalDeviceLimit?.toString()),
          _feature(t.ads, plan.ads == 1 ? t.yes : t.no),
          if (addons.isNotEmpty) ...[
            AppSizes.spaceH(12),

            Divider(color: Colors.white24),

            AppSizes.spaceH(8),

             ConstText(
              text:t.addons,
              fontWeight: FontWeight.bold,
            ),

            AppSizes.spaceH(6),

            ...addons.map((addon) => _addonTile(addon,t)),
          ],



        ],
      ),
    );
  }

  Widget _feature(String title, String? value) {
    return Padding(
      padding:  EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          ConstText(text: "$title: ",  color: Colors.white54,fontSize: AppConstant.fontSizeZero,),
          ConstText(text: value ?? "-",fontSize: AppConstant.fontSizeZero,),
        ],
      ),
    );
  }


  Widget _addonTile(dynamic addon,AppLocalizations t) {
    final String title =
    addon.addonKey == "device_limit"
        ? t.extraDevices
        : addon.addonKey == "download_limit"
        ? t.extraDownloads
        : t.addon;

    final String valueText =
    addon.addonKey == "device_limit"
        ? "+${addon.addonValue} ${t.addonDevicesValue}"
        : addon.addonKey == "download_limit"
        ? "+${addon.addonValue} ${t.addonDownloadsValue}"
        : "+${addon.addonValue}";

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.blackPrimary.withAlpha(50),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ➕ ICON
          Container(
            height: 28.r,
            width: 28.r,
            decoration: BoxDecoration(
              color: Colors.greenAccent.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              size: 16,
              color: Colors.greenAccent,
            ),
          ),

          AppSizes.spaceW(10),

          /// 📄 TITLE + MEANING
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstText(
                  text: "$title : ",
                  fontSize: AppConstant.fontSizeZero-1,
                  color: Colors.white60,

                ),
                AppSizes.spaceW(2),

                ConstText(
                  text: valueText,
                  fontSize: AppConstant.fontSizeZero ,
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withAlpha(10),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ConstText(
              text: "₹${addon.userPaidPrice}",
              fontSize: AppConstant.fontSizeZero,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }



}
