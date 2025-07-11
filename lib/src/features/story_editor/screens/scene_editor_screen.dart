import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SceneEditorScreen extends ConsumerWidget {
  final String storyId;
  final String sceneId;

  const SceneEditorScreen({
    super.key,
    required this.storyId,
    required this.sceneId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scene Editor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Scene Editor Screen - Coming Soon'),
            const SizedBox(height: 16),
            Text('Story ID: $storyId'),
            Text('Scene ID: $sceneId'),
          ],
        ),
      ),
    );
  }
}