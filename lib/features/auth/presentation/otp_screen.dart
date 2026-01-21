import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/utils/validator/app_input_formatters.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class OtpScreen extends HookConsumerWidget {
  final String mobile;

  const OtpScreen({super.key, required this.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final t= AppLocalizations.of(context)!;
    final otpController = useTextEditingController();
    final remainingTime = useState(30);
    final timerRef = useRef<Timer?>(null);
    void startTimer() {
      timerRef.value?.cancel();
      remainingTime.value = 30;

      timerRef.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime.value == 0) {
          timer.cancel();
        } else {
          remainingTime.value--;
        }
      });
    }
    useEffect(() {
      startTimer();
      return () {
        timerRef.value?.cancel();
      };
    }, []);

final authN=ref.read(authNotifierProvider.notifier);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          scrollable: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ConstText(
                text: t.otp_title,
                fontWeight: AppConstant.bold,
                fontSize: AppConstant.fontSizeLarge,
              ),

              AppSizes.spaceH(8),

              ConstText(
                text: t.otp_sent_to(mobile),
                color: AppColors.textTertiary,
                fontSize: AppConstant.fontSizeThree,
              ),

              AppSizes.spaceH(30),

              /// 🔢 OTP FIELD
              _otpField(otpController),

              AppSizes.spaceH(25),

              /// ⏳ Resend
              Center(
                child: DoubleText(
                  firstText: remainingTime.value > 0
                      ? t.otp_resend_in(remainingTime.value)
                      : t.otp_didnt_receive,
                  secondText:
                  remainingTime.value > 0 ? "" : t.otp_resend_now,
                  firstColor: AppColors.textTertiary,
                  secondColor: AppColors.textPrimary,
                  firstSize: AppConstant.fontSizeZero,
                  secondSize: AppConstant.fontSizeZero,
                  onTap: () async {

                    if (!allowIfInternet(context: context, ref: ref)) return;


                    if (remainingTime.value != 0) return;

                    GlobalLoader.show( message: t.otp_resending);

                    final success = await authN.sendOtp(mobile);

                    // ignore: use_build_context_synchronously
                    GlobalLoader.hide();

                    if (!context.mounted) return;

                    if (success) {
                      startTimer(); 
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(t.otp_resend_failed)),
                      );
                    }
                  },
                ),
              ),

              const Spacer(),
              AppBtn(
                title:t.otp_verify,
                onTap: () async {

                  if (!allowIfInternet(context: context, ref: ref)) return;

                  final otp = otpController.text.trim();
                  if (otp.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.otp_invalid_length),
                      ),
                    );
                    return;
                  }
                  GlobalLoader.show(
                    message: t.otp_verifying,
                  );

                  final otpSuccess = await authN.verifyOtp(mobile, otp);

                  if (!otpSuccess) {
                    // ignore: use_build_context_synchronously
                    GlobalLoader.hide();
                    otpController.clear();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(t.otp_invalid_length)),
                    );
                    return;
                  }
                  final loginResult = await authN.login(mobile);

                  // ignore: use_build_context_synchronously
                  GlobalLoader.hide();

                  if (!context.mounted) return;
                  if (loginResult == 1) {
                    context.go(RoutesName.homeScreen);
                    return;
                  }
                  if (loginResult == 4) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) {
                        return CommonConfirmSheet(
                          imagePath: Assets.imageBlock,
                          danger: true,
                          title: t.auth_accountBlocked_title,
                          subtitle:t.auth_accountBlocked_subtitle,
                          confirmText: t.auth_accountBlocked_confirm,
                          onConfirm: () {
                            context.push(RoutesName.helpScreen);
                          },
                        );
                      },
                    );
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
                          title: t.auth_deviceLimit_title,
                          subtitle: t.auth_deviceLimit_subtitle,
                          confirmText: t.continues,
                          onConfirm: () {
                          context.push(RoutesName.activeDeviceScreen);

                          },
                        );
                      },
                    );

                    return;
                  }



                  await ref.read(userProvider.notifier).clearUser();

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(t.auth_genericError),
                    ),
                  );

                },
              ),

              AppSizes.spaceH(25),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔢 OTP FIELD UI
  Widget _otpField(TextEditingController controller) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontFamily: "Poppins"
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF292B2F), Color(0xFF18191B)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white70, width: 1.2),

      ),
    );

    return Center(
      child: Pinput(
        controller: controller,
        length: 6,
        autofocus: true,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        pinAnimationType: PinAnimationType.scale,
        animationDuration: const Duration(milliseconds: 200),
        inputFormatters: AppInputFormatters.digitsOnly,
      ),
    );
  }




}

