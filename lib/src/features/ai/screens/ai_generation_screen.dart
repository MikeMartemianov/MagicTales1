import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIGenerationScreen extends ConsumerWidget {
  final String generationType;
  final String? context;

  const AIGenerationScreen({
    super.key,
    required this.generationType,
    this.context,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Generation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AI Generation Screen - Coming Soon'),
            const SizedBox(height: 16),
            Text('Generation Type: $generationType'),
            if (this.context != null) Text('Context: ${this.context}'),
          ],
        ),
      ),
    );
  }
}