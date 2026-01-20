import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/provider/video/full_screen_helper.dart';
import 'package:stream4videos/core/provider/video/video_manager_notifier.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/notifier/movie_details_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/main.dart';


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

    void showControlsOverlay() {
      showOverlay.value = true;
      overlayTimer.value?.cancel();
      overlayTimer.value = Timer(const Duration(seconds: 4), () {
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


      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
       await  FullScreenHelper.exit();

      overlayTimer.value?.cancel();

      Future.microtask(() async {
        if (ref.context.mounted) {
          notifier.disposePlayer();
        }
      });
    }


    useEffect(() {
      FullScreenHelper.enter();
      notifier.playFromUrl(videoUrl);
      return () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        notifier.disposePlayer();
      };
    }, const []);

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
            /// 🔙 BACK
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
      
            // if (showOverlay.value && !isSheetOpen.value)
            //   Positioned(
            //   top: 50.h,
            //   right: 10.w,
            //   child: IconButton(
            //     icon: Icon(
            //       state.isRotationLocked
            //           ? Icons.screen_lock_rotation
            //           : Icons.screen_rotation,
            //       color:AppColors.textPrimary,
            //     ),
            //     onPressed: notifier.toggleRotationLock,
            //   ),
            // ),
      
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
                        color: AppColors.blackPrimary.withAlpha(40),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(Icons.keyboard_arrow_up, color: Colors.white,size: 18,),
                          AppSizes.spaceW(06),
                          ConstText(
                            text:
                          "More like this",
                            fontSize: AppConstant.fontSizeZero,
                          ),
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


