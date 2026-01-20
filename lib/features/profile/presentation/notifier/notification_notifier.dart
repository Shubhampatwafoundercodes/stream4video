import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/profile/data/repo_impl/notification_repo_impl.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import '../../domain/repo/notification_repo.dart';
import '../../data/model/notification_model.dart';



final notificationProvider =
StateNotifierProvider<NotificationNotifier,
    AsyncValue<List<NotificationItem>>>(
      (ref) {
    return NotificationNotifier(NotificationImplRepo(NetworkApiServicesDio(ref)),ref);
  },
);



class NotificationNotifier
    extends StateNotifier<AsyncValue<List<NotificationItem>>> {

  final NotificationRepo repo;
  final Ref ref;

  NotificationNotifier(this.repo,this.ref)
      : super(const AsyncValue.loading());

  Future<void> fetchNotifications() async {
    try {
      state = const AsyncValue.loading();
      final userId= ref.read(userProvider.notifier).userId;
      final res = await repo.notificationApi(userId.toString());
      if(res.success==true){


        state = AsyncValue.data(res.data);

      }else{


        state = const AsyncValue.data([]);


      }



    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
