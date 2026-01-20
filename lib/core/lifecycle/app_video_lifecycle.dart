import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final Ref ref;

  AppLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final notifier = ref.read(videoManagerProvider.notifier);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      notifier.pause();
    } else if (state == AppLifecycleState.resumed) {
      notifier.resume();
    }
  }
}