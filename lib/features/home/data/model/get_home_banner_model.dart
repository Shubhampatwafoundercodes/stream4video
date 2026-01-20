class HomeBannerModel {
  HomeBannerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<HomeBannerDataList> data;

  factory HomeBannerModel.fromJson(Map<String, dynamic> json){
    return HomeBannerModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<HomeBannerDataList>.from(json["data"]!.map((x) => HomeBannerDataList.fromJson(x))),
    );
  }

}

class HomeBannerDataList {
  HomeBannerDataList({
    required this.id,
    required this.image,
    required this.contentUrl,
    required this.title,
    required this.subtitle,
    required this.tags,
  });

  final int? id;
  final String? image;
  final String? contentUrl;
  final String? title;
  final String? subtitle;
  final List<String> tags;

  factory HomeBannerDataList.fromJson(Map<String, dynamic> json){
    return HomeBannerDataList(
      id: json["id"],
      image: json["image"],
      contentUrl: json["content_url"],
      title: json["title"],
      subtitle: json["subtitle"],
      tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    );
  }

}
