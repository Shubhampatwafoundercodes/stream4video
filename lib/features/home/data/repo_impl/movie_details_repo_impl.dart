import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/home/data/model/movie_details_model.dart';
import 'package:stream4videos/features/home/domain/repo/movie_details_repo.dart';

class MovieDetailsRepoImpl extends MovieDetailsRepo{
  BaseApiServices api;
  MovieDetailsRepoImpl(this.api);






  @override
  Future<GetMovieDetailsModel> movieDetailsApi(String contentId,{String? userId}) async{
    final url = '${ApiUrls.movieDetailsUrl}/$contentId';

    final data = await api.getGetApiResponse(
      url,
      queryParameters: userId != null ? {'user_id': userId} : null,
    );
    return GetMovieDetailsModel.fromJson(data);
  }

}