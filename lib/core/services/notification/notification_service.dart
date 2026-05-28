import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

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
