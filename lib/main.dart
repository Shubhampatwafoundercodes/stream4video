import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_device.dart';
import 'package:stream4videos/core/services/networkChecker/internet_banner.dart';
import 'package:stream4videos/core/utils/theme/app_theme.dart';

import 'core/services/deeplink/deep_link_handler.dart';
import 'core/utils/routes/routes.dart';
import 'features/share_pref/language/language_notifier.dart' show languageProvider;
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage massage) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Hit massage delivered API here
}


   void main ()async {
     WidgetsFlutterBinding.ensureInitialized();

     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     // await Firebase.initializeApp();
     SystemChrome.setEnabledSystemUIMode(
       SystemUiMode.edgeToEdge,
     );
      await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


     FirebaseMessaging.onBackgroundMessage(
       _firebaseBackgroundHandler,
     );


  runApp(ProviderScope(child: const MyApp()));



}





double screenWidth = 0;
double screenHeight = 0;

class MyApp extends HookConsumerWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handler = useMemoized(() => DeepLinkHandler());
    useEffect(() {
      handler.init(context);

      return handler.dispose;
    }, const []);


    final locale = ref.watch(languageProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        screenWidth = 1.sw;
        screenHeight = 1.sh;
        final size = MediaQuery.of(context).size;
        AppDevice.init(size);

        return MaterialApp.router(
          title: 'Stream4Video',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('hi'),
            Locale('pa'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: AppColors.border,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarIconBrightness: Brightness.light,
              ),

              child: Stack(
                children: [
                  child!,

                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: InternetBanner(),
                  ),
                ],
              ),
              // child: GlobalApp(child: child),
            );
          },

          routerConfig: router,
        );
      },
    );
  }
}

