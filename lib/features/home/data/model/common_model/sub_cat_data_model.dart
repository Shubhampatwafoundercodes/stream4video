import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';

class SubCatDataModel {
  SubCatDataModel({
    required this.sectionId,
    required this.title,
    required this.subtitle,
    required this.sectionType,
    required this.showSeeAll,
    required this.items,
  });

  final String? sectionId;
  final String? title;
  final String? subtitle;
  final String? sectionType;
  final bool? showSeeAll;
  final List<ContentPosterItemModel> items;

  factory SubCatDataModel.fromJson(Map<String, dynamic> json){
    return SubCatDataModel(
      sectionId: json["section_id"],
      title: json["title"],
      subtitle: json["subtitle"],
      sectionType: json["section_type"],
      showSeeAll: json["show_see_all"],
      items: json["items"] == null ? [] : List<ContentPosterItemModel>.from(json["items"]!.map((x) => ContentPosterItemModel.fromJson(x))),
    );
  }

}
