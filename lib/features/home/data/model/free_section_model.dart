import 'package:stream4videos/features/home/data/model/common_model/sub_cat_data_model.dart';
import 'package:stream4videos/features/home/data/model/get_home_banner_model.dart';

class FreeSectionModel {
  FreeSectionModel({
    required this.success,
    required this.banner,
    required this.data,
  });

  final bool? success;
  final List<HomeBannerDataList> banner;
  final List<SubCatDataModel> data;

  factory FreeSectionModel.fromJson(Map<String, dynamic> json){
    return FreeSectionModel(
      success: json["success"],
      banner: json["banner"] == null ? [] : List<HomeBannerDataList>.from(json["banner"]!.map((x) => HomeBannerDataList.fromJson(x))),
      data: json["data"] == null ? [] : List<SubCatDataModel>.from(json["data"]!.map((x) => SubCatDataModel.fromJson(x))),
    );
  }

}

// class Banner {
//   Banner({
//     required this.id,
//     required this.image,
//     required this.contentUrl,
//     required this.title,
//     required this.subtitle,
//     required this.tags,
//   });
//
//   final int? id;
//   final String? image;
//   final String? contentUrl;
//   final String? title;
//   final String? subtitle;
//   final List<String> tags;
//
//   factory Banner.fromJson(Map<String, dynamic> json){
//     return Banner(
//       id: json["id"],
//       image: json["image"],
//       contentUrl: json["content_url"],
//       title: json["title"],
//       subtitle: json["subtitle"],
//       tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
//     );
//   }
//
// }
//
// class Datum {
//   Datum({
//     required this.sectionId,
//     required this.title,
//     required this.subtitle,
//     required this.sectionType,
//     required this.showSeeAll,
//     required this.items,
//   });
//
//   final String? sectionId;
//   final String? title;
//   final String? subtitle;
//   final String? sectionType;
//   final bool? showSeeAll;
//   final List<Item> items;
//
//   factory Datum.fromJson(Map<String, dynamic> json){
//     return Datum(
//       sectionId: json["section_id"],
//       title: json["title"],
//       subtitle: json["subtitle"],
//       sectionType: json["section_type"],
//       showSeeAll: json["show_see_all"],
//       items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//     );
//   }
//
// }
//
// class Item {
//   Item({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.isPremium,
//     required this.language,
//     required this.rating,
//     required this.quality,
//   });
//
//   final int? id;
//   final String? title;
//   final String? image;
//   final int? isPremium;
//   final List<String> language;
//   final String? rating;
//   final String? quality;
//
//   factory Item.fromJson(Map<String, dynamic> json){
//     return Item(
//       id: json["id"],
//       title: json["title"],
//       image: json["image"],
//       isPremium: json["is_premium"],
//       language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
//       rating: json["rating"],
//       quality: json["quality"],
//     );
//   }
//
// }
