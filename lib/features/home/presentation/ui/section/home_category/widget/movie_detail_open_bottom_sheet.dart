import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/features/home/presentation/ui/watch_movie_screen.dart';

class MovieDetailOpenBottomSheet {
  static bool _isOpen = false;

  static Future<void> openContentSheet(
      BuildContext context, {
        required String contentId,
      }) async {
    if (_isOpen && context.canPop()) {
      context.pop();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    _isOpen = true;

    await showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: WatchMovieScreen(
            contentId: contentId,
          ),
        );
      },
    );

    _isOpen = false;
  }
}
