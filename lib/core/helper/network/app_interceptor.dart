import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';

class AppInterceptor extends Interceptor {
  final Ref ref;

  AppInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final user = ref.read(userProvider);
    if (user?.token != null && user!.token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${user.token}';
    }

    options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {

    final statusCode = err.response?.statusCode;


    if (statusCode == 401 ) {
      final userN = ref.read(userProvider.notifier);
      final user = ref.read(userProvider);
      if (user != null && user.isGuest == false) {
        await userN.clearAll();
        ref.invalidate(userProvider);
      }
    }
    super.onError(err, handler);
  }
}
