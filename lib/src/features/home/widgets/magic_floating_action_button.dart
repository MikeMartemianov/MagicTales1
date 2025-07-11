import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MagicFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String? tooltip;

  const MagicFloatingActionButton({
    super.key,
    required this.onPressed,
    this.tooltip,
  });

  @override
  State<MagicFloatingActionButton> createState() => _MagicFloatingActionButtonState();
}

class _MagicFloatingActionButtonState extends State<MagicFloatingActionButton>
    with TickerProviderStateMixin {
  late AnimationController _sparkleController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    
    _sparkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow effect
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 80 + (20 * _pulseController.value),
              height: 80 + (20 * _pulseController.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.3 * (1 - _pulseController.value)),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),
        
        // Sparkles around the button
        AnimatedBuilder(
          animation: _sparkleController,
          builder: (context, child) {
            return SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                painter: _SparklesPainter(
                  animation: _sparkleController,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
        ),
        
        // Main FAB
        FloatingActionButton(
          onPressed: widget.onPressed,
          tooltip: widget.tooltip ?? 'Create Story',
          elevation: 8,
          backgroundColor: Theme.of(context).primaryColor,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 28,
            )
              .animate(onPlay: (controller) => controller.repeat())
              .rotation(
                begin: 0,
                end: 0.05,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              )
              .then()
              .rotation(
                begin: 0.05,
                end: -0.05,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              )
              .then()
              .rotation(
                begin: -0.05,
                end: 0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              ),
          ),
        ),
      ],
    );
  }
}

class _SparklesPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _SparklesPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw sparkles in a circle around the FAB
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 * 3.14159 / 180) + (animation.value * 2 * 3.14159);
      final sparkleRadius = radius + (10 * (0.5 + 0.5 * 
          (animation.value * 4 + i).sin()));
      
      final sparkleCenter = Offset(
        center.dx + sparkleRadius * angle.cos(),
        center.dy + sparkleRadius * angle.sin(),
      );

      final sparkleSize = 2 + (2 * (animation.value * 3 + i).sin().abs());
      
      _drawSparkle(canvas, paint, sparkleCenter, sparkleSize);
    }

    // Draw additional floating sparkles
    for (int i = 0; i < 4; i++) {
      final angle = (i * 90 * 3.14159 / 180) + (animation.value * -1.5 * 3.14159);
      final sparkleRadius = radius * 1.3 + (5 * (animation.value * 2 + i).cos());
      
      final sparkleCenter = Offset(
        center.dx + sparkleRadius * angle.cos(),
        center.dy + sparkleRadius * angle.sin(),
      );

      final opacity = (0.3 + 0.7 * (animation.value * 4 + i).sin().abs());
      final sparkleSize = 1.5 + (1.5 * (animation.value * 5 + i).cos().abs());
      
      final sparklePaint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      
      _drawSparkle(canvas, sparklePaint, sparkleCenter, sparkleSize);
    }
  }

  void _drawSparkle(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    
    // Draw a 4-pointed star sparkle
    final points = <Offset>[
      Offset(center.dx, center.dy - size), // top
      Offset(center.dx + size * 0.3, center.dy - size * 0.3), // top-right
      Offset(center.dx + size, center.dy), // right
      Offset(center.dx + size * 0.3, center.dy + size * 0.3), // bottom-right
      Offset(center.dx, center.dy + size), // bottom
      Offset(center.dx - size * 0.3, center.dy + size * 0.3), // bottom-left
      Offset(center.dx - size, center.dy), // left
      Offset(center.dx - size * 0.3, center.dy - size * 0.3), // top-left
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}