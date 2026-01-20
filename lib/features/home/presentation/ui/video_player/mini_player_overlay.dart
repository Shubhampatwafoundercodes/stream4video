// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';
// import 'package:stream4videos/core/utils/routes/routes.dart';
// import 'package:stream4videos/core/utils/routes/routes_name.dart';
// import 'package:stream4videos/features/home/presentation/ui/watch_movie_screen.dart';
//
// class MiniPlayerOverlay extends ConsumerStatefulWidget {
//   const MiniPlayerOverlay({super.key});
//
//   @override
//   ConsumerState<MiniPlayerOverlay> createState() =>
//       _MiniPlayerOverlayState();
// }
//
// class _MiniPlayerOverlayState
//     extends ConsumerState<MiniPlayerOverlay> {
//   // late Offset position;
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   position = const Offset(20, 500);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(videoManagerProvider);
//     final notifier = ref.read(videoManagerProvider.notifier);
//
//     if (!state.isMiniPlayer || state.controller == null) {
//       return const SizedBox.shrink();
//     }
//
//     final screen = MediaQuery.of(context).size;
//     final miniSize = const Size(160, 90);
//     final position = state.miniOffset;
//
//     return state.isDragging
//         ? Positioned(
//       left: position.dx,
//       top: position.dy,
//       child: _miniGesture(context, ref),
//     )
//         : AnimatedPositioned(
//       duration: const Duration(milliseconds: 250),
//       curve: Curves.easeOut,
//       left: position.dx,
//       top: position.dy,
//       child: _miniGesture(context, ref),
//     );
//   }
//
//   Widget _miniGesture(BuildContext context, WidgetRef ref) {
//     final state = ref.read(videoManagerProvider);
//     final notifier = ref.read(videoManagerProvider.notifier);
//
//     final screen = MediaQuery.of(context).size;
//     const miniSize = Size(210, 120);
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//
//       onTap: () {
//         // notifier.exitMiniPlayer();
//         navigatorKey.currentState?.push(
//           MaterialPageRoute(
//             builder: (_) => const WatchMovieScreen(),
//           ),
//         );
//       },
//
//       onPanStart: (_) {
//         // notifier.setDragging(true);
//       },
//
//       onPanUpdate: (details) {
//         final next = _clampOffset(
//           offset: state.miniOffset + (details.delta * 1.25),
//           screen: screen,
//           miniSize: miniSize,
//         );
//
//         // notifier.updateMiniOffset(next);
//       },
//
//       onPanEnd: (details) {
//         notifier.setDragging(false);
//
//         final velocity = details.velocity.pixelsPerSecond;
//
//         if (velocity.dy > 1200) {
//           notifier.closeMiniPlayer();
//           return;
//         }
//
//         Offset projected = state.miniOffset + Offset(
//           velocity.dx * 0.15,
//           velocity.dy * 0.15,
//         );
//
//         projected = _clampOffset(
//           offset: projected,
//           screen: screen,
//           miniSize: miniSize,
//         );
//
//         final dockX = projected.dx < screen.width / 2
//             ? 12.0
//             : screen.width - miniSize.width - 12;
//
//         final docked = Offset(dockX, projected.dy);
//
//         notifier.updateMiniOffset(docked);
//       },
//
//       child: buildMiniPlayer(
//         context: context,
//         ref: ref,
//         controller: state.controller!,
//       ),
//     );
//   }
//   Offset _clampOffset({
//     required Offset offset,
//     required Size screen,
//     required Size miniSize,
//   })
//   {
//     final dx = offset.dx.clamp(
//       8.0,
//       screen.width - miniSize.width - 8,
//     );
//     final dy = offset.dy.clamp(
//       60.0,
//       screen.height - miniSize.height - 100,
//     );
//
//     return Offset(dx, dy);
//   }
//
//
//
//
//   Widget buildMiniPlayer({
//     required BuildContext context,
//     required WidgetRef ref,
//     required BetterPlayerController controller,
//   }) {
//     final notifier = ref.read(videoManagerProvider.notifier);
//     final state = ref.watch(videoManagerProvider);
//
//     return Material(
//       elevation: 12,
//       borderRadius: BorderRadius.circular(10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: SizedBox(
//           width: 210,
//           height: 120,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               /// 🎥 VIDEO (NO CONTROLS)
//               // Navigator(
//               //   onGenerateRoute: (_) => MaterialPageRoute(
//               //     builder: (_) => BetterPlayer(controller: controller),
//               //   ),
//               // ),
//
//               AbsorbPointer(
//                 child: Navigator(
//                   onGenerateRoute: (_) => MaterialPageRoute(
//                     builder: (_) => BetterPlayer(controller: state.controller!),
//                   ),
//                 ),
//               ),
//
//               /// ⏯ PAUSE / PLAY (ONLY BUTTON)
//               Positioned(
//                 bottom: 8,
//                 right: 8,
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     state.isPlaying
//                         ? notifier.pause()
//                         : notifier.resume();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: const BoxDecoration(
//                       color: Colors.black54,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       state.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                   ),
//                 ),
//               ),
//
//               Positioned(
//                 top: 6,
//                 right: 6,
//                 child: GestureDetector(
//                   onTap: () {
//                     notifier.closeMiniPlayer();
//                     notifier.exitMiniPlayer();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.black54,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
