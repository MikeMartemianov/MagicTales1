import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/models/story.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool showProgress;
  final double? progress;

  const StoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onFavorite,
    this.showProgress = false,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            _buildCoverImage(context),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      story.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Author
                    Text(
                      'by ${story.authorName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const Spacer(),
                    
                    // Progress bar (if enabled)
                    if (showProgress && progress != null) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress!,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(progress! * 100).round()}% complete',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    
                    // Tags and metadata
                    if (story.tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: story.tags.take(2).map((tag) => 
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
      .animate()
      .fadeIn(duration: const Duration(milliseconds: 300))
      .slideY(begin: 0.1, end: 0);
  }

  Widget _buildCoverImage(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getCoverGradient(story.id),
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _MagicalPatternPainter(),
            ),
          ),
          
          // Cover image (if available)
          if (story.coverImageUrl != null || story.coverImagePath != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: story.coverImageUrl != null
                    ? Image.network(
                        story.coverImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultCover(context);
                        },
                      )
                    : Image.asset(
                        story.coverImagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultCover(context);
                        },
                      ),
              ),
            )
          else
            _buildDefaultCover(context),
          
          // Overlay actions
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Favorite button
                if (onFavorite != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        story.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: story.isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                      onPressed: onFavorite,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Story metadata overlay
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getEstimatedReadTime(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCover(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getCoverGradient(story.id),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              size: 32,
              color: Colors.white.withOpacity(0.8),
            ),
            const SizedBox(height: 4),
            Text(
              story.title.length > 15 
                  ? '${story.title.substring(0, 15)}...'
                  : story.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getCoverGradient(String storyId) {
    // Generate consistent colors based on story ID
    final hash = storyId.hashCode;
    final gradients = [
      [Colors.purple.shade400, Colors.purple.shade600],
      [Colors.blue.shade400, Colors.blue.shade600],
      [Colors.green.shade400, Colors.green.shade600],
      [Colors.orange.shade400, Colors.orange.shade600],
      [Colors.pink.shade400, Colors.pink.shade600],
      [Colors.teal.shade400, Colors.teal.shade600],
      [Colors.indigo.shade400, Colors.indigo.shade600],
      [Colors.red.shade400, Colors.red.shade600],
    ];
    
    return gradients[hash.abs() % gradients.length];
  }

  String _getEstimatedReadTime() {
    final wordCount = story.scenes.fold<int>(
      0,
      (sum, scene) => sum + scene.text.split(' ').length,
    );
    
    final minutes = (wordCount / 200).ceil(); // Average reading speed
    
    if (minutes < 1) {
      return '< 1 min';
    } else if (minutes < 60) {
      return '$minutes min';
    } else {
      final hours = (minutes / 60).floor();
      final remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}m';
    }
  }
}

class _MagicalPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw magical sparkles pattern
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 8; j++) {
        final x = (size.width / 10) * i + (i % 2 == 0 ? 0 : size.width / 20);
        final y = (size.height / 8) * j;
        
        if ((i + j) % 3 == 0) {
          _drawSparkle(canvas, paint, Offset(x, y), 3);
        }
      }
    }
  }

  void _drawSparkle(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    
    // Draw a simple 4-pointed star
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}