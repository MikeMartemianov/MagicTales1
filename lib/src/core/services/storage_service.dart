import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/story.dart';
import '../models/scene.dart';
import '../models/user_profile.dart';

class StorageService {
  static Database? _database;
  static Box<Story>? _storiesBox;
  static Box<UserProfile>? _userProfilesBox;
  static Box<Map>? _settingsBox;

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    
    // Initialize Hive
    await Hive.initFlutter(appDocumentDir.path);
    
    // Open boxes
    _storiesBox = await Hive.openBox<Story>('stories');
    _userProfilesBox = await Hive.openBox<UserProfile>('user_profiles');
    _settingsBox = await Hive.openBox<Map>('settings');
    
    // Initialize SQLite for complex queries
    await _initDatabase();
  }

  static Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'fairy_tales.db');
    
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE stories (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        author_id TEXT NOT NULL,
        author_name TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        tags TEXT,
        is_public INTEGER DEFAULT 0,
        is_favorite INTEGER DEFAULT 0,
        play_count INTEGER DEFAULT 0,
        language TEXT DEFAULT 'en',
        age_group INTEGER DEFAULT 5,
        rating INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE scenes (
        id TEXT PRIMARY KEY,
        story_id TEXT NOT NULL,
        title TEXT NOT NULL,
        text TEXT NOT NULL,
        scene_order INTEGER NOT NULL,
        is_ending INTEGER DEFAULT 0,
        FOREIGN KEY (story_id) REFERENCES stories (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE user_progress (
        user_id TEXT,
        story_id TEXT,
        scene_id TEXT,
        completed_at INTEGER,
        PRIMARY KEY (user_id, story_id, scene_id)
      )
    ''');

    // Create indexes for better performance
    await db.execute('CREATE INDEX idx_stories_author ON stories(author_id)');
    await db.execute('CREATE INDEX idx_stories_language ON stories(language)');
    await db.execute('CREATE INDEX idx_stories_age_group ON stories(age_group)');
    await db.execute('CREATE INDEX idx_scenes_story ON scenes(story_id)');
    await db.execute('CREATE INDEX idx_user_progress_user ON user_progress(user_id)');
  }

  // Story operations
  static Future<void> saveStory(Story story) async {
    await _storiesBox?.put(story.id, story);
    
    // Also save to SQLite for querying
    await _database?.insert(
      'stories',
      {
        'id': story.id,
        'title': story.title,
        'description': story.description,
        'author_id': story.authorId,
        'author_name': story.authorName,
        'created_at': story.createdAt.millisecondsSinceEpoch,
        'updated_at': story.updatedAt.millisecondsSinceEpoch,
        'tags': story.tags.join(','),
        'is_public': story.isPublic ? 1 : 0,
        'is_favorite': story.isFavorite ? 1 : 0,
        'play_count': story.playCount,
        'language': story.language,
        'age_group': story.ageGroup.index,
        'rating': story.rating,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Save scenes
    for (final scene in story.scenes) {
      await _database?.insert(
        'scenes',
        {
          'id': scene.id,
          'story_id': story.id,
          'title': scene.title,
          'text': scene.text,
          'scene_order': scene.order,
          'is_ending': scene.isEnding ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<Story?> getStory(String id) async {
    return _storiesBox?.get(id);
  }

  static Future<List<Story>> getAllStories() async {
    return _storiesBox?.values.toList() ?? [];
  }

  static Future<List<Story>> getStoriesByAuthor(String authorId) async {
    final stories = await getAllStories();
    return stories.where((story) => story.authorId == authorId).toList();
  }

  static Future<List<Story>> searchStories({
    String? query,
    List<String>? tags,
    AgeGroup? ageGroup,
    String? language,
  }) async {
    var stories = await getAllStories();
    
    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      stories = stories.where((story) {
        return story.title.toLowerCase().contains(lowercaseQuery) ||
            story.description.toLowerCase().contains(lowercaseQuery) ||
            story.authorName.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }
    
    if (tags != null && tags.isNotEmpty) {
      stories = stories.where((story) {
        return tags.any((tag) => story.tags.contains(tag));
      }).toList();
    }
    
    if (ageGroup != null) {
      stories = stories.where((story) => story.ageGroup == ageGroup).toList();
    }
    
    if (language != null) {
      stories = stories.where((story) => story.language == language).toList();
    }
    
    return stories;
  }

  static Future<void> deleteStory(String id) async {
    await _storiesBox?.delete(id);
    await _database?.delete('stories', where: 'id = ?', whereArgs: [id]);
    await _database?.delete('scenes', where: 'story_id = ?', whereArgs: [id]);
  }

  // User profile operations
  static Future<void> saveUserProfile(UserProfile profile) async {
    await _userProfilesBox?.put(profile.id, profile);
  }

  static Future<UserProfile?> getUserProfile(String id) async {
    return _userProfilesBox?.get(id);
  }

  static Future<UserProfile?> getCurrentUserProfile() async {
    final currentUserId = await getCurrentUserId();
    if (currentUserId != null) {
      return getUserProfile(currentUserId);
    }
    return null;
  }

  static Future<void> deleteUserProfile(String id) async {
    await _userProfilesBox?.delete(id);
  }

  // Settings operations
  static Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox?.put(key, {'value': value});
  }

  static Future<T?> getSetting<T>(String key) async {
    final data = _settingsBox?.get(key);
    return data?['value'] as T?;
  }

  static Future<void> deleteSetting(String key) async {
    await _settingsBox?.delete(key);
  }

  // User session management
  static Future<void> setCurrentUserId(String userId) async {
    await saveSetting('current_user_id', userId);
  }

  static Future<String?> getCurrentUserId() async {
    return await getSetting<String>('current_user_id');
  }

  static Future<void> clearCurrentUser() async {
    await deleteSetting('current_user_id');
  }

  // Progress tracking
  static Future<void> saveUserProgress(
    String userId,
    String storyId,
    String sceneId,
  ) async {
    await _database?.insert(
      'user_progress',
      {
        'user_id': userId,
        'story_id': storyId,
        'scene_id': sceneId,
        'completed_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<String>> getUserCompletedScenes(
    String userId,
    String storyId,
  ) async {
    final result = await _database?.query(
      'user_progress',
      columns: ['scene_id'],
      where: 'user_id = ? AND story_id = ?',
      whereArgs: [userId, storyId],
    );
    
    return result?.map((row) => row['scene_id'] as String).toList() ?? [];
  }

  // Cache management
  static Future<void> clearCache() async {
    await _storiesBox?.clear();
    await _userProfilesBox?.clear();
    await _settingsBox?.clear();
    
    await _database?.delete('stories');
    await _database?.delete('scenes');
    await _database?.delete('user_progress');
  }

  static Future<void> dispose() async {
    await _storiesBox?.close();
    await _userProfilesBox?.close();
    await _settingsBox?.close();
    await _database?.close();
  }
}