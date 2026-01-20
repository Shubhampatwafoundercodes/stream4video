class SubscriptionPlanModel {
  SubscriptionPlanModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final SubscriptionListData? data;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json){
    return SubscriptionPlanModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : SubscriptionListData.fromJson(json["data"]),
    );
  }

}

class SubscriptionListData {
  SubscriptionListData({
    required this.monthly,
    required this.quarterly,
    required this.halfYearly,
    required this.yearly,
  });

  final List<HalfYearly> monthly;
  final List<HalfYearly> quarterly;
  final List<HalfYearly> halfYearly;
  final List<HalfYearly> yearly;

  factory SubscriptionListData.fromJson(Map<String, dynamic> json){
    return SubscriptionListData(
      monthly: json["monthly"] == null ? [] : List<HalfYearly>.from(json["monthly"]!.map((x) => HalfYearly.fromJson(x))),
      quarterly: json["quarterly"] == null ? [] : List<HalfYearly>.from(json["quarterly"]!.map((x) => HalfYearly.fromJson(x))),
      halfYearly: json["half_yearly"] == null ? [] : List<HalfYearly>.from(json["half_yearly"]!.map((x) => HalfYearly.fromJson(x))),
      yearly: json["yearly"] == null ? [] : List<HalfYearly>.from(json["yearly"]!.map((x) => HalfYearly.fromJson(x))),
    );
  }

}

class HalfYearly {
  HalfYearly({
    required this.id,
    required this.name,
    required this.duration,
    required this.type,
    required this.price,
    required this.deviceLimit,
    required this.quality,
    required this.downloadsAllowed,
    required this.ads,
    required this.description,
  });

  final int? id;
  final String? name;
  final String? duration;
  final String? type;
  final dynamic price;
  final dynamic deviceLimit;
  final String? quality;
  final dynamic downloadsAllowed;
  final dynamic ads;
  final String? description;

  factory HalfYearly.fromJson(Map<String, dynamic> json){
    return HalfYearly(
      id: json["id"],
      name: json["name"],
      duration: json["duration"],
      type: json["type"],
      price: json["price"],
      deviceLimit: json["device_limit"],
      quality: json["quality"],
      downloadsAllowed: json["downloads_allowed"],
      ads: json["ads"],
      description: json["description"],
    );
  }

}
