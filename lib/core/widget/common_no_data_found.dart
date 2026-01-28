import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/generated/assets.dart';

class CommonNoDataFound extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imagePath;
  final double? imageSize;

  const CommonNoDataFound({
    super.key,
    required this.title,
     this.imagePath,
    this.subtitle,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath ?? Assets.imageNoDataFound,
              width: imageSize ?? 140.w,
              height: imageSize ?? 140.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.h),
            ConstText(
              text: title,
              fontSize: AppConstant.fontSizeLarge-5,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              color: AppColors.textTertiary,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              ConstText(
                text: subtitle!,
                fontSize: AppConstant.fontSizeOne,
                color: AppColors.textSecondary.withAlpha(150),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

