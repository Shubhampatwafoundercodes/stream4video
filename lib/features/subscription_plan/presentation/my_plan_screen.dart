import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';

import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/features/home/presentation/ui/section/widget/animated_golden_batch.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';

import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/features/subscription_plan/presentation/widget/current_plan_with_add_on_widget.dart';

import 'package:stream4videos/features/subscription_plan/presentation/widget/subscription_plan_widget.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class MyPlanScreen extends HookConsumerWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final t= AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final hasActivePlan = user?.hasActivePlan == true;

    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.blackPrimary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          titleSpacing: 0,

          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildProfileHeader(context,t),
          ),
        ),
        body: RefreshIndicator(

          color: AppColors.primary,
          backgroundColor: AppColors.blackPrimary,
          onRefresh: ()async{

            await ref.read(profileNotifierProvider.notifier).getProfile();
          },
          child: hasActivePlan?
              CurrentPlanWithAddOnWidget():
               SubscriptionPlanWidget(),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context,AppLocalizations t) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
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
            texts: [
            t.badge_unlimited,
            t.badge_maximum,
            t.badge_priority,
            t.badge_advanced,
            t.badge_standard,
            t.badge_secure,
            ],
            width: 90.w,
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
