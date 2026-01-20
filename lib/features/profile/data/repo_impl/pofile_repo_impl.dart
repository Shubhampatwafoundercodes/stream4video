
import 'package:dio/dio.dart';
import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/app_form_data.dart' show AppFormData;
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/profile/data/model/profile_model.dart';
import 'package:stream4videos/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo{
  final BaseApiServices api;
  ProfileRepoImpl(this.api);

  @override
  Future<ProfileModel> getProfileApi(String userId,String deviceId) async{
    final url = "${ApiUrls.profileApiUrl+userId}&device_id=$deviceId";
    final data = await api.getGetApiResponse(url);

    return ProfileModel.fromJson(data);
  }

  @override
  Future<dynamic> editProfileApi({
    required String userId,
    String? name,
    String? email,
  }) async {



    final Map<String, dynamic> fields = {
      "id": userId,
      if (name != null && name.trim().isNotEmpty) "name": name,
      if (email != null && email.trim().isNotEmpty) "email": email,
    };

    final FormData formData = AppFormData.fromMap(fields);

    final url = ApiUrls.editProfileUrl + userId;

    final response = await api.getFormDataApiResponse(
      url,
      formData,
    );


    return response;
  }


}