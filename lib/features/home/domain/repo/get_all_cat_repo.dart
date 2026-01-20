
import 'package:stream4videos/features/home/data/model/free_section_model.dart';
import 'package:stream4videos/features/home/data/model/get_all_cat_model.dart';
import 'package:stream4videos/features/home/data/model/get_home_banner_model.dart';
import 'package:stream4videos/features/home/data/model/get_sub_categories_model.dart';

abstract class GetAllCatRepo {
  Future<GetAllCategoriesModel> getAllCatAPi();
  Future<GetSubCategoriesModel> getSubCatAPi(String? catId);
  Future<HomeBannerModel> homeBannerApi();
  Future<dynamic> addWatchListApi(dynamic data);
  Future<dynamic> getMyWatchListApi(String userId);

  Future<FreeSectionModel> getSection({required bool isPremium});



}