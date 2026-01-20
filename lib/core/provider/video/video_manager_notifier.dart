import 'dart:typed_data';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide Uint8List;
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream4videos/core/provider/video/full_screen_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoManagerState {

  final BetterPlayerController? controller;
  final String? source;
  final bool isPlaying;
  final bool isMuted;
  final bool isDragging;
  final bool isRotationLocked;



  final bool isMiniPlayer;
  final Offset miniOffset;

  const VideoManagerState({
    this.controller,
    this.source,
    this.isPlaying = false,
    this.isMuted = false,

    this.isMiniPlayer = false,
    this.miniOffset = const Offset(20, 500),
    this.isDragging = false,
    this.isRotationLocked = false,


  });

  VideoManagerState copyWith({
    BetterPlayerController? controller,
    String? source,
    bool? isPlaying,
    bool? isMuted,
    bool? isDragging,
    bool? isRotationLocked,



    bool? isMiniPlayer,
    Offset? miniOffset,
  }) {
    return VideoManagerState(
      controller: controller ?? this.controller,
      source: source ?? this.source,
      isPlaying: isPlaying ?? this.isPlaying,
      isMuted: isMuted ?? this.isMuted,

      isMiniPlayer: isMiniPlayer ?? this.isMiniPlayer,
      miniOffset: miniOffset ?? this.miniOffset,
      isDragging: isDragging ?? this.isDragging,
      isRotationLocked: isRotationLocked ?? this.isRotationLocked,


    );
  }
}

final videoManagerProvider = StateNotifierProvider.autoDispose<VideoManagerNotifier, VideoManagerState>(
      (ref) => VideoManagerNotifier(),
);

class VideoManagerNotifier extends StateNotifier<VideoManagerState> {
  VideoManagerNotifier() : super(const VideoManagerState());



  Future<void> playFromUrl(String url) async {
    await _playInternal(url, isAsset: false);
    _enterFullscreenAndPlay();
  }





  Future<void> playAssetIfNeeded(String assetPath) async {
    await _playInternal(assetPath, isAsset: true, minimalUI: true);
  }

  Future<void> playByIndex({
    required List<String> playlist,
    required int index,
  }) async {
    await _playInternal(playlist[index], isAsset: false);
  }



  Future<void> _playInternal(
      String source, {
        required bool isAsset,
        bool minimalUI = false,
      }) async
  {
    if (state.source == source && state.controller != null) return;

    await disposePlayer();

    final prefs = await SharedPreferences.getInstance();
    final lastPos = prefs.getInt(source) ?? 0;


    late BetterPlayerDataSource dataSource;

    if (isAsset) {
      final bytes = await loadAssetToMemory(source);

      dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.memory,
        "",
        bytes: bytes,
      );
    } else {
      dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        source,
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: 15000,
          maxBufferMs: 50000,
          bufferForPlaybackMs: 2500,
          bufferForPlaybackAfterRebufferMs: 5000,
        )
      );
    }

    final controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: false,
        startAt: Duration(milliseconds: lastPos),
        allowedScreenSleep: false,
        autoDispose: false,
        fit: BoxFit.cover,
        handleLifecycle: false,

        controlsConfiguration: minimalUI
            ? const BetterPlayerControlsConfiguration(
          showControls: false,
        )
            : const BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enablePlaybackSpeed: true,
          enableAudioTracks: true,
          enableMute: true,
          enableSubtitles: true,
          enableQualities: true,
          enablePip: true,
          enableFullscreen: true,
          enableProgressText: true,
          enableProgressBar: true,
          showControlsOnInitialize: true,
          skipForwardIcon: Icons.forward_10,

          controlBarColor: Color(0xCC000000),
          progressBarPlayedColor: Color(0xFFE50914),
          progressBarHandleColor: Color(0xFFE50914),
          progressBarBufferedColor: Color(0x66FFFFFF),
          progressBarBackgroundColor: Color(0x33FFFFFF),
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    controller.addEventsListener((event) {
      if (event.betterPlayerEventType ==
          BetterPlayerEventType.progress) {
        prefs.setInt(
          source,
          event.parameters!['progress'].inMilliseconds,
        );
      }
    });

    WakelockPlus.enable();

    state = state.copyWith(
      controller: controller,
      source: source,
      isPlaying: true,
      isMuted: false,
    );
  }


  void _enterFullscreenAndPlay() {
    final c = state.controller;
    if (c == null) return;

    WakelockPlus.enable();

    c.play();
    c.enterFullScreen();
    // FullScreenHelper.enter();


    state = state.copyWith(isPlaying: true);
  }

  /// 🔊 SAME API AS OLD CODE
  void toggleMute() {
    final c = state.controller;
    if (c == null) return;

    final newMute = !state.isMuted;
    c.setVolume(newMute ? 0 : 1);

    state = state.copyWith(isMuted: newMute);
  }


  void togglePlay() {
    final c = state.controller;
    if (c == null) return;

    if (c.isPlaying() == true) {
      c.pause();
    } else {
      WakelockPlus.enable();

      c.play();
    }
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void pause() {
    state.controller?.pause();
    state = state.copyWith(isPlaying: false);
  }

  void resume() {
    state.controller?.play();
    state = state.copyWith(isPlaying: true);
  }
  Future<void> disposePlayer() async {
    final c = state.controller;
    if (c == null) return;

    try {
      await c.pause();

      try {
        c.exitFullScreen();
      } catch (_) {}

      c.dispose();
      await WakelockPlus.disable();
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   FullScreenHelper.exit();
      // });
    } catch (e) {
      debugPrint("disposePlayer error: $e");
    }
  }

  // Future<void> disposePlayer() async {
  //    state.controller?.dispose();
  //    state.controller?.pause();
  //    WakelockPlus.disable();
  //    FullScreenHelper.exit();
  // }
  void resetPlayerState() {
    state = const VideoManagerState();
  }

  void toggleRotationLock() {
    if (state.isRotationLocked) {
      FullScreenHelper.unlockRotation();
      state = state.copyWith(isRotationLocked: false);
    } else {
      FullScreenHelper.lockRotation();
      state = state.copyWith(isRotationLocked: true);
    }
  }




  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }
}


Future<Uint8List?> loadAssetToMemory(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}
