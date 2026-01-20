import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';

class AppBtn extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  final Color? color;
  final Function()? onTap;
  final double? fontSize;
  final bool loading;
  final Gradient? gradient;
  final bool hideBorder;
  final Widget? child;
  final FontWeight? fontWeight;
  final BoxBorder? border;
  final double borderRadius;
  final double? height;
  final BorderRadiusGeometry? radiusOnly;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final bool isDisabled;

  const AppBtn({
    super.key,
    this.title,
    this.titleColor,
    this.color,
    this.onTap,
    this.fontSize,
    this.loading = false,
    this.gradient,
    this.hideBorder = false,
    this.child,
    this.fontWeight,
    this.border,
    this.borderRadius = 08,
    this.height,
    this.radiusOnly,
    this.width,
    this.margin,
    this.isDisabled = false,
  });

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showBorder = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (widget.isDisabled) return;

    if (_showBorder) return;

    setState(() => _showBorder = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _showBorder = false);
    });

    await Future.delayed(const Duration(milliseconds: 300));
    widget.onTap?.call();
  }

  /// -------- BUTTON UI ----------
  Widget buildButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: _showBorder ? const EdgeInsets.all(1) : EdgeInsets.zero,
      margin: widget.margin,
      height: widget.height ?? 48,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius:
        widget.radiusOnly ?? BorderRadius.circular(widget.borderRadius),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isDisabled
              ? AppColors.border
              : (widget.color),

          gradient: widget.isDisabled ? null
              : (widget.color == null ? widget.gradient ?? AppColors.buttonGradient : null),
          border: widget.border,
          boxShadow: AppColors.buttonShadow,
          borderRadius: widget.radiusOnly ?? BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.child ??
            Text(
              widget.title ?? "BUTTON",
              style: TextStyle(
                color: widget.isDisabled
                    ? AppColors.textSecondary
                    : widget.titleColor ?? AppColors.blackPrimary,
                fontWeight: widget.fontWeight ?? FontWeight.w600,
                fontSize: widget.fontSize ?? AppConstant.fontSizeThree,
              ),
            ),
      ),
    );
  }

  /// -------- LOADING UI ----------
  Widget buildLoadingCircle() {
    return Center(
      child: Container(
        height: widget.height ?? 48,
        width: widget.width,
        margin: widget.margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isDisabled
              ? AppColors.border
              : widget.color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        padding: const EdgeInsets.all(3),
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  /// -------- BUILD ----------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisabled
          ? null
          : () {
        _handleTap();
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.loading ? buildLoadingCircle() : buildButton(),
          );
        },
      ),
    );
  }
}
