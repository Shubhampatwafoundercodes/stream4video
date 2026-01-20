
import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/home/data/model/help_support_model.dart';
import 'package:stream4videos/features/home/domain/repo/help_support_repo.dart';

class HelpSupportRepoImpl extends HelpSupportRepo{
  final BaseApiServices api;
  HelpSupportRepoImpl(this.api);



  @override
  Future <HelpSupportModel>helpSupportApi() async{
    final url = ApiUrls.helpSupportUrl;
    final data = await api.getGetApiResponse(url);
    return HelpSupportModel.fromJson(data);
  }


}