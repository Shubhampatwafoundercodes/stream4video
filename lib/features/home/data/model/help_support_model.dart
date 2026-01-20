class HelpSupportModel {
  HelpSupportModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;

  factory HelpSupportModel.fromJson(Map<String, dynamic> json){
    return HelpSupportModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? slug;
  final String? content;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      content: json["content"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
