import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';




class UpgradedCategorySelector extends StatefulWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onSelect;

  const UpgradedCategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  State<UpgradedCategorySelector> createState() =>
      _UpgradedCategorySelectorState();
}

class _UpgradedCategorySelectorState extends State<UpgradedCategorySelector> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void didUpdateWidget(covariant UpgradedCategorySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    double offset = widget.selectedIndex * 90;
    _scrollController.animateTo(
      max(0, offset - 140),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: List.generate(
                widget.categories.length,
                    (index) {
                  final selected = index == widget.selectedIndex;

                  return GestureDetector(
                    onTap: () => widget.onSelect(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin:  EdgeInsets.symmetric(horizontal: 5.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 38.h,
                      // width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: selected
                            ? const LinearGradient(
                          colors: [
                            Color(0xFF2A2A2A),
                            Color(0xFF1E1E1E),
                          ],
                        )
                            : null,
                        color: selected ? null : const Color(0xFF1C1C1C),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFFFFB300) // amber gold
                              : Colors.grey.shade700,
                          width: selected ? 2.5 : 2,
                        ),
                        boxShadow: selected
                            ? [
                          BoxShadow(
                            color:
                            const Color(0xFFFFB300).withAlpha(30),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                            : [],
                      ),
                        child: selected
                            ? _shimmerText(widget.categories[index])
                            : ConstText(text:widget.categories[index],fontWeight: AppConstant.semiBold,letterSpacing: 1.3,),
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ★ Shimmer Text for Selected Item
  Widget _shimmerText(String text) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (_, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1 + _shimmerController.value * 2, 0),
              end: Alignment(1 + _shimmerController.value * 2, 0),
              colors: [
                Color(0xFFFFB300),
                Color(0xFFFFF4CC),
                Color(0xFFFFB300),
              ],
              stops: const [
                0.45,
                0.5,
                0.55,
              ],
            ).createShader(rect);
          },
          child: ConstText(text:
            text,
         fontWeight: AppConstant.bold,
            letterSpacing: 1.3,
          ),
        );
      },
    );
  }
}
