import 'dart:async';

import 'package:flutter/foundation.dart';






Timer? _hideTimer;

void autoHideControls(ValueNotifier<bool> showControls) {
  _hideTimer?.cancel();
  _hideTimer = Timer(const Duration(seconds: 4), () {
    showControls.value = false;
  });
}