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
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      ref.read(userProvider.notifier).clearUser();
    }
    super.onError(err, handler);
  }
}
