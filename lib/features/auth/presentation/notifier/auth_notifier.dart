import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/core/provider/fcm_token/fcm_token_provider.dart';
import 'package:stream4videos/core/services/device_information/device_info_service.dart';
import 'package:stream4videos/features/auth/data/model/login_responce.dart';
import 'package:stream4videos/features/auth/data/model/onboarding_banner_model.dart';
import 'package:stream4videos/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:stream4videos/features/auth/domain/repo/auth_repo.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/features/subscription_plan/presentation/active_device_screen.dart';


class AuthState {
  final bool isLoading;
  final LoginResponse? response;
  final String? mobileNumber;
  final OnboardingBannerModel? bannerModel;

  AuthState({
    required this.isLoading,
    this.response,
    this.mobileNumber,
    this.bannerModel
  });

  factory AuthState.initial() => AuthState(isLoading: false);

  AuthState copyWith({
    bool? isLoading,
   LoginResponse? response,
   String? mobileNumber,
    OnboardingBannerModel? bannerModel,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bannerModel: bannerModel ?? this.bannerModel,
    );
  }
}



final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final api = AuthRepositoryImpl(NetworkApiServicesDio(ref));
  return AuthNotifier(api, ref);
});


class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  final Ref ref;

  AuthNotifier(this._repo, this.ref) : super(AuthState.initial());



  Future<bool> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true,);
    try {
      final res = await _repo.sendOtp(phone);
      if(res["error"]=="200"){
        state = state.copyWith(isLoading: false,);
        return true;
      }else{
        state = state.copyWith(isLoading: false,);
        return false;

      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint(e.toString());
      return false;
    }
  }



  Future<int> login(String phone) async {
    state = state.copyWith(isLoading: true,  response: null);
    final fcmToken = await ref.read(fcmTokenProvider.notifier).generateFCMToken();
    final userN =  ref.read(userProvider.notifier);

    final deviceInfo = await DeviceInfoService().getDeviceInfo();
    final data = {
      "mobile": phone,
      "device_id": deviceInfo["device_id"] ?? "unknown_device",
      "device_name": deviceInfo["device_name"] ?? "unknown_device",
      "fcm_token": fcmToken,
    };
    try {
      final res = await _repo.login(data);

      if (res.isBlockUser == true) {
        state = state.copyWith(
          isLoading: false,
          response: res,
          mobileNumber: null,
        );
        return 4;
      }



      if (res.success == true   && res.token != null  && res.userId !=null) {
        state = state.copyWith(isLoading: false, response: res,mobileNumber: null);
         await userN.saveUser(id: res.userId.toString(), token: res.token.toString(),deviceId: deviceInfo["device_id"].toString());
         return 1;
      }

      if(res.activeDevices !=null  && res.activeDevices!.isNotEmpty)
        {
          state = state.copyWith(isLoading: false, response: res,mobileNumber: phone);
          return 2;

        }
      state = state.copyWith(isLoading: false, response: null,mobileNumber: null);

      return 3;
    } catch (e) {
      state = state.copyWith(isLoading: false,response: null,mobileNumber: null);
      return 3;
    }
  }



  Future<bool> verifyOtp(String phone, String otp) async {
    state = state.copyWith(isLoading: true,);
    try {
      final res = await _repo.verifyOtp(phone, otp);
      state = state.copyWith(isLoading: false);

      final errorCode = res['error'].toString();
      if (errorCode == "200") {
        state = state.copyWith(isLoading: false);

        return true;
      } else {
        // toastMsg(res["msg"] ?? "OTP Verification Failed");
        state = state.copyWith(isLoading: false);
        return false;
      }

    } catch (e) {
      state = state.copyWith(isLoading: false,);
      rethrow;

      // toastMsg("OTP Verification Error: $e");
      return false;
    }
  }


  Future<int> logoutActiveDevice(String deviceId ,{bool isLoginScreen=true}) async {
    state = state.copyWith(isLoading: true);


    try {

      debugPrint("🔴 logoutActiveDevice called");
      debugPrint("🔴 isLoginScreen = $isLoginScreen");
      await DeviceInfoService().getDeviceInfo();
      final userNotifier = ref.read(userProvider.notifier);


      String userId="";
      String device="";
     if(isLoginScreen){
       userId = state.response?.userId?.toString() ?? "";
       device=deviceId;
       debugPrint("🟢 LOGIN SCREEN");
       debugPrint("userId(from response): $userId");
       debugPrint("deviceId(param): $device");
     }else{
       userId = userNotifier.userId ?? "";
       device = userNotifier.deviceId??"";

       debugPrint("🟢 APP SIDE LOGOUT");
       debugPrint("userId(from prefs): $userId");
       debugPrint("deviceId(from device info): $device");
     }
      if (userId.isEmpty || device.isEmpty) {
        debugPrint("❌ userId or deviceId empty");

        state = state.copyWith(isLoading: false);
        return 3;
      }

      final data = {
        "user_id": userId,
        "device_id": device,
      };
      debugPrint("📤 LOGOUT API DATA: $data");

      final res = await _repo.logoutActiveDevice(data);
      if (res != null && res["success"] == true ) {
        state = state.copyWith(isLoading: false);

        if (isLoginScreen == true) {
          final loginResult = await login(state.mobileNumber.toString());
          return loginResult;
        }

        /// 🔥 CASE 2: Not login screen → just success
        return 2;
      }
      state = state.copyWith(isLoading: false);

      return 3;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("logoutActiveDevice error: $e");
      return 3;
    }
  }




  Future<List<DeviceViewData>> buildDeviceList() async {
    final response = state.response;
    if (response == null) return [];

    final deviceInfo = await DeviceInfoService().getDeviceInfo();
    final currentDeviceId = deviceInfo["device_id"] ?? "";
    final currentDeviceName = deviceInfo["device_name"] ?? "This device";

    final List<DeviceViewData> devices = [];
    devices.add(
      DeviceViewData(
        deviceId: currentDeviceId,
        deviceName: currentDeviceName,
        subtitle: "Currently active on this device",
        isCurrent: true,
      ),
    );

    final apiDevices = response.activeDevices ?? [];

    for (final d in apiDevices) {


      // if (d.deviceId == currentDeviceId) continue;

      devices.add(
        DeviceViewData(
          deviceId: d.deviceId ?? "",
          deviceName: d.deviceName ?? "Unknown device",
          subtitle: "Logged in on another device",
          isCurrent: false,
        ),
      );
    }

    return devices;
  }


  Future<void> allBannerApi() async {
    try {
      final res = await _repo.onboardingBannerApi();
      if (res.success==true) {
        state = state.copyWith(bannerModel: res);

      }
      state = state.copyWith(isLoading: false);

    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("allBannerApi error: $e");
      rethrow;
    }
  }










}
