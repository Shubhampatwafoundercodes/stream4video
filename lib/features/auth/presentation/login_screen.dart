import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_border.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_cached_image.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/app_text_field.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/utils/validator/app_input_formatters.dart';
import 'package:stream4videos/core/utils/validator/app_validator.dart';
import 'package:stream4videos/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/l10n/app_localizations.dart';
import 'package:stream4videos/main.dart';


class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final t= AppLocalizations.of(context)!;
    final phoneController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final authN=ref.read(authNotifierProvider.notifier);
    final authState=ref.watch(authNotifierProvider);

    useEffect((){
      authN.allBannerApi();
      return null;

    },[]);

    final currentIndex = useState(0);
    final scale = useState(1.3);
    useState(true);
    final zoomTimer = useRef<Timer?>(null);
    final banners = authState.bannerModel?.data ?? [];
    final hasBanners = banners.isNotEmpty;
    final safeIndex = hasBanners
        ? currentIndex.value.clamp(0, banners.length - 1)
        : 0;

    useEffect(() {
      return () {
        zoomTimer.value?.cancel();
      };
    }, []);

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: banners.isEmpty
                  ? const SizedBox()
                  : CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  final banner = banners[index];
                  return AnimatedScale(
                    scale: currentIndex.value == index ? scale.value : 1.0,
                    duration: const Duration(milliseconds: 8600),
                    curve: Curves.easeInOut,
                    child: AppCachedImage(
                      url: banner.image??"",
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: screenHeight,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                    scale.value = 1.3;

                    zoomTimer.value?.cancel();
                    zoomTimer.value = Timer(const Duration(milliseconds: 3000), () {
                      scale.value = 1.0;
                    });
                  },
                ),
              ),
            ),
            Positioned.fill(child: Container(color: Colors.black45)),
            Positioned(
              bottom: screenHeight * 0.28,
              left: 0,
              right: 0,
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.black87, Colors.transparent],
                    stops: [0.0, 0.35, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasBanners) ...[
                      ConstText(
                        text: banners[safeIndex].title ?? "",
                        fontSize: AppConstant.fontSizeLargeHeading,
                        fontWeight: AppConstant.semiBold,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 6.h),
                      ConstText(
                        text: banners[safeIndex].description ?? "",
                        fontSize: AppConstant.fontSizeThree,
                        color: AppColors.textHint,
                      ),
                      SizedBox(height: 16.h),
                    ],
                    if (hasBanners)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        banners.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: currentIndex.value == index ? 8 : 6,
                          height: currentIndex.value == index ? 8 : 6,
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex.value == index
                                ? Colors.white
                                : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                onTap: () async{

                  if (!allowIfInternet(context: context, ref: ref)) return;


                  ref.read(userProvider.notifier).continueAsGuest();
                  context.go(RoutesName.homeScreen);
                },
                child: Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackground,
                    borderRadius: AppBorders.btnRadius,
                  ),
                  child: ConstText(
                    text: t.login_skip,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConstText(
                        text: t.login_title,
                        fontSize: AppConstant.fontSizeLarge,
                        fontWeight: AppConstant.semiBold,
                      ),
                    ),
                    AppSizes.spaceH(20),

                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: AppTextField(
                        labelText: t.login_mobileLabel,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 2, right: 8),
                          child: ConstText(text: "+91 | "),
                        ),
                        hintText: t.login_mobileHint,
                        maxLength: 10,
                        validator: AppValidator.validateMobile,
                        inputFormatters: AppInputFormatters.digitsOnly,
                      ),
                    ),

                    AppSizes.spaceH(12),
                    ConstText(
                      text:
                         t.login_otpInfo,
                      color: AppColors.textTertiary,
                      fontSize: AppConstant.fontSizeZero,
                    ),
                    AppSizes.spaceH(25),

                    AppBtn(
                      title: t.continues,
                      onTap: () async {

                        if (!allowIfInternet(context: context, ref: ref)) return;

                        final isValid = formKey.currentState?.validate() ?? false;
                        if (!isValid) return;

                        final phone = phoneController.text.trim();
                        GlobalLoader.show( message: t.login_sendingOtp);

                        final success = await ref.read(authNotifierProvider.notifier).sendOtp(phone);

                        if (!context.mounted) return;

                        GlobalLoader.hide();

                        if (success) {
                          context.push(RoutesName.otpScreen, extra: phone);
                          phoneController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Failed to send OTP")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
