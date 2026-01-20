import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/auth/data/model/login_responce.dart';
import 'package:stream4videos/features/auth/data/model/onboarding_banner_model.dart';
import 'package:stream4videos/features/auth/domain/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseApiServices api;
  AuthRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(dynamic da) async {
    final url = ApiUrls.loginUrl;
    final data = await api.getPostApiResponse(url, da);
    return LoginResponse.fromJson(data);
  }

  @override
  Future<dynamic> sendOtp(String phone) async {
    final url = ApiUrls.sendOtpUrl;
    final data = await api.getGetApiResponse(url + phone);
    return data;
  }

  @override
  Future<dynamic> verifyOtp(String phone, String otp) async {
    final url = '${ApiUrls.verifyOtpUrl}$phone&otp=$otp';
    final data = await api.getGetApiResponse(url);
    return data;
  }

  @override
  Future<dynamic> logoutActiveDevice(Map<String, dynamic> data) async {
    final res = await api.getPostApiResponse(ApiUrls.logoutActiveDeviceUrl, data);
    return res;
  }

  @override
  Future <OnboardingBannerModel> onboardingBannerApi() async{
    final res = await api.getGetApiResponse(ApiUrls.onBoardBannerUrl);
    return OnboardingBannerModel.fromJson(res);

  }
}