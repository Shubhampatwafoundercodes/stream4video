import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_color.dart';

import 'app_border.dart';
import 'app_constant.dart';


class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? hintText;
  final bool readOnly;
  final int? maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool autofocus;
  final TextStyle? style;
  final TextAlign textAlign;
  final Color? textColor;
  final Color? hintColor;
  final FontWeight? hintWeight;
  final double? fontSize;
  final TextInputAction? textInputAction;
  final double? cursorHeight;
  final bool? enabled;
  final int? maxLength;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? cursorColor;
  final bool? filled;
  final String? errorText;
  final BorderRadius? fieldRadius;
  final BorderSide? borderSide;
  final BorderSide? focusBorderSide;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final String? titleText;
  final String? labelText;
  final bool showClearButton;
  final TextCapitalization textCapitalization;
  final Color? titleColor;

  const AppTextField({
    super.key,
    this.controller,
    this.onTap,
    this.hintText,
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.autofocus = false,
    this.style,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.hintColor,
    this.hintWeight,
    this.fontSize,
    this.textInputAction,
    this.cursorHeight,
    this.enabled,
    this.maxLength,
    this.height,
    this.width,
    this.margin,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
    this.errorText,
    this.fieldRadius,
    this.borderSide,
    this.focusBorderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.inputFormatters,
    this.titleText,
    this.labelText,
    this.cursorColor,
    this.showClearButton = true,
    this.titleColor,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool _obscureText = false;
  String? _errorText;
  Timer? _debounce;
  late final VoidCallback _listener;

  BorderRadius get _radius => widget.fieldRadius ?? AppBorders.btnRadius;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.obscureText;
    _errorText = widget.errorText;

    _listener = () {
      widget.onChanged?.call(_controller.text);

      if (widget.validator != null) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 300), () {
          if (!mounted) return;
          final error = widget.validator!(_controller.text);
          if (error != _errorText) {
            setState(() => _errorText = error);
          }
        });
      }
    };
    _controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_listener);
      (widget.controller ?? _controller).addListener(_listener);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _toggleObscure() => setState(() => _obscureText = !_obscureText);

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  Widget? _buildSuffix() {
    if (_controller.text.isEmpty) return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.obscureText)
          GestureDetector(
            onTap: _toggleObscure,
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
        if (widget.showClearButton)
          GestureDetector(
            onTap: _clearText,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Icon(
                Icons.close_rounded,
                size: 20,
                // ignore: deprecated_member_use
                color: AppColors.textSecondary.withOpacity(0.8),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText != null)
            Padding(
              padding: EdgeInsets.only(left: 5.w, bottom: 4.h),
              child: Text(
                widget.titleText!,
                style: widget.style ??
                    TextStyle(
                      color: widget.titleColor ?? AppColors.textPrimary,
                      fontSize: AppConstant.fontSizeThree,
                      fontFamily: 'Poppins',
                    ),
              ),
            ),

          SizedBox(
            height: widget.height ?? 50.h,
            child: TextFormField(
              controller: _controller,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              obscureText: _obscureText,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              textAlign: widget.textAlign,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              cursorColor: widget.cursorColor ?? AppColors.primary,
              cursorHeight: widget.cursorHeight,
              style: widget.style ??
                  TextStyle(
                    color: widget.textColor ?? AppColors.textPrimary,
                    fontSize: widget.fontSize ?? AppConstant.fontSizeTwo,
                    fontFamily: 'Poppins',
                  ),

              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: AppConstant.fontSizeOne
                ),

                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: widget.fontSize ?? AppConstant.fontSizeTwo,
                ),
                errorStyle: const TextStyle(
                  height: 0,
                  fontSize: 0,
                ),

                filled: true,
                // ignore: deprecated_member_use
                fillColor: AppColors.surfaceLight.withOpacity(0.60),

                prefixIcon: widget.prefixIcon,
                prefix: widget.prefix,
                suffixIcon: widget.suffixIcon,
                suffix: widget.suffix ?? _buildSuffix(),

                contentPadding:
                widget.contentPadding ??
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),

                enabledBorder: OutlineInputBorder(
                  borderRadius: _radius,
                  borderSide: BorderSide(
                    color: AppColors.borderLight,
                    width: 1.2,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: _radius,
                  borderSide: const BorderSide(
                    color: AppColors.textPrimary,
                    width: 1.4,
                  ),
                ),
                //
                errorBorder: OutlineInputBorder(
                  borderRadius: _radius,
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1.4,
                  ),
                ),

                // focusedErrorBorder: OutlineInputBorder(
                //   borderRadius: _radius,
                //   borderSide: const BorderSide(
                //     color: AppColors.error,
                //     width: 1.4,
                //   ),
                // ),

                counter: const Offstage(),
                // errorStyle: TextStyle(
                //   color: AppColors.error,
                //   fontSize: 12.sp,
                //   height: 1.1,
                // ),
                //
                // errorText: _errorText,
              ),
            ),
          ),

          if (_errorText != null && _errorText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 2.h),
              child: Text(
                _errorText!,
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 12.sp,
                  height: 1.1,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
        ],
      ),
    );
  }
}


