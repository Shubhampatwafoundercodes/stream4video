class ContentPosterItemModel {
  ContentPosterItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.itsPremium,
    required this.languages,
    required this.rating,
    required this.quality,
    required this.moreLikeThisVideoUrl,
  });

  final int? id;
  final String? title;
  final String? image;
  final dynamic itsPremium;    //0 is not premium 1 mis its pre
  final List<String> languages;
  final String? rating;
  final String? quality;
  final dynamic moreLikeThisVideoUrl;


  factory ContentPosterItemModel.fromJson(Map<String, dynamic> json) {
    return ContentPosterItemModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      itsPremium: json["is_premium"],
      languages: json["language"] == null
          ? []
          : List<String>.from(json["language"].map((x) => x.toString())),
      rating: json["rating"]?.toString(),
      quality: json["quality"]?.toString(),
      moreLikeThisVideoUrl: json["watch_url"]?.toString(),
    );
  }
}
