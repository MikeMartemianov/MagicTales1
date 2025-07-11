import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryPlayerScreen extends ConsumerWidget {
  final String storyId;
  final String? initialSceneId;

  const StoryPlayerScreen({
    super.key,
    required this.storyId,
    this.initialSceneId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Story Player Screen - Coming Soon'),
            const SizedBox(height: 16),
            Text('Story ID: $storyId'),
            if (initialSceneId != null) Text('Scene ID: $initialSceneId'),
          ],
        ),
      ),
    );
  }
}