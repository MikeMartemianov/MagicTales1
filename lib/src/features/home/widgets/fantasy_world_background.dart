import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FantasyWorldBackground extends StatefulWidget {
  const FantasyWorldBackground({super.key});

  @override
  State<FantasyWorldBackground> createState() => _FantasyWorldBackgroundState();
}

class _FantasyWorldBackgroundState extends State<FantasyWorldBackground>
    with TickerProviderStateMixin {
  late AnimationController _cloudsController;
  late AnimationController _sparklesController;
  late AnimationController _forestController;

  @override
  void initState() {
    super.initState();
    
    _cloudsController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
    
    _sparklesController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    _forestController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _cloudsController.dispose();
    _sparklesController.dispose();
    _forestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Sky gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.purple.shade50,
                Colors.pink.shade50,
                Colors.white,
              ],
              stops: const [0.0, 0.3, 0.6, 1.0],
            ),
          ),
        ),
        
        // Animated clouds
        AnimatedBuilder(
          animation: _cloudsController,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _CloudsPainter(_cloudsController.value),
            );
          },
        ),
        
        // Fantasy forest silhouette
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: AnimatedBuilder(
            animation: _forestController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _ForestPainter(_forestController.value),
              );
            },
          ),
        ),
        
        // Floating sparkles
        AnimatedBuilder(
          animation: _sparklesController,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _SparklesPainter(_sparklesController.value),
            );
          },
        ),
        
        // Castle silhouette in the distance
        Positioned(
          top: 100,
          right: 50,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              width: 80,
              height: 60,
              child: CustomPaint(
                painter: _CastlePainter(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CloudsPainter extends CustomPainter {
  final double animationValue;

  _CloudsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Draw multiple clouds moving across the screen
    for (int i = 0; i < 4; i++) {
      final cloudX = ((size.width + 200) * animationValue + (i * 150)) % (size.width + 200) - 100;
      final cloudY = 50 + (i * 30.0);
      final cloudScale = 0.5 + (i * 0.2);
      
      _drawCloud(canvas, paint, Offset(cloudX, cloudY), cloudScale);
    }
  }

  void _drawCloud(Canvas canvas, Paint paint, Offset center, double scale) {
    final path = Path();
    
    // Main cloud body
    path.addOval(Rect.fromCenter(
      center: center,
      width: 60 * scale,
      height: 30 * scale,
    ));
    
    // Cloud puffs
    path.addOval(Rect.fromCenter(
      center: center + Offset(-20 * scale, -10 * scale),
      width: 40 * scale,
      height: 25 * scale,
    ));
    
    path.addOval(Rect.fromCenter(
      center: center + Offset(20 * scale, -5 * scale),
      width: 35 * scale,
      height: 20 * scale,
    ));
    
    path.addOval(Rect.fromCenter(
      center: center + Offset(0, -15 * scale),
      width: 30 * scale,
      height: 20 * scale,
    ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ForestPainter extends CustomPainter {
  final double animationValue;

  _ForestPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Create gradient for forest silhouette
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.green.shade900.withOpacity(0.8),
        Colors.green.shade800.withOpacity(0.9),
        Colors.black.withOpacity(0.7),
      ],
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, 200));

    final path = Path();
    path.moveTo(0, size.height);

    // Draw rolling hills with trees
    for (double x = 0; x <= size.width; x += 20) {
      final hillHeight = 150 + 30 * (x / 100 + animationValue * 0.5).sin();
      final treeHeight = 50 + 20 * (x / 80 + animationValue * 0.3).cos();
      
      if ((x / 60).floor() % 3 == 0) {
        // Draw a tree
        path.lineTo(x, size.height - hillHeight - treeHeight);
        path.lineTo(x + 5, size.height - hillHeight - treeHeight + 10);
        path.lineTo(x + 10, size.height - hillHeight - treeHeight);
        path.lineTo(x + 15, size.height - hillHeight);
      } else {
        path.lineTo(x, size.height - hillHeight);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SparklesPainter extends CustomPainter {
  final double animationValue;

  _SparklesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw magical sparkles floating around
    for (int i = 0; i < 15; i++) {
      final x = (size.width * (i * 0.1 + 0.1)) % size.width;
      final y = (size.height * 0.7 * (i * 0.15 + animationValue * 0.2)) % (size.height * 0.7);
      
      final opacity = (0.3 + 0.7 * (animationValue * 3 + i).sin().abs());
      final sparkleSize = 2 + (3 * (animationValue * 2 + i).cos().abs());
      
      paint.color = Colors.yellow.shade300.withOpacity(opacity);
      
      _drawSparkle(canvas, paint, Offset(x, y), sparkleSize);
    }
  }

  void _drawSparkle(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    
    // Draw a 4-pointed star
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx + size * 0.3, center.dy - size * 0.3);
    path.lineTo(center.dx + size, center.dy);
    path.lineTo(center.dx + size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx, center.dy + size);
    path.lineTo(center.dx - size * 0.3, center.dy + size * 0.3);
    path.lineTo(center.dx - size, center.dy);
    path.lineTo(center.dx - size * 0.3, center.dy - size * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CastlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple.shade900.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Castle base
    path.addRect(Rect.fromLTWH(10, size.height * 0.4, size.width - 20, size.height * 0.6));
    
    // Castle towers
    path.addRect(Rect.fromLTWH(5, size.height * 0.2, 15, size.height * 0.8));
    path.addRect(Rect.fromLTWH(size.width - 20, size.height * 0.2, 15, size.height * 0.8));
    path.addRect(Rect.fromLTWH(size.width * 0.4, size.height * 0.1, 20, size.height * 0.9));
    
    // Tower tops (triangular)
    final tower1Top = Path();
    tower1Top.moveTo(5, size.height * 0.2);
    tower1Top.lineTo(12.5, size.height * 0.05);
    tower1Top.lineTo(20, size.height * 0.2);
    tower1Top.close();
    
    final tower2Top = Path();
    tower2Top.moveTo(size.width - 20, size.height * 0.2);
    tower2Top.lineTo(size.width - 12.5, size.height * 0.05);
    tower2Top.lineTo(size.width - 5, size.height * 0.2);
    tower2Top.close();
    
    final mainTowerTop = Path();
    mainTowerTop.moveTo(size.width * 0.4, size.height * 0.1);
    mainTowerTop.lineTo(size.width * 0.5, 0);
    mainTowerTop.lineTo(size.width * 0.6, size.height * 0.1);
    mainTowerTop.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(tower1Top, paint);
    canvas.drawPath(tower2Top, paint);
    canvas.drawPath(mainTowerTop, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}