import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/home/data/model/movie_details_model.dart';
import 'package:stream4videos/features/home/domain/repo/movie_details_repo.dart';

class MovieDetailsRepoImpl extends MovieDetailsRepo{
  BaseApiServices api;
  MovieDetailsRepoImpl(this.api);






  @override
  Future<GetMovieDetailsModel> movieDetailsApi(String contentId,{String? userId,    String? token,}) async{
    final url = '${ApiUrls.movieDetailsUrl}$contentId';
    final Map<String, dynamic> query = {};
    if (userId != null && userId.isNotEmpty) {
      query['user_id'] = userId;
    }

    if (token != null && token.isNotEmpty) {
      query['token'] = token;
    }
    final data = await api.getGetApiResponse(
      url,
      queryParameters: query.isEmpty ? null : query,
    );
    return GetMovieDetailsModel.fromJson(data);
  }

}