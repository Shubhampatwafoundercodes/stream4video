import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_bottom_sheet.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';

class ExpandableDescription extends StatefulWidget {
  final String title;
  final String description;

  const ExpandableDescription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<ExpandableDescription> createState() =>
      _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.description,
          style: TextStyle(
            color: AppColors.textTertiary,
            fontSize: AppConstant.fontSizeOne,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 2,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        _isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstText(
              text:
              widget.description,
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
                color: AppColors.textTertiary,
                fontSize: AppConstant.fontSizeOne,
            ),

            if (_isOverflowing)
              GestureDetector(
                onTap: () => _openBottomSheet(context),
                child: Padding(
                  padding:  EdgeInsets.only(top: 4),
                  child: ConstText(text:
                    "More",
                      color: AppColors.textSecondary,
                      fontSize: AppConstant.fontSizeOne,
                      fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ConstBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// drag handle
              Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              AppSizes.spaceH(16),



              AppSizes.spaceH(16),

              /// title
              ConstText(
                text: widget.title,
                textAlign: TextAlign.center,
                fontSize: AppConstant.fontSizeThree,
                fontWeight: AppConstant.extraBold,
              ),
                AppSizes.spaceH(10),
                ConstText(
                  text: widget.description,
                  textAlign: TextAlign.center,
                  fontSize: AppConstant.fontSizeSmall,
                  fontWeight: AppConstant.semiBold,
                  color: AppColors.textTertiary,
                ),

              AppSizes.spaceH(20),

              // /// confirm button
              // AppBtn(
              //   title: confirmText,
              //   onTap: () {
              //     Navigator.pop(context);
              //     onConfirm();
              //   },
              // ),
              //
              // AppSizes.spaceH(8),
              //
              // /// cancel
              // TextButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //     onCancel?.call();
              //   },
              //   child: ConstText(
              //     text: cancelText,
              //     fontSize: AppConstant.fontSizeThree,
              //     fontWeight: AppConstant.semiBold,
              //   ),
              // ),
              //
              // AppSizes.spaceH(10),
            ],
          ),
        );
      },
    );
  }
}


class InlineExpandableDescription extends StatelessWidget {
  final String title;
  final String description;
  final int maxLines;

  const InlineExpandableDescription({
    super.key,
    required this.title,
    required this.description,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = TextStyle(
          color: AppColors.textTertiary,
          fontSize: AppConstant.fontSizeOne,
          fontFamily: "Poppins",
        );

        final moreStyle = TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: AppConstant.fontSizeOne,
        );

        final fullPainter = TextPainter(
          text: TextSpan(text: description, style: textStyle),
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        // ✅ No overflow → simple text
        if (!fullPainter.didExceedMaxLines) {
          return Text(description, style: textStyle);
        }

        const moreText = "… more";

        String truncated = description;

        // 🔥 Brute-force trim until fits
        for (int i = description.length; i > 0; i--) {
          final testText = description.substring(0, i).trimRight() + moreText;

          final tp = TextPainter(
            text: TextSpan(
              children: [
                TextSpan(
                  text: testText.replaceAll(moreText, ''),
                  style: textStyle,
                ),
                TextSpan(
                  text: moreText,
                  style: moreStyle,
                ),
              ],
            ),
            maxLines: maxLines,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          if (!tp.didExceedMaxLines) {
            truncated = description.substring(0, i).trimRight();
            break;
          }
        }

        return RichText(
          maxLines: maxLines,
          text: TextSpan(
            children: [
              TextSpan(text: truncated, style: textStyle),
              TextSpan(
                text: moreText,
                style: moreStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _openBottomSheet(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ConstBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              AppSizes.spaceH(16),
              ConstText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: AppConstant.fontSizeLarge,
                fontWeight: AppConstant.extraBold,
              ),
              AppSizes.spaceH(20),
              ConstText(
                text: description,
                textAlign: TextAlign.center,
                fontWeight: AppConstant.semiBold,
                color: AppColors.textSecondary,
              ),
              AppSizes.spaceH(20),
              AppBtn(
                title: "Cancel",
                onTap: () => context.pop(),
              ),
              AppSizes.spaceH(20),
            ],
          ),
        );
      },
    );
  }
}
