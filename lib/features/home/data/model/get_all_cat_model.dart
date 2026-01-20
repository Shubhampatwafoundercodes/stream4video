class GetAllCategoriesModel {
  GetAllCategoriesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory GetAllCategoriesModel.fromJson(Map<String, dynamic> json){
    return GetAllCategoriesModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
    );
  }

}
