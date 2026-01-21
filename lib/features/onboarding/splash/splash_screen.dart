// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream4videos/core/services/notification/notification_service.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  final String title = "Stream4Video";

  final neonColors = [
    const Color(0xFFFF3B3B),
    const Color(0xFFFF7A00),
    const Color(0xFFFFC400),
    const Color(0xFFFFFF63),
  ];

  @override
  void initState() {
    super.initState();
    NotificationService.instance.init(context);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 600), () {
          _navigateNext();
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    // Future.delayed(const Duration(milliseconds: 3000), () {
    //   context.go(RoutesName.loginScreen);
    // });
  }


  Future<void> _navigateNext() async {
    await ref.read(userProvider.notifier).loadUser();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final user = ref.read(userProvider);
    if (user != null  && user.id !=null  && user.token !=null) {
      context.go(RoutesName.homeScreen);
    } else {
      context.go(RoutesName.loginScreen);

    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            children: [
              /// BACKGROUND PARTICLES
              Positioned.fill(
                child: ParticleField(
                  progress: _controller.value,
                  colors: neonColors,
                ),
              ),

              /// MAIN TITLE
              Center(
                child: NeonTitle(
                  // title: title,
                  colors: neonColors,
                  progress: _controller.value,
                ),
              ),

              /// LOADING INDICATOR
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _controller.value,
                  child: Column(
                    children: [
                      Text(
                        "LOADING...",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          letterSpacing: 4,
                          color: neonColors[0].withAlpha(80),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 180,
                        child: LinearProgressIndicator(
                          value: _controller.value,
                          color: neonColors[0],
                          backgroundColor:
                          neonColors[0].withAlpha(10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NeonTitle extends StatelessWidget {
  final List<Color> colors;
  final double progress;

  const NeonTitle({
    super.key,
    required this.colors,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLine("STREAM", 0),
        const SizedBox(height: 3),
        _buildLine("4VIDEO", 6),
      ],
    );
  }

  Widget _buildLine(String word, int offset) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(word.length, (i) {
        final index = offset + i;

        final delay = index * 0.05;
        final p = (progress - delay).clamp(0.0, 1.0);
        final eased = Curves.easeOutBack.transform(p);

        final slideY = lerpDouble(35, 0, eased)!;
        final scale = lerpDouble(0.4, 1, eased)!;
        final rot = lerpDouble(0.8, 0, eased)!;

        final glow = lerpDouble(0, 14, p)!;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            // ignore: duplicate_ignore
            // ignore: deprecated_member_use
            ..translate(0.0, slideY)
            ..scale(scale)
            ..rotateX(rot),
          child: Stack(
            children: [
              Text(
                word[i],
                style: TextStyle(
                  fontSize: 58,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.black,
                ),
              ),

              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF5A5A), // brighter top red
                      Color(0xFFE4002B), // brand red
                      Color(0xFF8A0014), // deep shade
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  word[i],
                  style: TextStyle(
                    fontSize: 58,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,

                    /// ✨ SUBTLE, CLEAN SHADOWS
                    shadows: [
                      Shadow(
                        color: const Color(0xFFE4002B).withOpacity(0.25),
                        blurRadius: glow, // VERY SMALL NOW
                      ),
                      Shadow(
                        color: Colors.red,
                        blurRadius: glow * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ParticleField extends StatefulWidget {
  final double progress;
  final List<Color> colors;

  const ParticleField({
    super.key,
    required this.progress,
    required this.colors,
  });

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> {
  final List<Offset> points = [];
  final int count = 60;

  @override
  void initState() {
    super.initState();
    final random = Random();

    // Pre-generate particle positions → SUPER LIGHT
    for (int i = 0; i < count; i++) {
      points.add(Offset(random.nextDouble(), random.nextDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(
        points: points,
        progress: widget.progress,
        colors: widget.colors,
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Offset> points;
  final double progress;
  final List<Color> colors;

  ParticlePainter({
    required this.points,
    required this.progress,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    for (int i = 0; i < points.length; i++) {
      final p = points[i];
      final color = colors[i % colors.length];

      final dx = (sin(progress * 6 + i) * 12);
      final dy = (cos(progress * 6 + i) * 12);

      final pos = Offset(p.dx * size.width + dx, p.dy * size.height + dy);

      paint.color = color.withOpacity(0.15 + progress * 0.4);

      canvas.drawCircle(pos, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
