import 'package:flutter/material.dart';


class GlobalLoader {
  static bool _isShowing = false;

  static void show(BuildContext context, {String? message}) {
    if (_isShowing) return;
    _isShowing = true;

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

  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
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
              const SizedBox(height: 18),
              Text(
                message ?? "Please wait...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
