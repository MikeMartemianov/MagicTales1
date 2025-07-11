import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryEditorScreen extends ConsumerWidget {
  final String? storyId;

  const StoryEditorScreen({
    super.key,
    this.storyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(storyId != null ? 'Edit Story' : 'New Story'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Story Editor Screen - Coming Soon'),
            if (storyId != null) ...[
              const SizedBox(height: 16),
              Text('Editing Story ID: $storyId'),
            ],
          ],
        ),
      ),
    );
  }
}