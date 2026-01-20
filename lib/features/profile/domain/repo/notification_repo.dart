import 'package:stream4videos/features/profile/data/model/notification_model.dart';

abstract class NotificationRepo{

  Future<NotificationModel> notificationApi(String userId,);

}