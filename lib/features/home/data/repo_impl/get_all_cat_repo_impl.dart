import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/home/data/model/free_section_model.dart';
import 'package:stream4videos/features/home/data/model/get_all_cat_model.dart';
import 'package:stream4videos/features/home/data/model/get_home_banner_model.dart';
import 'package:stream4videos/features/home/data/model/get_sub_categories_model.dart';
import 'package:stream4videos/features/home/domain/repo/get_all_cat_repo.dart';

 class GetAllCatRepoImpl implements GetAllCatRepo {
  final BaseApiServices api;
  GetAllCatRepoImpl(this.api);



  @override
  Future<GetAllCategoriesModel> getAllCatAPi() async{
    final url = ApiUrls.getAllCatUrl;
    final data = await api.getGetApiResponse(url);
    return GetAllCategoriesModel.fromJson(data);
  }



  @override
  Future<GetSubCategoriesModel> getSubCatAPi(String? catId) async{
    Map data={
      "category_id": catId
    };
    final url = ApiUrls.getSubCatUrl;
    final res = await api.getPostApiResponse(url,data);

    return GetSubCategoriesModel.fromJson(res);
  }

  @override
  Future<HomeBannerModel> homeBannerApi() async{
    final url = ApiUrls.homeBannerUrl;
    final data = await api.getGetApiResponse(url);
    return HomeBannerModel.fromJson(data);
  }

  @override
  Future <dynamic> addWatchListApi(dynamic data1) async{
    final url = ApiUrls.addWatchListUrl;
    final data = await api.getPostApiResponse(url,data1);
    return data;

  }

  @override
  Future<dynamic> getMyWatchListApi(String userId) async{
    final url = ApiUrls.viewWatchListUrl;
    final data = await api.getGetApiResponse(url+userId);
    return data;
  }

  @override
  Future<FreeSectionModel> getSection({required bool isPremium}) async {
    final url = isPremium
        ? ApiUrls.premiumSectionUrl
        : ApiUrls.freeSectionUrl;

    final data = await api.getPostApiResponse(url, {});
    return FreeSectionModel.fromJson(data);
  }
}