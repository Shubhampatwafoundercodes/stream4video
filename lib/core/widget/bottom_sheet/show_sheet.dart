import 'package:flutter/material.dart' ;
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/generated/assets.dart';

void showRechargeRequiredSheet(
    BuildContext context, {
      required VoidCallback onConfirm,
    }) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.iconMyPlan,
        title: "Premium content",
        subtitle: "Please subscribe to watch this video",
        confirmText: "Subscribe Now",
        cancelText: "Later",
        onConfirm: () {
          Navigator.pop(context);
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
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.imageLogoutIc,
        title: "Login required",
        subtitle: "Please login first to continue",
        confirmText: "Login",
        cancelText: "Cancel",
        danger: true,
        onConfirm: () {
          Navigator.pop(context);
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
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return CommonConfirmSheet(
        imagePath: Assets.iconNoInternet, // 🔌 wifi-off icon
        title: "No Internet",
        subtitle: "Please turn on your internet connection",
        confirmText: "Retry",
        cancelText: "Cancel",
        danger: true,
        onConfirm: () {
          onRetry();
        },
      );
    },
  );
}



