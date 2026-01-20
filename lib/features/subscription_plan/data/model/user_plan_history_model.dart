class UserPlanHistoryModel {
  UserPlanHistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<UserPlanHistoryItemModel> data;

  factory UserPlanHistoryModel.fromJson(Map<String, dynamic> json){
    return UserPlanHistoryModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<UserPlanHistoryItemModel>.from(json["data"]!.map((x) => UserPlanHistoryItemModel.fromJson(x))),
    );
  }

}

class UserPlanHistoryItemModel {
  UserPlanHistoryItemModel({
    required this.id,
    required this.userId,
    required this.planId,
    required this.paymentId,
    required this.startAt,
    required this.expiresAt,
    required this.status,
    required this.createdAt,
    required this.name,
    required this.duration,
    required this.type,
    required this.price,
    required this.deviceLimit,
    required this.quality,
    required this.downloadsAllowed,
    required this.ads,
    required this.description,
    required this.addons,
    required this.finalDeviceLimit,
    required this.isActive,
  });

  final int? id;
  final int? userId;
  final int? planId;
  final int? paymentId;
  final DateTime? startAt;
  final DateTime? expiresAt;
  final String? status;
  final DateTime? createdAt;
  final String? name;
  final String? duration;
  final String? type;
  final String? price;
  final int? deviceLimit;
  final String? quality;
  final int? downloadsAllowed;
  final int? ads;
  final String? description;
  final List<UserPlanItemAddonModel> addons;
  final int? finalDeviceLimit;
  final bool? isActive;

  factory UserPlanHistoryItemModel.fromJson(Map<String, dynamic> json){
    return UserPlanHistoryItemModel(
      id: json["id"],
      userId: json["user_id"],
      planId: json["plan_id"],
      paymentId: json["payment_id"],
      startAt: DateTime.tryParse(json["start_at"] ?? ""),
      expiresAt: DateTime.tryParse(json["expires_at"] ?? ""),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      name: json["name"],
      duration: json["duration"],
      type: json["type"],
      price: json["price"],
      deviceLimit: json["device_limit"],
      quality: json["quality"],
      downloadsAllowed: json["downloads_allowed"],
      ads: json["ads"],
      description: json["description"],
      addons: json["addons"] == null ? [] : List<UserPlanItemAddonModel>.from(json["addons"]!.map((x) => UserPlanItemAddonModel.fromJson(x))),
      finalDeviceLimit: json["final_device_limit"],
      isActive: json["is_active"],
    );
  }

}

class UserPlanItemAddonModel {
  UserPlanItemAddonModel({
    required this.addonId,
    required this.name,
    required this.addonKey,
    required this.addonValue,
    required this.addonPrice,
    required this.userPaidPrice,
    required this.createdAt,
  });

  final int? addonId;
  final String? name;
  final String? addonKey;
  final String? addonValue;
  final String? addonPrice;
  final String? userPaidPrice;
  final DateTime? createdAt;

  factory UserPlanItemAddonModel.fromJson(Map<String, dynamic> json){
    return UserPlanItemAddonModel(
      addonId: json["addon_id"],
      name: json["name"],
      addonKey: json["addon_key"],
      addonValue: json["addon_value"],
      addonPrice: json["addon_price"],
      userPaidPrice: json["user_paid_price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
