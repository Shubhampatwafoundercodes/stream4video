
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_color.dart';
// ignore: unused_import



class ConstText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int? maxLine;
  final double? fontSize;
  final bool? strikethrough;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final double? letterSpacing;
  final double? letterHeight;
  final TextDecoration? decoration;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Paint? foreground;
  final Color? decorationColor;
  final FontStyle? fontStyle;
  final double? textScaleFactor;

  const ConstText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.maxLine,
    this.textAlign,
    this.wordSpacing,
    this.letterSpacing,
    this.decoration,
    this.strikethrough,
    this.foreground,
    this.fontFamily,
    this.decorationColor, this.fontStyle, this.letterHeight, this.textScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        height:letterHeight,
        fontSize: fontSize ?? 13.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.textPrimary,
        wordSpacing: wordSpacing,
        foreground: foreground,
        fontStyle:fontStyle,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
        fontFamily: fontFamily ?? 'Poppins',
        overflow: maxLine != null ? TextOverflow.ellipsis : null,
      ),
    );
  }
}


class DoubleText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;
  final double? firstSize;
  final double? secondSize;
  final Color? firstColor;
  final Color? secondColor;
  final FontWeight? firstWeight;
  final FontWeight? secondWeight;

  const DoubleText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
    this.firstSize,
    this.secondSize,
    this.firstColor,
    this.secondColor,
    this.firstWeight,
    this.secondWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "$firstText ",
              style: TextStyle(
                fontSize: firstSize ?? 12,
                color: firstColor ?? Colors.white70,
                fontWeight: firstWeight ?? FontWeight.w400,
                fontFamily: 'Poppins',
                height: 1.4, // spacing fix
              ),
            ),
            TextSpan(
              text: secondText,
              style: TextStyle(
                fontSize: secondSize ?? 12,
                color: secondColor ??AppColors.textSecondary,
                fontWeight: secondWeight ?? FontWeight.w600,

                decoration: TextDecoration.underline,
                decorationColor: secondColor ?? AppColors.textSecondary,
                decorationThickness: 1.6, // thicker = shows lower
                decorationStyle: TextDecorationStyle.solid,

                height: 1.45,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
