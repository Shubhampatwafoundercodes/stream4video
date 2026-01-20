import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:stream4videos/core/utils/routes/routes.dart';




class AppToast {
  static BuildContext? get _ctx => navigatorKey.currentContext;

  static void premium(String message) {
    final ctx = _ctx;
    if (ctx == null) return;

    MotionToast(
      icon: Icons.workspace_premium,
      primaryColor: const Color(0xFFFFC107),
      secondaryColor: Colors.white,
      title: const Text(
        "Premium",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      description: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),

      /// ✅ CORRECT ENUM
      animationType: AnimationType.slideInFromBottom,

      borderRadius: 14,
      toastDuration: const Duration(seconds: 3),
      dismissable: true,
    ).show(ctx);
  }

  static void success(String msg) {
    final ctx = _ctx;
    if (ctx == null) return;

    MotionToast.success(
      description: Text(msg),
      animationType: AnimationType.slideInFromTop,
      toastDuration: const Duration(seconds: 2),
    ).show(ctx);
  }

  static void error(String msg) {
    final ctx = _ctx;
    if (ctx == null) return;

    MotionToast.error(
      description: Text(msg),
      animationType: AnimationType.slideInFromBottom,
    ).show(ctx);
  }

  /// ⚠️ WARNING
  static void warning(String msg) {
    final ctx = _ctx;
    if (ctx == null) return;

    MotionToast.warning(
      title: const Text("Warning"),
      description: Text(msg),
      animationType: AnimationType.slideInFromTop,
      toastDuration: const Duration(seconds: 3),
    ).show(ctx);
  }









}


