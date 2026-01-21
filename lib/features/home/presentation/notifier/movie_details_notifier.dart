import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/home/data/model/movie_details_model.dart';
import 'package:stream4videos/features/home/data/repo_impl/movie_details_repo_impl.dart';
import 'package:stream4videos/features/home/domain/repo/movie_details_repo.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';


class MovieDetailsState {
  final bool isLoading;
  final GetMovieDetailsModel? data;
  final String? error;

  final int selectedTab;
  final int selectedSeason;
  final int currentEpisodeIndex;
  final bool isSticky; // 👈 NEW


  const MovieDetailsState({
    this.isLoading = false,
    this.data,
    this.error,

    this.selectedTab = 0,
    this.selectedSeason = 1,
    this.currentEpisodeIndex = -1,
    this.isSticky = false,

  });

  MovieDetailsState copyWith({
    bool? isLoading,
    GetMovieDetailsModel? data,
    String? error,
    int? selectedTab,
    int? selectedSeason,
    int? currentEpisodeIndex,
    bool? isSticky,

  }) {
    return MovieDetailsState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
      isSticky: isSticky ?? this.isSticky,

      selectedTab: selectedTab ?? this.selectedTab,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      currentEpisodeIndex:
      currentEpisodeIndex ?? this.currentEpisodeIndex,
    );
  }
}

final movieDetailsNotifierProvider =
StateNotifierProvider<MovieDetailsNotifier, MovieDetailsState>((ref) {
  return MovieDetailsNotifier(MovieDetailsRepoImpl(NetworkApiServicesDio(ref)),ref);
});


class MovieDetailsNotifier extends StateNotifier<MovieDetailsState> {
  final MovieDetailsRepo repo;
  final Ref ref;

  MovieDetailsNotifier(this.repo,this.ref) : super(const MovieDetailsState());

  Future<void> movieDetailsApi(String movieId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final userId=ref.read(userProvider.notifier).userId;
      final catNo= ref.read(categoryNotifierProvider.notifier);
      catNo.setInitialWatchlist(false);
      final res = await repo.movieDetailsApi(movieId,userId: userId);
      if(res.status==true){
        final isSeries = res.data?.movieDetails?.isMovie == false;
        state = state.copyWith(
          isLoading: false,
          data: res,
          selectedSeason: 1,
          currentEpisodeIndex: -1,
          selectedTab: isSeries ? 0 : 1,
        );
        catNo.setInitialWatchlist(res.data?.movieDetails?.isWatchListAdd??false);


      }else{

        state = state.copyWith(
          isLoading: false,
          data: null,
          selectedSeason: 1,
          currentEpisodeIndex: -1,
        );

      }


    } catch (e) {

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }


  void updateSticky(bool value) {
    if (state.isSticky != value) {
      state = state.copyWith(isSticky: value);
    }
  }

  MovieDetails? get movie => state.data?.data?.movieDetails;


  bool get isSeries => movie?.isMovie == false;
  bool get isWatchListAdd => movie?.isWatchListAdd == true;
  List<Season> get seasons => state.data?.data?.seasons ?? [];
  Season? get currentSeason {
    for (final s in seasons) {
      if (s.seasonNumber == state.selectedSeason) {
        return s;
      }
    }
    return seasons.isNotEmpty ? seasons.first : null;
  }
  List<Episode> get episodes =>
      currentSeason?.episodes ?? [];

  Episode? get currentEpisode {
    final index = state.currentEpisodeIndex;
    if (index < 0 || index >= episodes.length) return null;
    return episodes[index];
  }

  void changeTab(int index) {
    state = state.copyWith(selectedTab: index);
  }

  void changeSeason(int season) {
    state = state.copyWith(
      selectedSeason: season,
      currentEpisodeIndex: -1,
    );
  }

  /// EPISODE TAP
  void selectEpisode(int index) {
    state = state.copyWith(currentEpisodeIndex: index);
  }


  String? getPlayUrlOnPlayTap() {
    if (isSeries) {
      if (state.currentEpisodeIndex == -1 && episodes.isNotEmpty) {
        state = state.copyWith(currentEpisodeIndex: 0);
        return episodes[0].watchUrl;
      }

      return currentEpisode?.watchUrl;
    }
    return movie?.videoUrl;
  }


}
