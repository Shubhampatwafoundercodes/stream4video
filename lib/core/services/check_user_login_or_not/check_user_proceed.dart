import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/services/networkChecker/internet_service_provider.dart';
import 'package:stream4videos/core/services/networkChecker/network_check.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/bottom_sheet/show_sheet.dart';

import '../../../features/share_pref/user_provider.dart';

void checkLoginOnly({
  required BuildContext context,
  required WidgetRef ref,
  required VoidCallback onAllowed,
}) {

  /// 🌐 INTERNET CHECK
  if (!allowIfInternet(context: context, ref: ref)) return;



  final user = ref.read(userProvider);

  if (user == null || user.isGuest) {
    showLoginRequiredSheet(
      context,
      onConfirm: () {
        context.go(RoutesName.loginScreen);
      },
    );
    return;
  }

  onAllowed();
}


void checkLoginAndPremium({
  required BuildContext context,
  required WidgetRef ref,
  required bool isPremiumContent,
  required Future<void> Function() onAllowed,
}) async {


  if (!allowIfInternet(context: context, ref: ref)) return;



  final user = ref.read(userProvider);

  if (user == null || user.isGuest) {
    showLoginRequiredSheet(
      context,
      onConfirm: () {
        context.go(RoutesName.loginScreen);
      },
    );
    return;
  }

  // 2️⃣ Premium required
  if (isPremiumContent && user.hasActivePlan != true) {
    showRechargeRequiredSheet(
      context,
      onConfirm: () {
        context.push(RoutesName.myPlanScreen);
      },
    );
    return;
  }

  // 3️⃣ Allowed
   onAllowed();
}


bool allowIfInternet({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final status = ref.read(internetStatusProvider);

  final disconnected = status.maybeWhen(
    data: (s) => s == InternetStatus.disconnected,
    orElse: () => false,
  );

  if (disconnected) {
    showNoInternetSheet(
      context,
      onRetry: () {
        // context.pop();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(internetServiceProvider).retryCheck();
        });
        },
    );
    return false;
  }

  return true;
}


