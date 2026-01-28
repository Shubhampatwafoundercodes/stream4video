import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart' show RoutesName;
import 'package:stream4videos/core/widget/bottom_sheet/show_sheet.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/core/widget/common_help_option_tile.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final t =AppLocalizations.of(context)!;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title: t.settings_title,
          scrollable: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonHelpOptionTile(
              //   icon: Icons.download_outlined,
              //   title: "Downloads",
              //   onTap: () {
              //     // context.push(RoutesName.downloadScreen);
              //   },
              // ),

              /// ❤️ WATCHLIST
              CommonHelpOptionTile(
                icon: Icons.favorite_border,
                title: t.settings_watchlist,
                onTap: ()async {

                  GlobalLoader.show();
                  final notifier = ref.read(categoryNotifierProvider.notifier);
                  await notifier.getMyWatchListApi();
                  GlobalLoader.hide();
                  // ignore: use_build_context_synchronously
                  context.push(RoutesName.watchListScreen);
                },
              ),

              /// 🔔 NOTIFICATIONS
              CommonHelpOptionTile(
                icon: Icons.notifications_none,
                title: t.settings_notifications,
                onTap: () {

                  context.pushNamed(RoutesName.notificationScreen);


                },
              ),

              /// 🌐 LANGUAGE
              CommonHelpOptionTile(
                icon: Icons.language,
                title: t.settings_language,
                onTap: () {
                  context.pushNamed(RoutesName.languageScreen);
                },
              ),

              /// 🚪 LOGOUT
              CommonHelpOptionTile(
                icon: Icons.logout,
                title:t.settings_logout,
                onTap: () {

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) {
                      return CommonConfirmSheet(
                        imagePath: Assets.imageLogoutIc,
                        title: t.settings_logout_confirm_title,
                        confirmText:t.settings_logout_confirm_button,
                        onConfirm: () async {
                          GlobalLoader.show();
                          final deviceId= ref.read(profileNotifierProvider.notifier).deviceId;
                            final isLogout = await ref.read(authNotifierProvider.notifier).logoutActiveDevice(deviceId, isLoginScreen: false);
                            if(isLogout==2){
                             await ref.read(userProvider.notifier).clearAll();
                             // ignore: use_build_context_synchronously
                             context.go(RoutesName.splash);
                           } else if(isLogout ==3){
                              showSessionExpiredSheet(ref);

                            }

                          // ignore: use_build_context_synchronously
                          GlobalLoader.hide();

                        },
                      );
                    },
                  );





                },
              ),

              // CommonHelpOptionTile(
              //   icon: Icons.delete_outline,
              //   title: "Delete Account",
              //   onTap: () {
              //
              //     showModalBottomSheet(
              //       context: context,
              //       backgroundColor: Colors.transparent,
              //       isScrollControlled: true,
              //       builder: (_) {
              //         return CommonConfirmSheet(
              //           imagePath: Assets.imageDeleteAcount,
              //           title: "Delete your account permanently?",
              //           confirmText: "Delete",
              //           onConfirm: () {
              //
              //
              //
              //           },
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
