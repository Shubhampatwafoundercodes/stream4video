import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:stream4videos/core/provider/video/full_screen_helper.dart';
import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/notifier/movie_details_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/main.dart';
import 'package:volume_controller/volume_controller.dart';


class FullscreenVideoScreen extends HookConsumerWidget {
  final String videoUrl;
  final List<ContentPosterItemModel>? moreLikeThis;
  const FullscreenVideoScreen({super.key, required this.videoUrl,this.moreLikeThis});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(videoManagerProvider.notifier);
    final movieNo = ref.read(movieDetailsNotifierProvider.notifier);
    final state = ref.watch(videoManagerProvider);
    final isExiting = useRef(false);
    final showOverlay = useState(false);
    final isSheetOpen = useState(false);
    final overlayTimer = useRef<Timer?>(null);
    final brightnessValue = useState<double>(0.5);
    final volumeValue = useState<double>(0.5);
    final showBrightnessUI = useState(false);
    final showVolumeUI = useState(false);

    final showSeekUI = useState(false);
    final seekText = useState<String>('');

    final double edgeWidth = MediaQuery.of(context).size.width * 0.18;

    void showControlsOverlay() {
      showOverlay.value = true;
      overlayTimer.value?.cancel();
      overlayTimer.value = Timer(const Duration(seconds: 5), () {
        showOverlay.value = false;
      });
    }

    void openSheet() {
      overlayTimer.value?.cancel();
      showOverlay.value = false;
      isSheetOpen.value = true;
    }

    void closeSheet() {
      isSheetOpen.value = false;
    }
    void exitFullscreenOnly()async {
      if (isExiting.value) return;
      isExiting.value = true;

      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      // ]);
       await  FullScreenHelper.exit();

      overlayTimer.value?.cancel();

      Future.microtask(() async {
        if (ref.context.mounted) {
          notifier.disposePlayer();
        }
      });
    }



    useEffect(() {
      final observer = VideoLifecycleObserver(notifier);

      WidgetsBinding.instance.addObserver(observer);

      FullScreenHelper.enter();
      notifier.playFromUrl(videoUrl);
      VolumeController.instance.showSystemUI = false;
      VolumeController.instance.getVolume().then((v) => volumeValue.value = v);


      try {
        ScreenBrightness.instance.application
            .then((v) => brightnessValue.value = v);
      } catch (_) {}

      return () async {
        WidgetsBinding.instance.removeObserver(observer);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        VolumeController.instance.showSystemUI = true;
        notifier.disposePlayer();
      };
    }, const []);


    void seekBy(Duration offset) async {
      final controller = state.controller;
      if (controller == null) return;

      final position =
      await controller.videoPlayerController?.position;
      if (position == null) return;

      controller.seekTo(position + offset);

      // 🔥 TEXT
      seekText.value = offset.inSeconds > 0 ? "+10" : "-10";

      // 🔥 SHOW UI
      showSeekUI.value = true;

      HapticFeedback.mediumImpact();


      Future.delayed(const Duration(milliseconds: 600), () {
        // seekAnimController.reverse();
        showSeekUI.value = false;
      });
    }


    void onVerticalDragUpdate(
        DragUpdateDetails details,
        bool isLeftSide,
        ) async {
      if (details.primaryDelta == null) return;

      showOverlay.value = true;

      showBrightnessUI.value = isLeftSide;
      showVolumeUI.value = !isLeftSide;

      final delta = details.primaryDelta! / -200;

      if (isLeftSide) {
        brightnessValue.value = (brightnessValue.value + delta).clamp(0.0, 1.0);

        try {
          await ScreenBrightness.instance.setScreenBrightness(brightnessValue.value);
        } on PlatformException catch (e) {
          debugPrint("Brightness not supported: $e");
        }
      } else {
        volumeValue.value =
            (volumeValue.value + delta).clamp(0.0, 1.0);

        VolumeController.instance.setVolume(volumeValue.value);
      }

      showControlsOverlay();
    }


    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (isSheetOpen.value) {
          closeSheet();
          return;
        }
        if (showOverlay.value) {
          showOverlay.value = false;
          return;
        }

        exitFullscreenOnly();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Stack(
          children: [
            /// 🎥 VIDEO
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: showControlsOverlay,

                child: state.controller != null
                    ? BetterPlayer(controller: state.controller!)
                    : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                ignoring: showOverlay.value,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: showControlsOverlay,
                ),
              ),
            ),

            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: edgeWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: () =>
                    seekBy(const Duration(seconds: -10)),
                onVerticalDragUpdate: (d) =>
                    onVerticalDragUpdate(d, true),
              ),
            ),

            /// 🔊 RIGHT EDGE – VOLUME
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: edgeWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: () => seekBy(const Duration(seconds: 10)),
                onVerticalDragUpdate: (d) =>
                    onVerticalDragUpdate(d, false),
              ),
            ),
            if (showOverlay.value && showBrightnessUI.value)
              Align(
                alignment: Alignment.centerLeft,
                child: _VerticalProgressBar(
                  value: brightnessValue.value,
                  icon: Icons.brightness_6,
                  color: Colors.white,
                ),
              ),

            if (showOverlay.value && showBrightnessUI.value)
              Align(
                alignment: Alignment.centerLeft,
                child: _VerticalProgressBar(
                  value: brightnessValue.value,
                  icon: Icons.brightness_6,
                  color: Colors.white,
                ),
              ),

            if (showSeekUI.value)
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      if (!seekText.value.startsWith('+'))
                        Positioned(
                          left: 24,
                          top: MediaQuery.of(context).size.height / 2 - 60,
                          child: _seekBubble(
                            icon: Icons.replay_10,
                            text: "10 seconds",
                          ),
                        ),

                      if (seekText.value.startsWith('+'))
                        Positioned(
                          right: 24,
                          top: MediaQuery.of(context).size.height / 2 - 60,
                          child: _seekBubble(
                            icon: Icons.forward_10,
                            text: "10 seconds",
                          ),
                        ),
                    ],
                  ),
                ),
              ),


            /// 🔊 VOLUME INDICATOR
            if (showOverlay.value && showVolumeUI.value)
              Align(
                alignment: Alignment.centerRight,
                child: _VerticalProgressBar(
                  value: volumeValue.value,
                  icon: Icons.volume_up,
                  color: Colors.white,
                ),
              ),

            if (showOverlay.value && !isSheetOpen.value)
              Positioned(
              top: 50.h,
              left: 12.w,
              child: IconButton(
                icon:  Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () async {
                  exitFullscreenOnly();
                  if (context.mounted) {
                    context.pop();

                  }



                  },
              ),
            ),

            if (showOverlay.value && !isSheetOpen.value  && (moreLikeThis !=null && moreLikeThis!.isNotEmpty))
              Positioned(
                left: 0,
                right: 0,
                bottom: 32.h,
                child: Center(
                  child:
                  GestureDetector(
                    onTap: (){
                      openSheet();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.blackPrimary.withAlpha(80),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(Icons.keyboard_arrow_up, color: Colors.white,size: 18,),
                          AppSizes.spaceW(06),
                          Text(
                          "More like this",
                           style: TextStyle(
                            // fontSize: AppC,
                            color: AppColors.textPrimary,
                          ),)
                        ],
                      ),
                    ),
                  )
                ),
              ),


            if(moreLikeThis !=null && moreLikeThis!.isNotEmpty && moreLikeThis!.isNotEmpty)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              bottom: isSheetOpen.value ? 0 : -screenHeight-40,
              // height: 260,
              child: _FullSuggestionsOverlay(
                onBack: closeSheet,
                moreLikeThis: moreLikeThis,
                onItemTap: (contentId) async{
                  movieNo.movieDetailsApi(contentId);


                  exitFullscreenOnly();
                  if (context.mounted) {
                    context.pop();
                  }




                },
              ),
            ),




          ],
        ),
      ),
    );



  }

  Widget _seekBubble({
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 48),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }


}







class _VerticalProgressBar extends StatelessWidget {
  final double value;
  final IconData icon;
  final Color color;

  const _VerticalProgressBar({required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      height: 200.h,
      // width: 40.w,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              width: 2.w,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 150.h * value,
                    width: 2.w,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 4)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class VideoLifecycleObserver extends WidgetsBindingObserver {
  final VideoManagerNotifier notifier;

  VideoLifecycleObserver(this.notifier);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      notifier.pause(); // 🔴 background → pause
    }

    if (state == AppLifecycleState.resumed) {
      notifier.resume(); // 🟢 foreground → resume
    }
  }
}



class _FullSuggestionsOverlay extends StatelessWidget {
  final VoidCallback onBack;
  final Function(String contentId) onItemTap;
  final List<ContentPosterItemModel>? moreLikeThis;
  const _FullSuggestionsOverlay({required this.onBack,this.moreLikeThis,required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    if(moreLikeThis!=null && moreLikeThis!.isEmpty)return SizedBox.shrink();
    return Container(
      color: AppColors.background,
      height: screenHeight,
      width: screenWidth,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon:  Icon(Icons.close, color: AppColors.textPrimary),
              onPressed: onBack,
            ),

             Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ConstText(text:
                "More like this",
              ),
            ),

           AppSizes.spaceH(20),

            Expanded(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.landscape) {
                    final items = moreLikeThis ?? [];

                    return ListView.builder(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: moreLikeThis?.length,
                      itemBuilder: (_, i) {
                        final item = moreLikeThis![i];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: i == items.length - 1 ? 0 : 12.h,bottom: 25.h
                          ),
                          child: SizedBox(
                              height: 90.h,
                              child: PosterCard(
                                  item: item,
                                onTap: (){

                                  onItemTap(item.id.toString());

                                },



                              )),
                        );
                      },
                    );
                  }

                  return GridView.builder(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2/3,
                    ),
                    itemCount: moreLikeThis?.length,
                    itemBuilder: (_, i) {
                      final item = moreLikeThis![i];

                      return PosterCard(item: item,
                      onTap: (){
                        onItemTap(item.id.toString());

                      },

                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


