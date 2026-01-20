

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/subscription_plan/domain/repo/create_paying_repo.dart';



class CreatePayingRepoImpl implements CreatePayingRepo{
  final BaseApiServices api;

  CreatePayingRepoImpl(this.api);


  @override
  Future <dynamic> createPayingSession(dynamic data) async{
    try {
      final res = await api.getPostApiResponse(ApiUrls.createPayingUrl,data);
      return  res;
    } catch (e) {
      throw Exception("Failed to load createPayingSession $e");
    }
  }

}


final createPayingRepoProvider = Provider<CreatePayingRepoImpl>((ref) {
  return CreatePayingRepoImpl(NetworkApiServicesDio(ref));
});