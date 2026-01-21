import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';

class AnimatedGoldenBadge extends StatefulWidget {
  final List<String> texts;
  final double width;
  final double height;
  final VoidCallback? onTap;


  const AnimatedGoldenBadge({
    super.key,
    required this.texts,
    this.width = 80,
    this.height = 32,
    this.onTap,

  });

  @override
  State<AnimatedGoldenBadge> createState() => _AnimatedGoldenBadgeState();
}

class _AnimatedGoldenBadgeState extends State<AnimatedGoldenBadge> with TickerProviderStateMixin {

  late AnimationController borderController;
  late AnimationController textController;

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // 🔥 Text Fade Animation Controller
    textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    textController.forward();

    // 🔥 Auto Scroll Timer
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      textController.reverse().then((_) {
        setState(() {
          currentIndex = (currentIndex + 1) % widget.texts.length;
        });

        textController.forward();
      });
    });
  }

  @override
  void dispose() {
    borderController.dispose();
    textController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: borderController,
      builder: (_, __) {
        return InkWell(
          onTap: widget.onTap,
          child: CustomPaint(
            painter: _GoldenBorderPainter(borderController.value),
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FadeTransition(
                opacity: textController,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.4),
                    end: Offset.zero,
                  ).animate(textController),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [
                          Color(0xFFE7C37F),
                          Color(0xFFD4A857),
                          Color(0xFFA8752E),
                          Color(0xFF6B4C1E),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: ConstText(text:
                      widget.texts[currentIndex],
                      fontSize: AppConstant.fontSizeOne,
                      fontWeight: AppConstant.extraBold,

                    ),
                  ),
                ),
              ),

            ),
          ),
        );
      },
    );
  }
}

class _GoldenBorderPainter extends CustomPainter {
  final double animationValue;
  _GoldenBorderPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 🌟 Luxury Dark-Gold Sweep Gradient
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 6.28,
      colors: [
        Colors.transparent,        // smooth gap
        Color(0xFFE7C37F),         // soft gold highlight
        Color(0xFFD4A857),         // warm gold
        Color(0xFFA8752E),         // metallic brown gold
        Color(0xFF6B4C1E),         // dark gold depth
        Colors.transparent,
      ],
      stops: const [0.0, 0.20, 0.45, 0.65, 0.82, 1.0],
      transform: GradientRotation(6.28 * animationValue),
    );

    final paintStyle = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(5),
    );

    canvas.drawRRect(rRect, paintStyle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
