import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/services/check_user_login_or_not/check_user_proceed.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_confirm_sheet.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_screen_section.dart';
import 'package:stream4videos/features/home/presentation/ui/section/free_movie_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/section/premium_movie_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/section/search_screen.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/generated/assets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/l10n/app_localizations.dart'
    show AppLocalizations;

final bottomNavProvider = StateProvider<int>((ref) => 0);

class BottomNavigationBar extends ConsumerStatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  ConsumerState<BottomNavigationBar> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<BottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController glowController;
  late Animation<double> glowAnimation;

  final List<Widget> screens = [
    HomeScreenSection(),
    FreeMovieScreen(),
    PremiumMovieScreen(),
    SearchScreen(),
    // MyPlanScreen(),
  ];
  //
  // final navItems = const [
  //   {"label": "Home", "icon": Assets.iconHome, "index": 0, "center": false},
  //   {"label": "Free", "icon": Assets.iconOtts, "index": 1, "center": false},
  //   {"label": "Premium", "icon": Assets.iconFree, "index": 2, "center": true},
  //   {"label": "Search", "icon": Assets.iconSearch, "index": 3, "center": false},
  //   {"label": "MyPlan", "icon": Assets.iconMyPlan, "index": 4, "center": false},
  // ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryNotifierProvider.notifier).getAllCategories();
      ref.read(profileNotifierProvider.notifier).getProfile();
    });

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    glowAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: glowController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(bottomNavProvider);
    final t = AppLocalizations.of(context)!;
    final navItems = [
      {
        "label": t.bottom_home,
        "icon": Assets.iconHome,
        "index": 0,
        "center": false,
      },
      {
        "label": t.bottom_free,
        "icon": Assets.iconOtts,
        "index": 1,
        "center": false,
      },
      {
        "label": t.bottom_premium,
        "icon": Assets.iconFree,
        "index": 2,
        "center": true,
      },
      {
        "label": t.bottom_search,
        "icon": Assets.iconSearch,
        "index": 3,
        "center": false,
      },
      {
        "label": t.bottom_myplan,
        "icon": Assets.iconMyPlan,
        "index": 4,
        "center": false,
      },
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final currentIndex = ref.read(bottomNavProvider);
        if (currentIndex != 0) {
          ref.read(bottomNavProvider.notifier).state = 0;
        } else {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) {
              return CommonConfirmSheet(
                imagePath: Assets.iconExitApp,
                title: t.exit_title,
                subtitle: t.exit_subtitle,
                confirmText: t.exit_confirm,
                cancelText: t.exit_cancel,
                danger: true,

                onConfirm: () {
                  context.pop();
                  SystemNavigator.pop();
                },
              );
            },
          );
          // SystemNavigator.pop();
        }
      },

      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppColors.blackPrimary,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: screens[index],
          ),

          bottomNavigationBar: _buildBottomNav(
            currentIndex: index,
            navItems: navItems,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav({
    required int currentIndex,
    required List<Map<String, dynamic>> navItems,
  }) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0E0F12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.map((item) {
          final bool isCenter = item["center"] as bool;
          if (item["index"] == 4) {
            return _myPlanItem(item, currentIndex);
          }

          return isCenter
              ? _centerButton(item, currentIndex)
              : _navItem(item, currentIndex);
        }).toList(),
      ),
    );
  }

  Widget _navItem(Map item, int index) {
    bool active = index == item["index"];

    return GestureDetector(
      onTap: () {
        if (!allowIfInternet(context: context, ref: ref)) return;

        ref.read(bottomNavProvider.notifier).state = item["index"];
      },
      child: SizedBox(
        width: 60.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item["icon"],
              width: active ? 26.w : 22.w,
              color: active ? Colors.white : Colors.white60,
            ),

            AppSizes.spaceH(4),

            ConstText(
              text: item["label"],

              color: active ? AppColors.textPrimary : Colors.white60,
              fontSize: AppConstant.fontSizeSmall,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _myPlanItem(Map item, int currentIndex) {
    return GestureDetector(
      onTap: () async {
        if (!allowIfInternet(context: context, ref: ref)) return;

        await context.push(RoutesName.myPlanScreen);
        ref.read(bottomNavProvider.notifier).state = 0;
      },
      child: AnimatedBuilder(
        animation: glowAnimation,
        builder: (context, child) {
          return SizedBox(
            width: 60.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.amber.withOpacity(glowAnimation.value),
                        blurRadius: 18 * glowAnimation.value,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    item["icon"],
                    width: 26.w,
                    color: Colors.amberAccent,
                  ),
                ),

                AppSizes.spaceH(4),

                ConstText(
                  text: item["label"],
                  color: Colors.amberAccent,
                  fontSize: AppConstant.fontSizeSmall,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _centerButton(Map item, int index) {
    bool active = index == item["index"];

    return GestureDetector(
      onTap: () {
        if (!allowIfInternet(context: context, ref: ref)) return;

        ref.read(bottomNavProvider.notifier).state = item["index"];
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 18),
        width: active ? 70.w : 60.w,
        height: active ? 70.h : 60.h,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: active
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0B0B0B), // near black
                    Color(0xFFB11226), // crimson red
                  ],
                )
              : const LinearGradient(
                  colors: [Color(0x22FFFFFF), Color(0x11FFFFFF)],
                ),
          boxShadow: active
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),

        child: Center(
          child: Image.asset(
            item["icon"],
            width: active ? 34.w : 28.w,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
