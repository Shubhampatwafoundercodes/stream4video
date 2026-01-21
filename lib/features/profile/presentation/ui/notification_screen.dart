  import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:hooks_riverpod/hooks_riverpod.dart';
  import 'package:stream4videos/core/res/app_color.dart';
  import 'package:stream4videos/core/res/app_constant.dart' show AppConstant;
  import 'package:stream4videos/core/res/app_size.dart';
  import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/format/date_time_formater.dart';
  import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:stream4videos/features/profile/presentation/notifier/notification_notifier.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

  class NotificationScreen extends HookConsumerWidget {
    const NotificationScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final notificationState = ref.watch(notificationProvider);
      final t=AppLocalizations.of(context)!;
      useEffect(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(notificationProvider.notifier)
              .fetchNotifications(); // userId
        });
        return null;
      }, const []);

      return SafeArea(
        top: false,
        child: Scaffold(
          body: CommonScreenContainer(
            title: t.settings_notifications,
            child: notificationState.when(
              error: (e, _) => Center(
                child: ConstText(text: t.payment_failed_subtitle),
              ),
              loading: () => MovieSectionShimmer(),
              data: (list){
                if (list.isEmpty) {
                  return const Center(
                    child: ConstText(text: "No Notifications found"),
                  );
                }

                return   Column(
                  children: [
                    AppSizes.spaceH(10),

                    ...list.map((item) => _notificationTile(
                        title: item.title as String,
                        message: item.description as String,
                        time:DateTimeFormat.formatTime(item.createdAt ?? DateTime.now()),
                        isRead: item.status==1,
                        onTap: () {


                        },
                      ),
                    ),

                    AppSizes.spaceH(30),
                  ],
                );
              }

            ),





          ),
        ),
      );
    }

    Widget _notificationTile({
      required String title,
      required String message,
      required String time,
      required bool isRead,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: isRead
                ? null
                : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.textPrimary.withAlpha(55),
                AppColors.textPrimary.withAlpha(15),
              ],
            ),


          color: isRead ? AppColors.surfaceLight : null,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isRead
                  ? AppColors.textHint.withAlpha(50)
                  : AppColors.textPrimary,
              width: isRead ? 0.4 : 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackPrimary.withAlpha(isRead ? 20 : 40),
                blurRadius: isRead ? 8 : 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [

              /// 📝 TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstText(
                      text: title,
                      fontSize: AppConstant.fontSizeThree,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                    AppSizes.spaceH(06),
                    ConstText(
                      text: message,
                      fontSize: AppConstant.fontSizeOne,
                      color: AppColors.textSecondary.withAlpha(80),
                      maxLine: 2,
                    ),
                    AppSizes.spaceH(06),
                    ConstText(
                      text: time,
                      fontSize: AppConstant.fontSizeZero,
                      color: AppColors.textHint,
                    ),
                  ],
                ),
              ),

              if (!isRead)
                Container(
                  width: 8.w,
                  height: 8.h,
                  margin:  EdgeInsets.only(left: 8.w),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      );
    }

  }
