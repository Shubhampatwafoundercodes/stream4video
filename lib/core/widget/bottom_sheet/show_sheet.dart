import 'package:flutter/material.dart' ;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/core/utils/routes/routes.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

void showRechargeRequiredSheet(
    BuildContext context, {
      required VoidCallback onConfirm,
    }) {

  final t = AppLocalizations.of(context)!;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.iconMyPlan,
        title: t.premiumContent,
        subtitle: t.subscribeToWatch,
        confirmText: t.subscribeNow,
        cancelText: t.later,
        onConfirm: () {
          context.pop();
          onConfirm();
        },
      );
    },
  );
}



void showLoginRequiredSheet(
    BuildContext context, {
      required VoidCallback onConfirm,
    }) {

  final t = AppLocalizations.of(context)!;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.imageLogoutIc,
        title: t.loginRequired,
        subtitle: t.loginFirstToContinue,
        confirmText: t.login,
        cancelText: t.cancel,
        danger: true,
        onConfirm: () {
          context.pop();
          onConfirm();
        },
      );
    },
  );
}



void showNoInternetSheet(
    BuildContext context, {
      required VoidCallback onRetry,
    }) {
  final t = AppLocalizations.of(context)!;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.iconNoInternet,
        title: t.noInternet,
        subtitle: t.turnOnInternet,
        confirmText: t.retry,
        cancelText: t.cancel,
        danger: true,
        onConfirm: () {
          onRetry();
        },
      );
    },
  );
}


void showSessionExpiredSheet(WidgetRef ref) {
  final context = navigatorKey.currentContext;

  if (context == null) return;
  final t = AppLocalizations.of(context)!;


  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.iconUnauth,
        title: t.sessionExpiredTitle,
        danger: true,
        subtitle: t.sessionExpiredSubtitle,
        confirmText: t.continues,
        cancelText: "",
        onConfirm: () async {
          ref.read(userProvider.notifier).invalidateAllProviders(ref);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(RoutesName.loginScreen);
        });
        },
      );
    },
  );
}

