import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

// class NotificationService {
//
//
//
//   // Singleton Pattern
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();
//
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
//
//   // Initialization
//   Future<void> init(BuildContext context) async {
//     // 1. Request Permissions
//     await _requestPermissions();
//
//     // 2. Init Local Notifications
//     await _initLocalNotifications(context);
//      getDeviceToken();
//     // 3. Handle Foreground Messages
//     _listenForegroundMessages(context);
//
//     // 4. Handle Background/Terminated Click
//     _setupInteractedMessage(context);
//
//
//   }
//
//   Future<void> _requestPermissions() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true, badge: true, sound: true,
//       provisional: false,
//       announcement: true,
//       carPlay: true,
//       criticalAlert: true,
//
//
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint('✅ User granted permission');
//     }
//   }
//
//   Future<String?> getDeviceToken() async {
//     String? token = await _messaging.getToken();
//     debugPrint("📱 Device Token: $token");
//     return token;
//   }
//
//   Future<void> _initLocalNotifications(BuildContext context) async {
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosInit = DarwinInitializationSettings();
//
//     const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
//
//     await _localNotifications.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (details) {
//         _handleNotificationClick(context, details.payload);
//       },
//     );
//   }
//
//   void _listenForegroundMessages(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print("📩 Message Received: ${message.notification?.title}");
//         print("📩 Message Received: ${message.notification?.body}");
//       }
//
//       if (Platform.isIOS) {
//         _messaging.setForegroundNotificationPresentationOptions(
//           alert: true, badge: true, sound: true,
//         );
//       } else {
//         showNotification(message);
//       }
//     });
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     if (notification != null && android != null) {
//       // Create a High Importance Channel for Android
//        AndroidNotificationChannel channel = AndroidNotificationChannel(
//         // 'high_importance_channel',
//         // 'High Importance Notifications',
//          android.channelId.toString(),
//          android.channelId.toString(),
//         description: 'This channel is used for important notifications.',
//         importance: Importance.max,
//         showBadge: true,
//         playSound: true,
//       );
//
//       await _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id.toString(),
//             channel.name.toString(),
//             channelDescription: channel.description,
//             importance: Importance.max,
//             priority: Priority.high,
//             visibility: NotificationVisibility.public,
//             fullScreenIntent: true,
//             timeoutAfter: 60000,
//             icon: android.smallIcon,
//             playSound:true,
//             sound: channel.sound;
//           ),
//           iOS: const DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }
//
//   void _setupInteractedMessage(BuildContext context) async {
//     // Background state click
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       _handleNotificationClick(context, message.data.toString());
//     });
//
//     // Terminated state click
//     RemoteMessage? initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       _handleNotificationClick(context, initialMessage.data.toString());
//     }
//   }
//
//   void _handleNotificationClick(BuildContext context, String? payload) {
//     if (payload != null) {
//       debugPrint("🎯 Notification Clicked with payload: $payload");
//       // Yahan navigate karein screen par
//     }
//   }
// }

import 'dart:convert';

import 'package:stream4videos/core/utils/routes/routes.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';


class NotificationService {
  NotificationService._internal();
  static final NotificationService instance =
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// 🔔 Call ONLY ONCE (App start)
  Future<void> init(BuildContext context) async {
    if (_initialized) return;
    _initialized = true;

    await _requestPermission();
    await _initLocal();
    await getDeviceToken();

    _listenForeground();
    // ignore: use_build_context_synchronously
    _listenNotificationClick(context);
  }

  /// 🔔 Permission (Android 13+ safe)
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('🔔 Permission: ${settings.authorizationStatus}');
  }

  /// 🔔 FCM Token
  Future<String?> getDeviceToken() async {
    final token = await _messaging.getToken();
    debugPrint('📱 FCM Token: $token');
    return token;
  }

  /// 🔔 Local notification init
  Future<void> _initLocal() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings =
    InitializationSettings(android: android, iOS: ios);

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _handlePayload(response.payload!);
        }
      },
    );

    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Important notifications',
        importance: Importance.high,
      );

      await _local
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  /// 🔔 Foreground messages
  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        debugPrint(
            '📩 Foreground: ${message.notification?.title}');
      }

      if (Platform.isAndroid) {
        _showLocal(message);
      }
    });
  }

  /// 🔔 Show local notification
  Future<void> _showLocal(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: jsonEncode(message.data),
    );
  }

  /// 🔔 Background + terminated click
  void _listenNotificationClick(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handlePayload(jsonEncode(message.data));
    });

    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        _handlePayload(jsonEncode(message.data));
      }
    });
  }

  void _handlePayload(String payload) {
    try {
      final data = jsonDecode(payload);
      debugPrint('🎯 Notification data: $data');

      final context = navigatorKey.currentContext;
      if (context == null) return;

      switch (data['type']) {
        case 'movie':
          context.pushReplacement(
            RoutesName.watchMovieScreen,
            extra: data['id'],
          );
          break;

        case 'search':
          context.pushReplacement(RoutesName.searchScreen);
          break;

        case 'notification':
          context.pushReplacement(RoutesName.notificationScreen);
          break;

        case 'home':
          context.pushReplacement(RoutesName.homeScreen);
          break;

        default:
          context.pushReplacement(RoutesName.homeScreen);
      }
    } catch (e) {
      debugPrint('❌ Payload error: $e');
    }
  }}
