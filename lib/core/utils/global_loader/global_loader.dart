import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/routes/routes.dart';


class GlobalLoader {
  static bool _isShowing = false;

  static void show({String? message}) {
    if (_isShowing) return;
    _isShowing = true;

    final context = navigatorKey.currentContext;
    if (context == null) return;


    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: _GlobalLoaderDialog(message: message),
        );
      },
    );
  }

  static void hide() {
    if (!_isShowing) return;

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    if (navigator.canPop()) {
      _isShowing = false;
      navigator.pop();
    }
  }}
class _GlobalLoaderDialog extends StatelessWidget {
  final String? message;

  const _GlobalLoaderDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          width: 160,
          padding: const EdgeInsets.symmetric(
            vertical: 28,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF181819),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.7),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.redAccent,
                  ),
                ),
              ),
               SizedBox(height: 18),
              ConstText(text:
                message ?? "Please wait...",
                textAlign: TextAlign.center,
                  color: Colors.white70,
                  fontSize: 13.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
