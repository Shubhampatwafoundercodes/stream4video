import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/networkChecker/internet_service_provider.dart';
import 'package:stream4videos/core/services/networkChecker/network_check.dart';


import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternetBanner extends HookConsumerWidget {
  const InternetBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(internetStatusProvider);

    return statusAsync.when(
      data: (status) {
        final visible = status == InternetStatus.disconnected;

        return Material(
          child: IgnorePointer(
            ignoring: !visible,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 420),
              curve: Curves.easeOutCubic,
              offset: visible ? Offset.zero : const Offset(0, -1),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: visible ? 1 : 0,
                child: visible
                    ? const _NoInternetBannerBody()
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _NoInternetBannerBody extends HookConsumerWidget {
  const _NoInternetBannerBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blackPrimary.withAlpha(80),
                AppColors.blackPrimary.withAlpha(80),
              ],
            ),
            border: const Border(
              bottom: BorderSide(color: Colors.white12),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                /// 🔴 PULSING ICON
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) {
                    return Transform.scale(
                      scale: 1 + (controller.value * 0.08),
                      child: const Icon(
                        Icons.wifi_off_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    );
                  },
                ),

                AppSizes.spaceW(12),

                /// TEXT
                 Expanded(
                  child: ConstText(text:
                    "You're offline. Check your connection.",
                      color: AppColors.textPrimary,
                      fontWeight: AppConstant.semiBold,
                      letterSpacing: 0.2,
                  ),
                ),

                /// 🔁 RETRY
                TextButton(
                  onPressed: () {
                    ref.read(internetServiceProvider).retryCheck();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                  ),
                  child:  ConstText(text:
                    "Retry",
                  fontWeight: AppConstant.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

