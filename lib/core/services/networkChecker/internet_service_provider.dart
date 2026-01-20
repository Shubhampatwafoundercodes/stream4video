import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/core/services/networkChecker/network_check.dart';


final internetServiceProvider = Provider<InternetService>((ref) {
  final service = InternetService();
  ref.onDispose(service.dispose);
  return service;
});

final internetStatusProvider =
StreamProvider<InternetStatus>((ref) {
  return ref.watch(internetServiceProvider).status;
});



