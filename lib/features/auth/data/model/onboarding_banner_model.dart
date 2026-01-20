class OnboardingBannerModel {
  OnboardingBannerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory OnboardingBannerModel.fromJson(Map<String, dynamic> json){
    return OnboardingBannerModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  final int? id;
  final String? image;
  final String? title;
  final String? description;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      image: json["image"],
      title: json["title"],
      description: json["description"],
    );
  }

}
