class NotificationModel {
  NotificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<NotificationItem > data;

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<NotificationItem >.from(json["data"]!.map((x) => NotificationItem .fromJson(x))),
    );
  }

}

class NotificationItem  {
  NotificationItem ({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  final int? id;
  final int? userId;
  final String? title;
  final String? description;
  final int? status;
  final DateTime? createdAt;

  factory NotificationItem.fromJson(Map<String, dynamic> json){
    return NotificationItem(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],
      description: json["description"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
