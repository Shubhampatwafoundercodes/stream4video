import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';

class VideoPlayerSurface extends HookConsumerWidget {
  final List<String> playlist;
  final int currentIndex;
  final ValueChanged<int> onIndexChange;

  const VideoPlayerSurface({
    super.key,
    required this.playlist,
    required this.currentIndex,
    required this.onIndexChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoManagerProvider);
    if (state.controller == null) {
      return const SizedBox();
    }

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     notifier.playByIndex(
    //       playlist: playlist,
    //       index: currentIndex,
    //     );
    //   });
    //   return null;
    // }, [currentIndex]);
    //
    // if (state.controller == null) {
    //   return const AspectRatio(
    //     aspectRatio: 16 / 9,
    //     child: Center(child: CircularProgressIndicator()),
    //   );
    // }

    return SafeArea(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [

            BetterPlayer(
              controller: state.controller!,
            ),

            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () async{
                  WidgetsBinding.instance.addPostFrameCallback((_) async{
                    // await notifier.closePlayer();

                  });
                  context.pop();

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
