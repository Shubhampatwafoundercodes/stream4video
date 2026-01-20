import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/features/auth/presentation/login_screen.dart';
import 'package:stream4videos/features/auth/presentation/otp_screen.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/ui/bottom_nav_bar.dart';
import 'package:stream4videos/features/home/presentation/ui/section/search_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/section/see_all_movie_list_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/section/watch_list_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/video_player/full_screen_player_screen.dart';
import 'package:stream4videos/features/home/presentation/ui/watch_movie_screen.dart';
import 'package:stream4videos/features/onboarding/splash/splash_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/edit_profile_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/help_details_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/help_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/language_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/notification_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/profile_screen.dart';
import 'package:stream4videos/features/profile/presentation/ui/setting_screen.dart';
import 'package:stream4videos/features/subscription_plan/presentation/active_device_screen.dart';
import 'package:stream4videos/features/subscription_plan/presentation/my_plan_history.dart';
import 'package:stream4videos/features/subscription_plan/presentation/my_plan_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

CupertinoPage<T> cupertinoPage<T>(Widget child) {
  return CupertinoPage<T>(child: child);
}

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutesName.splash,
  routes: [
    GoRoute(
      path: RoutesName.splash,
      name: RoutesName.splash,
      pageBuilder: (context, state) => cupertinoPage(const SplashScreen()),
    ),

    GoRoute(
      path: RoutesName.loginScreen,
      name: RoutesName.loginScreen,
      pageBuilder: (context, state) => cupertinoPage(const LoginScreen()),
    ),

    GoRoute(
      path: RoutesName.otpScreen,
      name: RoutesName.otpScreen,
      pageBuilder: (context, state) {
        final phoneNumber = state.extra as String;
        return cupertinoPage(OtpScreen(mobile: phoneNumber));
      },
    ),


    GoRoute(
      path: RoutesName.homeScreen,
      name: RoutesName.homeScreen,
      pageBuilder: (context, state) => cupertinoPage( BottomNavigationBar()),
    ),
    GoRoute(
      path: RoutesName.profileScreen,
      name: RoutesName.profileScreen,
      pageBuilder: (context, state) => cupertinoPage( ProfileScreenMinimal()),
    ),

    GoRoute(
      path: RoutesName.settingScreen,
      name: RoutesName.settingScreen,
      pageBuilder: (context, state) => cupertinoPage( SettingsScreen()),
    ),
    GoRoute(
      path: RoutesName.searchScreen,
      name: RoutesName.searchScreen,
      pageBuilder: (context, state) => cupertinoPage( SearchScreen()),
    ),
    GoRoute(
      path: RoutesName.myPlanScreen,
      name: RoutesName.myPlanScreen,
      pageBuilder: (context, state) => cupertinoPage( MyPlanScreen()),
    ),
    GoRoute(
      path: RoutesName.editProfileScreen,
      name: RoutesName.editProfileScreen,
      pageBuilder: (context, state) => cupertinoPage( EditProfileScreen()),
    ),

    GoRoute(
      path: RoutesName.helpScreen,
      name: RoutesName.helpScreen,
      pageBuilder: (context, state) => cupertinoPage( HelpCenterScreen()),
    ),

    GoRoute(
      path: RoutesName.languageScreen,
      name: RoutesName.languageScreen,
      pageBuilder: (context, state) => cupertinoPage( LanguageScreen()),
    ),
    GoRoute(
      path: RoutesName.notificationScreen,
      name: RoutesName.notificationScreen,
      pageBuilder: (context, state) => cupertinoPage( NotificationScreen()),
    ),
    GoRoute(
      path: RoutesName.watchListScreen,
      name: RoutesName.watchListScreen,
      pageBuilder: (context, state) => cupertinoPage( WatchlistScreen()),
    ),


    GoRoute(
      path: RoutesName.activeDeviceScreen,
      name: RoutesName.activeDeviceScreen,
      pageBuilder: (context, state) => cupertinoPage( ActiveDeviceScreen()),
    ),

    GoRoute(
      path: RoutesName.helpDetailScreen,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return HelpDetailScreen(
          title: args["title"],
          content: args["content"],
        );
      },
    ),

    GoRoute(
      path: RoutesName.seeAllScreen,
      name: RoutesName.seeAllScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SeeAllMovieListScreen(
          title: extra?['title'] as String? ?? "See All",
          items: (extra?['items'] as List<ContentPosterItemModel>?) ?? [],
        );
      },
    ),

    GoRoute(
      name: RoutesName.watchMovieScreen,
      path: RoutesName.watchMovieScreen,
      builder: (context, state) {
        final contentId = state.extra as String;
        return WatchMovieScreen(contentId: contentId);
      },
    ),
    GoRoute(
      path: RoutesName.fullScreenVideoPlay,
      name: RoutesName.fullScreenVideoPlay,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return FullscreenVideoScreen(
          videoUrl: extra['videoUrl'] as String,
          moreLikeThis:
          extra['moreLikeThis'] as List<ContentPosterItemModel>?,
        );
      },
    ),


    GoRoute(
      path: RoutesName.myPlanHistory,
      name: RoutesName.myPlanHistory,
      pageBuilder: (context, state) => cupertinoPage(MyPlanHistory()),
    ),



  ],
);
