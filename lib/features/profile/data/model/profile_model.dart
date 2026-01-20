import 'package:stream4videos/features/subscription_plan/data/model/user_plan_history_model.dart';

class ProfileModel {
  ProfileModel({
    required this.success,
    required this.profile,
  });

  final bool? success;
  final Profile? profile;

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );
  }

}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.dob,
    required this.gender,
    required this.image,
    required this.fcmToken,
    required this.subscription,
    required this.deviceId,
    required this.subscriptionData,

  });

  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? dob;
  final String? gender;
  final String? image;
  final String? fcmToken;
  final String? subscription;
  final String? deviceId;
  final UserPlanHistoryItemModel? subscriptionData;


  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
      dob: json["dob"],
      gender: json["gender"],
      image: json["image"],
      fcmToken: json["fcm_token"],
      subscription: json["subscription"],
      deviceId: json["device_id"],
      subscriptionData: json["subscriptiondata"] == null ? null : UserPlanHistoryItemModel.fromJson(json["subscriptiondata"]),


    );
  }

}
