import 'package:stream4videos/features/auth/data/model/login_responce.dart';
import 'package:stream4videos/features/auth/data/model/onboarding_banner_model.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(dynamic data);
  Future<dynamic> sendOtp(String phone);
  Future<dynamic> verifyOtp(String phone, String otp);
  Future<dynamic> logoutActiveDevice(Map<String, dynamic> data);
  Future<OnboardingBannerModel> onboardingBannerApi();

}