// fcm_token_provider.dart
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final fcmTokenProvider = StateNotifierProvider<FCMTokenNotifier, AsyncValue<String?>>((ref) {
  return FCMTokenNotifier();
});

class FCMTokenNotifier extends StateNotifier<AsyncValue<String?>> {
  FCMTokenNotifier() : super(const AsyncValue.data(null));

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _isInitialized = false;
  Future<String?> generateFCMToken() async {
    try {
      state = const AsyncValue.loading();

      log('🔄 Generating FCM token for login/register...');


      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      log('✅ Notification permission: ${settings.authorizationStatus}');

      final token = await _messaging.getToken();

      if (token != null) {
        log('✅ FCM Token generated: $token');

        state = AsyncValue.data(token);

        // Setup token refresh listener (only once)
        if (!_isInitialized) {
          _messaging.onTokenRefresh.listen((newToken) {
            log('🔄 FCM Token refreshed: $newToken');
            state = AsyncValue.data(newToken);
          });
          _isInitialized = true;
        }

        return token;
      } else {
        log('❌ FCM Token is null');
        state = const AsyncValue.data(null);
        return null;
      }

    } catch (e, stack) {
      log('❌ FCM Token generation error: $e');
      state = AsyncValue.error(e,stack);
      return null;
    }
  }

  // Clear token when user logs out
  void clearToken() {
    log('🧹 Clearing FCM token on logout');
    state = const AsyncValue.data(null);
  }


  String? get currentToken {
    return state.maybeWhen(
      data: (value) => value,
      orElse: () => null,
    );
  }
}