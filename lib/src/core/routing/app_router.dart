import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/profile_setup_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/library/screens/library_screen.dart';
import '../../features/story_player/screens/story_player_screen.dart';
import '../../features/story_editor/screens/story_editor_screen.dart';
import '../../features/story_editor/screens/scene_editor_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/profile_screen.dart';
import '../../features/ai/screens/ai_generation_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/achievements/screens/achievements_screen.dart';
import '../providers/auth_provider.dart';
import '../models/story.dart';
import '../models/scene.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    initialLocation: authState.isAuthenticated ? '/home' : '/onboarding',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isOnboarding = state.location == '/onboarding';
      final isAuth = state.location.startsWith('/auth');
      
      // If not authenticated and not on auth/onboarding pages, redirect to onboarding
      if (!isAuthenticated && !isOnboarding && !isAuth) {
        return '/onboarding';
      }
      
      // If authenticated and on auth/onboarding pages, redirect to home
      if (isAuthenticated && (isOnboarding || isAuth)) {
        return '/home';
      }
      
      return null; // No redirect needed
    },
    routes: [
      // Onboarding Route
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Auth Routes
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/auth/profile-setup',
        name: 'profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          // Library nested routes
          GoRoute(
            path: 'library',
            name: 'library',
            builder: (context, state) => const LibraryScreen(),
          ),
          
          // Story Player
          GoRoute(
            path: 'story/:storyId/play',
            name: 'story-player',
            builder: (context, state) {
              final storyId = state.pathParameters['storyId']!;
              final sceneId = state.queryParameters['sceneId'];
              return StoryPlayerScreen(
                storyId: storyId,
                initialSceneId: sceneId,
              );
            },
          ),
          
          // Story Editor Routes
          GoRoute(
            path: 'story/:storyId/edit',
            name: 'story-editor',
            builder: (context, state) {
              final storyId = state.pathParameters['storyId']!;
              return StoryEditorScreen(storyId: storyId);
            },
            routes: [
              GoRoute(
                path: 'scene/:sceneId',
                name: 'scene-editor',
                builder: (context, state) {
                  final storyId = state.pathParameters['storyId']!;
                  final sceneId = state.pathParameters['sceneId']!;
                  return SceneEditorScreen(
                    storyId: storyId,
                    sceneId: sceneId,
                  );
                },
              ),
            ],
          ),
          
          // New Story Creation
          GoRoute(
            path: 'story/new',
            name: 'new-story',
            builder: (context, state) => const StoryEditorScreen(),
          ),
          
          // AI Generation
          GoRoute(
            path: 'ai/generate',
            name: 'ai-generation',
            builder: (context, state) {
              final type = state.queryParameters['type'] ?? 'story';
              final context = state.queryParameters['context'];
              return AIGenerationScreen(
                generationType: type,
                context: context,
              );
            },
          ),
          
          // Community Features
          GoRoute(
            path: 'community',
            name: 'community',
            builder: (context, state) => const CommunityScreen(),
          ),
          
          // Achievements
          GoRoute(
            path: 'achievements',
            name: 'achievements',
            builder: (context, state) => const AchievementsScreen(),
          ),
          
          // Settings Routes
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Error/404 Route
      GoRoute(
        path: '/error',
        name: 'error',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Oops! Something went wrong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  state.extra?.toString() ?? 'Unknown error occurred',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'The page "${state.location}" could not be found.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Navigation helper extension
extension AppRouterExtension on GoRouter {
  void pushStoryPlayer(String storyId, {String? sceneId}) {
    pushNamed(
      'story-player',
      pathParameters: {'storyId': storyId},
      queryParameters: sceneId != null ? {'sceneId': sceneId} : null,
    );
  }
  
  void pushStoryEditor(String? storyId) {
    if (storyId != null) {
      pushNamed('story-editor', pathParameters: {'storyId': storyId});
    } else {
      pushNamed('new-story');
    }
  }
  
  void pushSceneEditor(String storyId, String sceneId) {
    pushNamed(
      'scene-editor',
      pathParameters: {'storyId': storyId, 'sceneId': sceneId},
    );
  }
  
  void pushAIGeneration(String type, {String? context}) {
    pushNamed(
      'ai-generation',
      queryParameters: {
        'type': type,
        if (context != null) 'context': context,
      },
    );
  }
}

// Route constants for type safety
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String profileSetup = '/auth/profile-setup';
  static const String home = '/home';
  static const String library = '/home/library';
  static const String community = '/home/community';
  static const String achievements = '/home/achievements';
  static const String settings = '/home/settings';
  static const String profile = '/home/settings/profile';
  static const String newStory = '/home/story/new';
  static const String aiGeneration = '/home/ai/generate';
  static const String error = '/error';
  
  // Dynamic routes
  static String storyPlayer(String storyId, {String? sceneId}) {
    final base = '/home/story/$storyId/play';
    return sceneId != null ? '$base?sceneId=$sceneId' : base;
  }
  
  static String storyEditor(String storyId) => '/home/story/$storyId/edit';
  
  static String sceneEditor(String storyId, String sceneId) =>
      '/home/story/$storyId/edit/scene/$sceneId';
}