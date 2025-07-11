import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/core/services/storage_service.dart';
import 'src/core/models/story.dart';
import 'src/core/models/scene.dart';
import 'src/core/models/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(StoryAdapter());
  Hive.registerAdapter(SceneAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  
  // Initialize storage
  await StorageService.init();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(
    const ProviderScope(
      child: FairyTalesApp(),
    ),
  );
}