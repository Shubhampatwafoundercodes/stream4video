import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';
// ignore: unused_import
import 'package:stream4videos/generated/assets.dart';

class AppCachedImage extends StatelessWidget {
  final String? url;

  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  final Color? placeholderColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  final VoidCallback? onTap;

  const AppCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColor,
    this.placeholder,
    this.errorWidget,
    this.onTap,
  });

  bool get _isValidUrl {
    if (url == null || url!.isEmpty) return false;
    if (!url!.startsWith('http')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget image;

    // 🔐 INVALID URL GUARD
    if (!_isValidUrl) {
      image = _errorContainer();
    } else {
      image = CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        memCacheHeight: height?.toInt(),
        memCacheWidth: width?.toInt(),

        placeholder: (_, __) =>
        placeholder ?? _placeholderContainer(),

        errorWidget: (_, __, ___) => _errorContainer(),

        // 🔥 IMPORTANT: prevent crash on bad image data
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (_, __, ___) => _errorContainer(),
          );
        },
      );
    }

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    if (onTap != null) {
      image = GestureDetector(onTap: onTap, child: image);
    }

    return image;
  }

  Widget _placeholderContainer() {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? Colors.black12,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  Widget _errorContainer() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: AppColors.background,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.image_not_supported,
                color: Colors.white38,
                size: 32,
              ),
              // SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Stream4Video',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
