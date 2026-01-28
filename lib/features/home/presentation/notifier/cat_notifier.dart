import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/data/model/free_section_model.dart';
import 'package:stream4videos/features/home/data/model/get_all_cat_model.dart';
import 'package:stream4videos/features/home/data/model/get_home_banner_model.dart';
import 'package:stream4videos/features/home/data/model/get_sub_categories_model.dart';
import 'package:stream4videos/features/home/data/repo_impl/get_all_cat_repo_impl.dart';
import 'package:stream4videos/features/home/domain/repo/get_all_cat_repo.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';

class CategoryState {
  final bool isLoading;
  final bool isAddWatchListLoading;
  final bool isSubCatLoading;

  final bool isInWatchlist;

  final GetAllCategoriesModel? categories;
  final HomeBannerModel? homeBannerModel;
  final List<ContentPosterItemModel>? myWatchListModelData;
  final GetSubCategoriesModel? subCategories;

  final List<ContentPosterItemModel> allSearchItems;
  final List<ContentPosterItemModel>? searchedItems;

  final bool isFreeSectionLoading;
  final FreeSectionModel? freeSectionModel;

  CategoryState({
    this.isLoading = false,
    this.isSubCatLoading = false,
    this.categories,
    this.homeBannerModel,
    this.myWatchListModelData,
    this.subCategories,
    this.isAddWatchListLoading = false,
    this.isInWatchlist = false,

    this.allSearchItems = const [],

    this.isFreeSectionLoading = false,
    this.freeSectionModel,

    this.searchedItems,
  });

  CategoryState copyWith({
    bool? isLoading,
    bool? isAddWatchListLoading,
    bool? isSubCatLoading,
    bool? isInWatchlist,

    bool? isFreeSectionLoading,
    FreeSectionModel? freeSectionModel,

    GetAllCategoriesModel? categories,
    HomeBannerModel? homeBannerModel,
    GetSubCategoriesModel? subCategories,
    List<ContentPosterItemModel>? myWatchListModelData,

    List<ContentPosterItemModel>? allSearchItems,
    List<ContentPosterItemModel>? searchedItems,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      isAddWatchListLoading:
          isAddWatchListLoading ?? this.isAddWatchListLoading,
      categories: categories ?? this.categories,

      isFreeSectionLoading: isFreeSectionLoading ?? this.isFreeSectionLoading,
      freeSectionModel: freeSectionModel ?? this.freeSectionModel,

      homeBannerModel: homeBannerModel ?? this.homeBannerModel,
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
      myWatchListModelData: myWatchListModelData ?? this.myWatchListModelData,
      subCategories: subCategories ?? this.subCategories,
      isSubCatLoading: isSubCatLoading ?? this.isSubCatLoading,

      allSearchItems: allSearchItems ?? this.allSearchItems,

      searchedItems: searchedItems ?? this.searchedItems,
    );
  }
}

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
      final api = GetAllCatRepoImpl(NetworkApiServicesDio(ref));
      return CategoryNotifier(api, ref);
    });

class CategoryNotifier extends StateNotifier<CategoryState> {
  final GetAllCatRepo _repo;
  final Ref _ref;

  CategoryNotifier(this._repo, this._ref) : super(CategoryState());

  Future<void> getAllCategories() async {
    state = state.copyWith(isLoading: true);
    try {
      await homeBannerApi();
      final res = await _repo.getAllCatAPi();
      if (res.success == true) {
        await getSubCategories("1", isSearchListDataAdd: true);
        state = state.copyWith(isLoading: false, categories: res);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> getSubCategories(
    String catId, {
    bool isSearchListDataAdd = false,
  }) async
  {
    state = state.copyWith(isSubCatLoading: true);
    try {
      final res = await _repo.getSubCatAPi(catId);
      if (res.success == true) {
        if (isSearchListDataAdd == true) {
          final List<ContentPosterItemModel> tempList = [];
          // ignore: dead_code
          final sectionData = res.data;
          if (sectionData.isNotEmpty) {
            for (final section in sectionData) {
              tempList.addAll(section.items);
            }
            state = state.copyWith(
              allSearchItems: tempList,
              searchedItems: null,
            );
          }
        }

        state = state.copyWith(isSubCatLoading: false, subCategories: res);
      } else {
        state = state.copyWith(isSubCatLoading: false);
      }
      state = state.copyWith(isSubCatLoading: false);
    } catch (e) {
      state = state.copyWith(isSubCatLoading: false);
      rethrow;
    }
  }

  void searchByTitle(String query) {
    if (query.isEmpty) {
      state = state.copyWith(searchedItems: null);
      return;
    }

    final filtered = state.allSearchItems
        .where(
          (item) =>
              item.title != null &&
              item.title!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    state = state.copyWith(searchedItems: filtered);
  }

  Future<void> homeBannerApi() async {
    // state = state.copyWith(isLoading: true);
    try {
      final res = await _repo.homeBannerApi();
      if (res.success == true) {
        state = state.copyWith(
          // isLoading: false,
          homeBannerModel: res,
        );
      } else {
        // state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      // state = state.copyWith(isLoading: false);
    }
  }

  // Future<void> addWatchListApi(String movieId)async{
  //   state = state.copyWith(isAddWatchListLoading: true);
  //   final userId=_ref.read(userProvider.notifier).userId;
  //   final previousValue = state.isInWatchlist;
  //   state = state.copyWith(
  //     isAddWatchListLoading: true,
  //     isInWatchlist: !previousValue,
  //   );
  //
  //   Map data={
  //     "user_id":userId.toString(),
  //     "movie_id":movieId.toString()
  //   };
  //   try {
  //     final res = await _repo.addWatchListApi(data);
  //
  //     if (res["success"]==true) {
  //       // final String message = res["message"]?.toString() ?? "";
  //       // final bool added = message.contains("Added");
  //
  //       state = state.copyWith(
  //         isAddWatchListLoading: false,
  //         isInWatchlist: added
  //       );
  //     } else {
  //       state = state.copyWith(isAddWatchListLoading: false,);
  //     }
  //   } catch (e) {
  //     state = state.copyWith(isAddWatchListLoading: false,isInWatchlist: previousValue);
  //   }
  //
  // }
  Future<void> addWatchListApi(String movieId) async {
    if (state.isAddWatchListLoading) return;

    final userId = _ref.read(userProvider.notifier).userId;
    if (userId == null) return;

    final previousValue = state.isInWatchlist;
    state = state.copyWith(
      isAddWatchListLoading: true,
      isInWatchlist: !previousValue,
    );

    try {
      final res = await _repo.addWatchListApi({
        "user_id": userId.toString(),
        "movie_id": movieId.toString(),
      });

      if (res["success"] != true) {
        state = state.copyWith(isInWatchlist: previousValue);
      }
    } catch (e) {
      state = state.copyWith(isInWatchlist: previousValue);
      rethrow;
    } finally {
      state = state.copyWith(isAddWatchListLoading: false);
    }
  }

  void setInitialWatchlist(bool value) {
    state = state.copyWith(isInWatchlist: value);
  }

  Future<void> getMyWatchListApi() async {
    state = state.copyWith(isAddWatchListLoading: true);
    final userId = _ref.read(userProvider.notifier).userId;

    if (userId == null || userId.isEmpty) {
      state = state.copyWith(
        isAddWatchListLoading: false,
        myWatchListModelData: [],
      );
      return;
    }

    try {
      final res = await _repo.getMyWatchListApi(userId.toString());
      if (res["success"] == true) {
        final List list = res["My WatchList"] ?? [];
        final watchList = list
            .map((e) => ContentPosterItemModel.fromJson(e))
            .toList();

        state = state.copyWith(
          isAddWatchListLoading: false,
          myWatchListModelData: watchList,
        );
      } else {
        state = state.copyWith(
          isAddWatchListLoading: false,
          myWatchListModelData: [],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isAddWatchListLoading: false,
        myWatchListModelData: null,
      );
      // rethrow;
    }
  }

  Future<void> getSectionApi({required bool isPremium}) async {
    state = state.copyWith(isFreeSectionLoading: true);
    try {
      final res = await _repo.getSection(isPremium: isPremium);
      if (res.success == true) {
        state = state.copyWith(
          isFreeSectionLoading: false,
          freeSectionModel: res,
        );
      } else {
        state = state.copyWith(isFreeSectionLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isFreeSectionLoading: false);
      rethrow;
    }
  }
}
