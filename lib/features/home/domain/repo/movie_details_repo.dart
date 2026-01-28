

import 'package:stream4videos/features/home/data/model/movie_details_model.dart';

abstract class MovieDetailsRepo{

  Future<GetMovieDetailsModel> movieDetailsApi(String contentId, {String? userId,    String? token} );


}