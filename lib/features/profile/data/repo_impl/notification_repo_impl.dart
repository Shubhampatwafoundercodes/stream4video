

import 'package:stream4videos/core/helper/api_url/api_urls.dart';
import 'package:stream4videos/core/helper/network/base_api_service.dart';
import 'package:stream4videos/features/profile/data/model/notification_model.dart';
import 'package:stream4videos/features/profile/domain/repo/notification_repo.dart';

class NotificationImplRepo extends NotificationRepo{

  final BaseApiServices api;
  NotificationImplRepo(this.api);
  @override
  Future<NotificationModel> notificationApi(String userId,) async{
    final url = ApiUrls.notificationUrl+userId;
    final data = await api.getGetApiResponse(url);
    return NotificationModel.fromJson(data);


  }



}