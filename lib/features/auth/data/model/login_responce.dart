class LoginResponse {
  LoginResponse({
    required this.success,
    required this.message,
    required this.userId,
    required this.userCount,
    required this.activeDevices,
    required this.token,
    required this.isBlockUser,
  });

  final bool? success;
  final bool? isBlockUser;
  final String? message;
  final int? userId;
  final int? userCount;
  final List<ActiveDevice>? activeDevices;
  final String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      success: json["success"],
      message: json["message"],
      userId: json["user_id"],
      userCount: json["user_count"],
      activeDevices: json["active_devices"] == null ? [] : List<ActiveDevice>.from(json["active_devices"]!.map((x) => ActiveDevice.fromJson(x))),
      token: json["token"],
      isBlockUser: json["block"],
    );
  }

}

class ActiveDevice {
  ActiveDevice({
    required this.deviceId,
    required this.deviceName,
  });

  final String? deviceId;
  final String? deviceName;

  factory ActiveDevice.fromJson(Map<String, dynamic> json){
    return ActiveDevice(
      deviceId: json["device_id"],
      deviceName: json["device_name"],
    );
  }

}
