class MyWatchListModel {
  MyWatchListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory MyWatchListModel.fromJson(Map<String, dynamic> json){
    return MyWatchListModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.seasonsId,
    required this.title,
    required this.description,
    required this.banner,
    required this.videoUrl,
    required this.releaseDate,
    required this.duration,
    required this.type,
    required this.rating,
    required this.itsPremium,
    required this.language,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? categoryId;
  final dynamic subCategoryId;
  final int? seasonsId;
  final String? title;
  final String? description;
  final String? banner;
  final String? videoUrl;
  final DateTime? releaseDate;
  final int? duration;
  final String? type;
  final String? rating;
  final String? itsPremium;
  final String? language;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      seasonsId: json["seasons_id"],
      title: json["title"],
      description: json["description"],
      banner: json["banner"],
      videoUrl: json["video_url"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      duration: json["duration"],
      type: json["type"],
      rating: json["rating"],
      itsPremium: json["its_premium"],
      language: json["language"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
