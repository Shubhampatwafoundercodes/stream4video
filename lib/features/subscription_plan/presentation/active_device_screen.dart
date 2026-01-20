// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class DeviceViewData {
  final String deviceId;
  final String deviceName;
  final String subtitle;
  final bool isCurrent;

  DeviceViewData({
    required this.deviceId,
    required this.deviceName,
    required this.subtitle,
    required this.isCurrent,
  });
}

class ActiveDeviceScreen extends HookConsumerWidget {
  const ActiveDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = useMemoized(
      () => ref.read(authNotifierProvider.notifier).buildDeviceList(),
    );
    final snapshot = useFuture(future);

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: CommonScreenContainer(
        scrollable: false,
        title: t.active_device_title,
        child: snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : snapshot.hasError
            ? Center(child: Text(t.active_device_loading_error))
            : _content(ref, snapshot.data ?? [], t),
      ),
    );
  }

  Widget _content(
    WidgetRef ref,
    List<DeviceViewData> devices,
    AppLocalizations t,
  ) {
    final currentDevices = devices.where((e) => e.isCurrent).toList();
    final otherDevices = devices.where((e) => !e.isCurrent).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 18.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1B1F),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning,
                size: 22,
              ),
              AppSizes.spaceH(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstText(
                      text: t.active_device_limit_title,
                      fontWeight: AppConstant.bold,
                      fontSize: AppConstant.fontSizeThree,
                    ),
                    SizedBox(height: 6),
                    ConstText(
                      text: t.active_device_limit_desc,
                      fontSize: AppConstant.fontSizeOne,
                      color: AppColors.textTertiary,
                    ),
                    AppSizes.spaceH(6),
                    ConstText(
                      text: t.active_device_limit_note,
                      fontSize: AppConstant.fontSizeZero,
                      color: AppColors.textHint,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        ConstText(
          text: t.active_device_your_devices,
          fontWeight: AppConstant.semiBold,
          fontSize: AppConstant.fontSizeThree,
        ),
        AppSizes.spaceH(12),

        ...currentDevices.map(
          (device) => _AnimatedDeviceCard(
            delay: 200,
            child: _deviceCard(
              // context,
              t,
              device: device,
            ),
          ),
        ),

        AppSizes.spaceH(15),
        if (otherDevices.isNotEmpty) ...[
          ConstText(
            text: t.active_device_other_devices,
            fontWeight: AppConstant.semiBold,
            fontSize: AppConstant.fontSizeThree,
          ),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),

              itemCount: otherDevices.length,
              itemBuilder: (context, index) {
                final device = otherDevices[index];
                return _AnimatedDeviceCard(
                  delay: 120 * index,
                  child: _deviceCard(
                    t,
                    device: device,
                    onLogout: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (sheetContext) {
                          return CommonConfirmSheet(
                            imagePath: Assets.imageLogoutIc,
                            title: t.active_device_logout_confirm_title,
                            subtitle: t.active_device_logout_confirm_subtitle,
                            confirmText: t.active_device_logout_confirm_button,
                            danger: true,
                            onConfirm: () async {
                              GlobalLoader.show(
                                context,
                                message: t.active_device_logout_loading,
                              );

                              final loginResult = await ref
                                  .read(authNotifierProvider.notifier)
                                  .logoutActiveDevice(device.deviceId);
                              GlobalLoader.hide(context);
                              if (!context.mounted) return;
                              if (loginResult == 1) {
                                context.go(RoutesName.homeScreen);
                                return;
                              }
                              if (loginResult == 2) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return CommonConfirmSheet(
                                      imagePath: Assets.imageBlock,
                                      danger: true,
                                      title: t.active_device_limit_title,
                                      subtitle: t
                                          .active_device_already_logged_in_subtitle,
                                      confirmText: t.continues,
                                      onConfirm: () {
                                        context.pop();
                                      },
                                    );
                                  },
                                );

                                return;
                              }

                              // await ref.read(userProvider.notifier).clearUser();
                            },
                          );
                        },
                      );
                      // _confirmLogout(context, device.deviceId);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  /// 🔹 DEVICE CARD
  Widget _deviceCard(
    AppLocalizations t, {
    required DeviceViewData device,
    VoidCallback? onLogout,
  }) {
    final isCurrent = device.isCurrent;

    return Container(
      margin:  EdgeInsets.only(bottom: 14.h),
      padding:  EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: isCurrent
            ? LinearGradient(
                colors: [
                  Colors.green.withAlpha(15),
                  Colors.green.withAlpha(05),
                ],
              )
            : const LinearGradient(
                colors: [Color(0xFF1F2024), Color(0xFF16171A)],
              ),
        borderRadius: BorderRadius.circular(16),
        border: isCurrent ? null : Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: isCurrent ? Colors.green.withAlpha(20) : Colors.white10,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.devices,
              color: isCurrent ? Colors.greenAccent : Colors.white70,
            ),
          ),

          AppSizes.spaceW(14),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstText(
                  text: device.deviceName,
                  fontWeight: AppConstant.semiBold,
                ),
                AppSizes.spaceH(4),
                ConstText(
                  text: device.subtitle,
                  fontSize: AppConstant.fontSizeOne,
                ),
              ],
            ),
          ),

          /// ACTION
          if (isCurrent)
            _currentBadge()
          else
            GestureDetector(
              onTap: onLogout,
              child: ConstText(
                text: t.active_device_logout,
                color: AppColors.error,
                fontWeight: AppConstant.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _currentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  ConstText(text:
        "This device",
        fontSize: AppConstant.fontSizeOne,
      ),
    );
  }

  // void _confirmLogout(BuildContext context, String deviceId,) {
  //
  // }
}

class _AnimatedDeviceCard extends StatelessWidget {
  final Widget child;
  final int delay;

  const _AnimatedDeviceCard({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}
