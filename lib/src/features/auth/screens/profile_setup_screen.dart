import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSetupScreen extends ConsumerWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup')),
      body: const Center(
        child: Text('Profile Setup Screen - Coming Soon'),
      ),
    );
  }
}