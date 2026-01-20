import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';

class GetMovieDetailsModel {
  GetMovieDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final MovieDetailsModelData? data;

  factory GetMovieDetailsModel.fromJson(Map<String, dynamic> json){
    return GetMovieDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : MovieDetailsModelData.fromJson(json["data"]),
    );
  }

}

class MovieDetailsModelData {
  MovieDetailsModelData({
    required this.movieDetails,
    required this.people,
    required this.seasons,
    required this.moreLikeThis,
    required this.createdAt,
    required this.updatedAt,
  });

  final MovieDetails? movieDetails;
  final List<Person> people;
  final List<Season> seasons;
  final List<ContentPosterItemModel> moreLikeThis;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MovieDetailsModelData.fromJson(Map<String, dynamic> json){
    return MovieDetailsModelData(
      movieDetails: json["movie_details"] == null ? null : MovieDetails.fromJson(json["movie_details"]),
      people: json["people"] == null ? [] : List<Person>.from(json["people"]!.map((x) => Person.fromJson(x))),
      seasons: json["seasons"] == null ? [] : List<Season>.from(json["seasons"]!.map((x) => Season.fromJson(x))),
      moreLikeThis: json["more_like_this"] == null ? [] : List<ContentPosterItemModel>.from(json["more_like_this"]!.map((x) => ContentPosterItemModel.fromJson(x))),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class MovieDetails {
  MovieDetails({
    required this.type,
    required this.isMovie,
    required this.isWatchListAdd,
    required this.title,
    required this.description,
    required this.languages,
    required this.genres,
    required this.contentRating,
    required this.rating,
    required this.releaseDate,
    required this.isPremium,
    required this.banner,
    required this.videoUrl,
  });

  final String? type;
  final bool? isMovie;
  final bool? isWatchListAdd;
  final String? title;
  final String? description;
  final List<String> languages;
  final List<String> genres;
  final dynamic contentRating;
  final dynamic rating;
  final DateTime? releaseDate;
  final dynamic isPremium;
  final String? banner;
  final String? videoUrl;

  factory MovieDetails.fromJson(Map<String, dynamic> json){
    return MovieDetails(
      type: json["type"],
      title: json["title"],
      description: json["description"],
      languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
      genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
      contentRating: json["content_rating"],
      rating: json["rating"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      isPremium: json["is_premium"],
      banner: json["banner"],
      videoUrl: json["video_url"],
      isMovie: json["is_movie"],
      isWatchListAdd: json["watchlist"],
    );
  }

}

class Person {
  Person({
    required this.personId,
    required this.name,
    required this.personType,
    required this.role,
    required this.characterName,
    required this.profileImage,
    required this.order,
  });

  final int? personId;
  final String? name;
  final String? personType;
  final String? role;
  final String? characterName;
  final String? profileImage;
  final int? order;

  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
      personId: json["person_id"],
      name: json["name"],
      personType: json["person_type"],
      role: json["role"],
      characterName: json["character_name"],
      profileImage: json["profile_image"],
      order: json["order"],
    );
  }

}

class Season {
  Season({
    required this.seasonId,
    required this.seasonNumber,
    required this.title,
    required this.episodes,
  });

  final int? seasonId;
  final int? seasonNumber;
  final String? title;
  final List<Episode> episodes;

  factory Season.fromJson(Map<String, dynamic> json){
    return Season(
      seasonId: json["season_id"],
      seasonNumber: json["season_number"],
      title: json["title"],
      episodes: json["episodes"] == null
          ? []
          : List<Episode>.from(
          json["episodes"].map((x) => Episode.fromJson(x))),
    );
  }

}

class Episode {
  final int episodeId;
  final int episodeNumber;
  final String title;
  final String description;
  final int durationMinutes;
  final String thumbnail;
  final String watchUrl;
  final bool isPremium;
  final DateTime? createdAt;


  Episode({
    required this.episodeId,
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.thumbnail,
    required this.watchUrl,
    required this.isPremium,
    required this.createdAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeId: json["episode_id"],
      episodeNumber: json["episode_number"],
      title: json["title"],
      description: json["description"],
      durationMinutes: json["duration_minutes"],
      thumbnail: json["thumbnail"],
      watchUrl: json["watch_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      isPremium: json["is_premium"] == 1,
    );
  }
}

