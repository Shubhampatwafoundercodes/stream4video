import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_size.dart';

class CommonScreenContainer extends StatelessWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  final Widget child;
  final Gradient? backgroundGradient;
  final Color? backgroundColor;

  final EdgeInsetsGeometry? padding;
  final bool scrollable;

  const CommonScreenContainer({
    super.key,
    required this.child,
    this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.backgroundGradient,
    this.backgroundColor,
    this.padding,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = backgroundGradient ?? AppColors.backgroundColourGradient;
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        color: backgroundGradient == null ? backgroundColor : null,
      ),
      child: Column(
        children: [

          if (title != null || showBack || actions != null)...[
            AppSizes.spaceH(30),
            HeaderBackText(
              title: title,
              showBack: showBack,
              onBack: onBack,
              actions: actions,
            ),

          ],

          /// 📦 BODY
          Expanded(
            child: scrollable
                ? SingleChildScrollView(
              padding:
              padding ?? EdgeInsets.all(16.r),
              child: child,
            )
                : Padding(
              padding:
              padding ?? EdgeInsets.all(16.r),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
class HeaderBackText extends StatelessWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const HeaderBackText({super.key,
    this.title,
    required this.showBack,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (showBack)
            GestureDetector(
              onTap: onBack ?? () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),

          if (showBack) SizedBox(width: 12.w),

          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          else
            const Spacer(),

          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
