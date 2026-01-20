
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/constant/const_bottom_sheet.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';

class CommonConfirmSheet extends StatelessWidget {
  final String imagePath;
  final String title;
  final String confirmText;
  final String? subtitle;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool danger;

  const CommonConfirmSheet({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onConfirm,
    this.confirmText = "Yes",
    this.cancelText = "No",
    this.onCancel,
    this.danger = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
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

          /// icon
          Container(
            padding:  EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1F2024),
              border: Border.all(
                color: danger
                    ? AppColors.error.withAlpha(2000)
                    : Colors.white12,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(1000),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              height: 28.h,
              color: danger
                  ? AppColors.error
                  : Colors.white70,
            ),
          ),

          AppSizes.spaceH(16),

          /// title
          ConstText(
            text: title,
            textAlign: TextAlign.center,
            fontSize: AppConstant.fontSizeThree,
            fontWeight: AppConstant.extraBold,
          ),
          if(subtitle !=null && subtitle !="")...[
             AppSizes.spaceH(10),
            ConstText(
              text: subtitle!,
              textAlign: TextAlign.center,
              fontSize: AppConstant.fontSizeSmall,
              fontWeight: AppConstant.semiBold,
              color: AppColors.textTertiary,
            ),

          ],


          AppSizes.spaceH(20),

          /// confirm button
          AppBtn(
            title: confirmText,
            onTap: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),

          AppSizes.spaceH(8),

          /// cancel
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onCancel?.call();
            },
            child: ConstText(
              text: cancelText,
              fontSize: AppConstant.fontSizeThree,
              fontWeight: AppConstant.semiBold,
            ),
          ),

          AppSizes.spaceH(10),
        ],
      ),
    );
  }
}
