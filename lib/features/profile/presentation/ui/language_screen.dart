import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart' show AppConstant;
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart' show CommonScreenContainer;
import 'package:stream4videos/features/share_pref/language/language_notifier.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';




class LanguageScreen extends HookConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    const List<Map<String, String>> appLanguages = [
      {
        'code': 'hi',
        'title': 'Hindi',
        'key': 'hindi',
        'image': Assets.imageHindiLang,
      },
      {
        'code': 'en',
        'title': 'English',
        'key': 'english',
        'image': Assets.imageEnglishLang,
      },
      {
        'code': 'pa',
        'title': 'Punjabi',
        'key': 'punjabi',
        'image': Assets.imagePunjabiLang,
      },
    ];


    final t = AppLocalizations.of(context)!;

    final locale = ref.watch(languageProvider);
    final selectedCode = locale.languageCode;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title: t.chooseLanguage,
          child: Column(
            children: [
              AppSizes.spaceH(10),
              ...appLanguages.map((lang) {
                final code = lang['code']!;
                final key = lang['key']!;
                final image = lang['image']!;
                final title = lang['title']!;

                return _languageTile(
                  title: title,
                  subtitle: langText(t, key),
                  image: image,
                  selected: selectedCode == code,
                  onTap: () {
                    ref
                        .read(languageProvider.notifier)
                        .changeLanguage(code);
                  },
                );
              }),
              AppSizes.spaceH(10),


              AppBtn(
                title:t.continues,
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String langText(AppLocalizations t, String key) {
  switch (key) {
    case 'hindi':
      return t.hindi;
    case 'english':
      return t.english;
    case 'punjabi':
      return t.punjabi;
    case 'bhojpuri':
      return t.bhojpuri;
    default:
      return key;
  }
}

Widget _languageTile({
  required String title,
  required String subtitle,
  required String image,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 120.h,
      margin: EdgeInsets.only(bottom: 25.h),
      decoration: BoxDecoration(
        gradient: selected
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.textPrimary.withAlpha(60),
            AppColors.textPrimary.withAlpha(20),
          ],
        )
            : null,
        color: selected ? null : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? AppColors.textPrimary
              : AppColors.textHint.withAlpha(50),
          width: selected ? 1.6 : 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withAlpha(selected ? 40 : 20),
            blurRadius: selected ? 14 : 8,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin:  EdgeInsets.symmetric(horizontal: 14.w),
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.textPrimary.withAlpha(60),
            ),
            child: Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: AppColors.textSecondary,
              size: 26,
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstText(
                  text: title,
                  fontSize: AppConstant.fontSizeLarge,
                  fontWeight: FontWeight.w600,
                ),
                AppSizes.spaceH(4),
                ConstText(
                  text: subtitle,
                  fontSize: AppConstant.fontSizeOne,
                  color: AppColors.textSecondary.withAlpha(50),
                ),
              ],
            ),
          ),

          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: double.infinity,
              width: 120.w,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    ),
  );
}


