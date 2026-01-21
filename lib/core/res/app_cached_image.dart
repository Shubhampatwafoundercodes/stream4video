import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stream4videos/generated/assets.dart';

class AppCachedImage extends StatelessWidget {
  final String url;

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

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      memCacheHeight: height?.toInt(),
      memCacheWidth: width?.toInt(),

      placeholder: (_, __) =>
      placeholder ??


          Container(
            width: width,
            height: height,
            color: placeholderColor ?? Colors.black12,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),

      errorWidget: (_, __, ___) =>
      errorWidget ??
          Container(
            width: width,
            height: height,
            color: Colors.black26,
            child: Image.asset(
              Assets.imagePlaystore,
              fit: BoxFit.cover,
            ),
          ),
    );

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
}
