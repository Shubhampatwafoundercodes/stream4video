import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/routes/routes_name.dart';

class DeepLinkHandler {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  void init(BuildContext context) async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      // ignore: use_build_context_synchronously
      _handle(context, uri);
    }

    _sub = _appLinks.uriLinkStream.listen(
          // ignore: use_build_context_synchronously
          (uri) => _handle(context, uri),
    );
  }

  void _handle(BuildContext context, Uri uri) {
    if (uri.pathSegments.isEmpty) return;

    final first = uri.pathSegments.first;

    switch (first) {
      case 'home':
        context.goNamed(RoutesName.homeScreen);
        break;

      case 'watch':
        if (uri.pathSegments.length > 1) {
          final id = uri.pathSegments[1];
          context.goNamed(
            RoutesName.watchMovieScreen,
            extra: id,
          );
        }
        break;

      case 'search':
        context.goNamed(RoutesName.searchScreen);
        break;

      case 'notifications':
        context.goNamed(RoutesName.notificationScreen);
        break;

      default:
        context.goNamed(RoutesName.homeScreen);
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
