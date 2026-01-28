import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';
import 'package:stream4videos/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/features/share_pref/language/language_notifier.dart';
import 'package:stream4videos/features/subscription_plan/data/repo_impl/create_paying_repo_impl.dart';
import 'package:stream4videos/features/subscription_plan/presentation/notifier/cashfree/create_paying_notifier.dart';

class User {
  final String? id;
  final String? token;
  final bool isGuest;
  final String? deviceId;
  final bool hasActivePlan;


  User({
    required this.id,
    required this.token,
    this.isGuest = false,
    this.hasActivePlan = false,

    this.deviceId,
  });
  User copyWith({
    String? id,
    String? token,
    bool? isGuest,
    bool? hasActivePlan,
    String? deviceId,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      isGuest: isGuest ?? this.isGuest,
      hasActivePlan: hasActivePlan ?? this.hasActivePlan,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}


class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<void> loadUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString('userID');
    final token = sharedPreferences.getString('token');
    final deviceId = sharedPreferences.getString('device_id');
    final hasPlan = sharedPreferences.getBool('has_active_plan') ?? false;

    if (id != null && token != null) {
      state = User(id: id, token: token,deviceId: deviceId,hasActivePlan: hasPlan,isGuest: false);
    } else {
      state=User(id: null, token: null,hasActivePlan: false,deviceId: null);
    }
  }

  void continueAsGuest() {
    state = User(id: null, token: null, isGuest: true,deviceId: null,hasActivePlan: false);
  }

  // Save user when OTP is verified


  Future<void> saveUser({required String id, required String token,  required String deviceId,}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userID', id);
    sharedPreferences.setString('token', token);
     sharedPreferences.setString('device_id', deviceId);

    state = User(id: id, token: token, isGuest: false,deviceId: deviceId);
  }

  Future<void> clearUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userID');
    sharedPreferences.remove('token');
    await sharedPreferences.remove('has_active_plan');

    state = null;
  }

  Future<void> updatePlanStatus(bool value) async {
    if (state == null || state!.isGuest) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_active_plan', value);

    state = state!.copyWith(hasActivePlan: value);
  }


   Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


  void invalidateAllProviders(WidgetRef ref) {
    // 🔹 User related
    ref.invalidate(authNotifierProvider);

    ref.invalidate(profileNotifierProvider);
    ref.invalidate(languageProvider);
    ref.invalidate(paymentProvider);
    ref.invalidate(createPayingRepoProvider);
    ref.invalidate(videoManagerProvider);

    // 🔹 Any other providers
    // ref.invalidate(notificationProvider);

    debugPrint("✅ All related providers invalidated");
  }




  String? get token => state?.token;
  String? get userId => state?.id;
  String? get deviceId => state?.deviceId;
  bool get hasActivePlan => state?.hasActivePlan ??false;
  bool get isGuest => state?.isGuest ??false;


  bool get isLoggedIn =>
      state != null &&
          state!.isGuest == false &&
          state!.token != null &&
          state!.token!.isNotEmpty;
}

// Provider
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

extension UserLoginCheck on User? {

  bool isLoginOrNot() {
    if (this == null) return false;
    if (this!.isGuest) return false;
    if ( this!.token !=null  && this!.token!.isEmpty) return false;
    return true;
  }

}
