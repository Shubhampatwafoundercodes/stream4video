import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';

enum InternetStatus {
  connected,
  disconnected,
}

class InternetService {
  final _controller = StreamController<InternetStatus>.broadcast();
  final Connectivity _connectivity = Connectivity();

  InternetService() {
    _init();
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((results) {
      _emit(results);
    });
  }

  Future<void> retryCheck() async {
    final results = await _connectivity.checkConnectivity();
    _emit(results);
  }

  void _emit(List<ConnectivityResult> results) {
    final isDisconnected =
        results.isEmpty || results.contains(ConnectivityResult.none);

    if (isDisconnected) {
      _controller.add(InternetStatus.disconnected);
    } else {
      _controller.add(InternetStatus.connected);
    }
  }

  Stream<InternetStatus> get status => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
